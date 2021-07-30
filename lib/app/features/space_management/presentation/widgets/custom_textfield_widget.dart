import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool enable;
  final String initialValue;
  const CustomTextFieldWidget(
      {Key key,
      this.controller,
      this.title,
      this.hintText,
      this.enable = true,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyles.titleBoldProcessTicket,
        ),
        Container(
          width: 150,
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.greyLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            initialValue: initialValue,
            maxLines: 1,
            enabled: enable,
            inputFormatters: [UpperCaseTextFormatter()],
            textAlign: TextAlign.center,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
