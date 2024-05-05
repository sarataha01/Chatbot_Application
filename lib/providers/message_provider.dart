import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/message_model.dart';

class MessageProvider extends ChangeNotifier {
  List<Message> messages = [];
  bool botSent = false;
  final ScrollController scrollController = ScrollController();

  void addMessage(Message message) {
    messages.add(message);
    notifyListeners();
  }

  Future<void> userMessage(String message) async {
    addMessage(Message(text: message, user: true));
    botSent = true;
    final Message response = await waitResponse(message);
    addMessage(response);
    botSent = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
      );
    });
    notifyListeners();
  }

  Future<Message> waitResponse(String message) async {
    const String endpoint =
        'https://api.deepinfra.com/v1/inference/meta-llama/Llama-2-70b-chat-hf';
    const String apiKey = 'ckjGprTUzI5CZAPChPLrCRDvMAHUkFcr';
    final Dio dio = Dio();

    final Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final Map<String, dynamic> body = {
      'input': '[INST] $message [/INST] ',
    };

    final Response response = await dio.post(
      endpoint,
      data: body,
      options: Options(headers: headers),
    );

    //print(response.data);
    //return Message(text: "text", user: false);
    return Message(
        text: response.data["results"][0]["generated_text"].toString(),
        user: false);
  }
}
