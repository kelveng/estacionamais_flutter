import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/common/utils/money_format.dart';
import 'package:flutter/material.dart';

class AmountWidget extends StatelessWidget {
  final double amount;
  const AmountWidget({Key key, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
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
    );
  }
}
