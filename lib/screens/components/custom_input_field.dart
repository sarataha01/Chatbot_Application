import 'package:chatbot/constants/asset_data.dart';
import 'package:chatbot/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/message_provider.dart';

class MyInputField extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;

  const MyInputField({
    super.key,
    required this.inputController,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(builder: (context, messageProvider, _) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: ColorApp.inputField),
          color: ColorApp.mainColor,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                AssetData.chatgptPath,
                colorFilter: const ColorFilter.mode(
                  ColorApp.inputField,
                  BlendMode.srcATop,
                ),
                width: 30,
                height: 30,
              ),
            ),
            Expanded(
              child: TextField(
                controller: inputController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                ),
              ),
            ),
            InkWell(
              child: CircleAvatar(
                backgroundColor: ColorApp.buttonColor,
                radius: 17,
                child: messageProvider.botSent
                    ? const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: ColorApp.inputField,
                        ),
                      )
                    : const Icon(
                        Icons.send,
                        size: 20,
                        color: ColorApp.inputField,
                      ),
              ),
              onTap: () {
                if (inputController.text.isEmpty) {
                  return;
                }
                messageProvider.userMessage(inputController.text);
                inputController.clear();
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  messageProvider.scrollController.animateTo(
                    messageProvider.scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.fastOutSlowIn,
                  );
                });
              },
            ),
          ],
        ),
      );
    });
  }
}
