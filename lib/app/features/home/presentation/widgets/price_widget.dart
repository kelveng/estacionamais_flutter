import 'package:estaciona_mais/app/common/components/dashboard_container_component.dart';
import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/common/utils/money_format.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/price.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final double height;
  final List<Price> prices;

  const PriceWidget({
    Key key,
    this.prices,
    this.height,
  }) : super(key: key);

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
                  "Valores",
                  style: TextStyles.titleIndicator,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [for (var item in prices) _price(item)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _price(Price price) {
    return RichText(
        text: TextSpan(
            text: "${price.entryHour}h até ${price.exitHour}h",
            style: TextStyles.subTitleWhith,
            children: <TextSpan>[
          TextSpan(
            text: "  ${MoneyFormatter.format(price.price)}",
            style: TextStyles.subTitleGreen,
          )
        ]));
  }
}
