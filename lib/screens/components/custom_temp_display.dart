import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/asset_data.dart';
import '../../constants/colors.dart';

class MyCustomDisplay extends StatelessWidget {
  const MyCustomDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetData.chatgptPath,
          colorFilter: const ColorFilter.mode(
            ColorApp.inputField,
            BlendMode.srcATop,
          ),
          width: 200,
          height: 200,
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "How can I help you?",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
