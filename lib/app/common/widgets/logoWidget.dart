import 'package:estaciona_mais/app/common/icons/icons_app.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            child: Image.asset(
              IconsApp.logo,
              width: 60,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }
}
