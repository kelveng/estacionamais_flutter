import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/common/utils/datetime_utils.dart';
import 'package:estaciona_mais/app/common/widgets/divider_vertical_widget.dart';
import 'package:flutter/material.dart';

class FilterDateWidget extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback onPressBack;
  final VoidCallback onPressNext;
  const FilterDateWidget(
      {Key key, this.dateTime, this.onPressBack, this.onPressNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DividerVerticalWidget(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: onPressBack,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "<<",
                  style: TextStyles.textFilterDate,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${DateTimeUtils.getDayMonthText(dateTime)}",
                style: TextStyles.textFilterDate,
              ),
            ),
            GestureDetector(
              onTap: onPressNext,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ">>",
                  style: TextStyles.textFilterDate,
                ),
              ),
            ),
          ]),
          DividerVerticalWidget(),
        ],
      ),
    );
  }
}
