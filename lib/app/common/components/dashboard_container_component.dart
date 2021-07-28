import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardContainerComponent extends StatelessWidget {
  final double height;
  final Widget child;
  const DashboardContainerComponent({Key key, this.height, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.shadow,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: child,
    );
  }
}
