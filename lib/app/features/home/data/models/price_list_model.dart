import 'dart:convert';

import 'package:estaciona_mais/app/features/home/data/models/price_model.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';

class PriceListModel extends PriceList {
  PriceListModel(List<PriceModel> prices) : super(prices);
  PriceList copyWith({
    List<PriceModel> prices,
  }) {
    return PriceListModel(
      prices ?? this.prices,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prices': prices?.map((x) => (x as PriceModel).toMap())?.toList(),
    };
  }

  factory PriceListModel.fromMap(Map<String, dynamic> map) {
    return PriceListModel(
      List<PriceModel>.from(map['prices']?.map((x) => PriceModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceListModel.fromJson(String source) =>
      PriceListModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
