import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Resources/myColors.dart';


Widget myButton({
  required BuildContext context,
  required VoidCallback? onTap,
  required String? btnName,
  dynamic prefix,
  int? colorType,
  Color? buttonColor,
  Color? borderColor,
}) {
  Color buttonBgColor;
  Color tittleColor;

  if (colorType == 1) {
    buttonBgColor = MyColor.primaryColor;
    tittleColor = MyColor.whiteGreyColor;
  } else if (colorType == 2) {
    buttonBgColor = MyColor.white;
    tittleColor = MyColor.whiteDarkGreyColor;
  }else if (colorType == 3) {
    buttonBgColor = MyColor.FaceBookDarkColor;
    tittleColor = MyColor.whiteGreyColor;
  }else if (colorType == 4) {
    buttonBgColor = MyColor.GetStartedGreyColor;
    tittleColor = MyColor.darkGreyColor;
  } else {
    buttonBgColor = MyColor.primaryColor;
    tittleColor = MyColor.whiteGreyColor;
  }
  return Container(
    width: MediaQuery.of(context).size.width,
    height: Get.height * 0.07,
    child: MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: MyColor.GetStartedBorderGreyColor, width: 1.0),
      ),
      textColor:tittleColor,
      color: buttonColor ?? buttonBgColor,
      onPressed: onTap,
      elevation: 3.0,
      child: Row(
        mainAxisAlignment: prefix != null ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          if (prefix != null) ...[
            _buildPrefixIcon(prefix),
            SizedBox(width: 45.0),
          ],
          Text(
            btnName!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Get.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPrefixIcon(dynamic prefix) {
  if (prefix is IconData) {
    return Icon(prefix);
  } else if (prefix is Image) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: SizedBox(
        width: 20,
        height: 20,
        child: prefix,
      ),
    );
  } else if (prefix is Widget) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: prefix,
    );
  }
  return SizedBox();
}
