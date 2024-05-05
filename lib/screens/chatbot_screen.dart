import 'package:chatbot/screens/components/custom_app_bar.dart';
import 'package:chatbot/screens/components/custom_input_field.dart';
import 'package:chatbot/screens/components/custom_temp_display.dart';
import 'package:chatbot/screens/widgets/chat_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/message_provider.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (context, messageProvider, _) {
      return Scaffold(
        appBar: const MyAppBar(
          text: 'Chat',
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  child: Builder(
                    builder: (BuildContext context) {
                      if (messageProvider.messages.isEmpty) {
                        return const MyCustomDisplay();
                      }

                      return ChatDisplay(messages: messageProvider.messages);
                    },
                  ),
                ),
              ),
              MyInputField(
                inputController: _textEditingController,
                hintText: "What do you want to ask about?",
              )
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
      );
    });
  }
}
