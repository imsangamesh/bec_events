import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/themes/my_colors.dart';

class TextFieldWrapper extends StatelessWidget {
  const TextFieldWrapper(this.widget, this.icon, {super.key});

  final Widget widget;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? MyColors.darkPurple : MyColors.lightPink,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Get.isDarkMode ? MyColors.lightPurple : MyColors.darkPink,
          ),
          const SizedBox(width: 10),
          Expanded(child: widget),
        ],
      ),
    );
  }
}
