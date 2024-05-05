import 'package:chatbot/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/message_model.dart';
import 'messages_display.dart';

class ChatDisplay extends StatefulWidget {
  final List<Message> messages;

  const ChatDisplay({super.key, required this.messages});

  @override
  State<ChatDisplay> createState() => _ChatDisplayState();
}

class _ChatDisplayState extends State<ChatDisplay> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: context.read<MessageProvider>().scrollController,
      itemCount: widget.messages.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemBuilder: (context, index) {
        Message message = widget.messages[index];
        return DisplayMessages(
          message: message,
        );
      },
    );
  }
}
