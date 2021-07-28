import 'package:estaciona_mais/app/common/components/dashboard_container_component.dart';
import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SpaceIndicatorWidget extends StatelessWidget {
  final double height;
  final int max;
  final int current;
  final Color color;
  final CrossFadeState xFadeState = CrossFadeState.showSecond;

  const SpaceIndicatorWidget(
      {Key key,
      @required this.max,
      @required this.current,
      this.color = Colors.green,
      this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double percent = current / max;
    return DashboardContainerComponent(
      height: height,
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
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mapa",
                  style: TextStyles.subTitleIndicator,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
