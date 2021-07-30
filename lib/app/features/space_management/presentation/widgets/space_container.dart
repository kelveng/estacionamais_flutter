import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class SpaceContainer extends StatelessWidget {
  final String title;
  final double size;
  final bool isFree;
  const SpaceContainer({Key key, this.title, this.size, this.isFree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        alignment: Alignment.center,
        height: size,
        width: size,
        color: isFree ? Colors.red : Colors.green,
        child: Text(
          title,
          style: TextStyles.subTitleWhith,
        ),
      ),
    );
  }
}
