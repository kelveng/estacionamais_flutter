import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/common/widgets/logoWidget.dart';
import 'package:flutter/material.dart';

class InfoAppBarWidget extends StatelessWidget {
  const InfoAppBarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Text("ESTACIONA+", style: TextStyles.appNameBold)],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(text: "Olá, ", style: TextStyles.titleRegular, children: [
              TextSpan(
                  text: "Jose Carlos", style: TextStyles.titleBoldBackground)
            ]),
          ),
        ],
      ),
    ]));
  }
}
