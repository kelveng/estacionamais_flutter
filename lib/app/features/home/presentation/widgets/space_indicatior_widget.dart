import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SpaceIndicatorWidget extends StatelessWidget {
  final double max;
  final double current;
  final Color color;
  final CrossFadeState xFadeState = CrossFadeState.showSecond;

  const SpaceIndicatorWidget(
      {Key key,
      @required this.max,
      @required this.current,
      this.color = Colors.green})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double percent = current / max;
    return Container(
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
      height: 120,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vagas Ocupadas",
                  style: TextStyles.titleIndicator,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: percent,
              center: Text("$current"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: color,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "0",
                    style: TextStyles.titleIndicator,
                  ),
                  Text(
                    "$max",
                    style: TextStyles.titleIndicator,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
