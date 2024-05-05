import 'package:chatbot/constants/asset_data.dart';
import 'package:chatbot/constants/colors.dart';
import 'package:chatbot/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../models/message_model.dart';

class DisplayMessages extends StatelessWidget {
  final Message message;

  const DisplayMessages({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (context, messageProvider, _) {
      return Row(
        mainAxisAlignment:
            message.user ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.user) _buildAvatar(),
          const SizedBox(
            width: 10,
          ),
          _buildMessageBubble(),
          const SizedBox(
            width: 10,
          ),
          if (message.user) _buildAvatar(),
        ],
      )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 200),
          )
          .slideY(
              curve: Curves.easeInOut,
              begin: 1,
              end: 0,
              duration: const Duration(milliseconds: 200));
    });
  }

  Widget _buildAvatar() {
    return CircleAvatar(
        backgroundColor: message.user ? ColorApp.appText : ColorApp.buttonColor,
        child: message.user
            ? const Icon(Icons.person, color: ColorApp.mainColor)
            : SvgPicture.asset(
                AssetData.chatgptPath,
                colorFilter: const ColorFilter.mode(
                    ColorApp.inputField, BlendMode.srcATop),
                width: 30,
                height: 30,
              ));
  }

  Widget _buildMessageBubble() {
    return Consumer<MessageProvider>(builder: (context, messageProvider, _) {
      return Flexible(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: message.user ? ColorApp.buttonColor : ColorApp.sideColor,
          ),
          child: Text(
            message.text,
            style: const TextStyle(fontSize: 18),
            overflow: TextOverflow.clip,
          ),
        ),
      );
    });
  }
}
