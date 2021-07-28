import 'package:estaciona_mais/app/common/components/dashboard_container_component.dart';
import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/common/utils/datetime_utils.dart';
import 'package:estaciona_mais/app/common/utils/money_format.dart';
import 'package:flutter/material.dart';

class BalanceResumeWidget extends StatelessWidget {
  final double height;
  final double amount;
  final DateTime date;
  const BalanceResumeWidget({Key key, this.amount, this.date, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "Resumo dia ${DateTimeUtils.getDateText(date)}",
                  style: TextStyles.titleIndicator,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MoneyFormatter.format(amount),
                  style: TextStyles.amountIndicator,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Visualizar extrato",
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
