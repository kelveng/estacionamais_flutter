import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
          primarySwatch: Colors.orange, primaryColor: AppColors.primary),
    ).modular();
  }
}
