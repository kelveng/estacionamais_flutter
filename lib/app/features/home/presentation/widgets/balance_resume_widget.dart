import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/common/utils/datetime_utils.dart';
import 'package:estaciona_mais/app/common/utils/money_format.dart';
import 'package:flutter/material.dart';

class BalanceResumeWidget extends StatelessWidget {
  final double amount;
  final DateTime date;
  const BalanceResumeWidget({Key key, this.amount, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      height: 130,
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
