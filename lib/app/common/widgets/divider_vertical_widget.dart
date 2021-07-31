import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DividerVerticalWidget extends StatelessWidget {
  const DividerVerticalWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.greyLight,
    );
  }
}
