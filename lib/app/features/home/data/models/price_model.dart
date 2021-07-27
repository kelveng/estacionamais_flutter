import 'dart:convert';

import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';

class PriceModel extends Price {
  final int entryHour;
  final int exitHour;
  final double price;

  PriceModel(
    this.entryHour,
    this.exitHour,
    this.price,
  ) : super(entryHour, exitHour, price);

  PriceModel copyWith({
    int entryHour,
    int exitHour,
    double price,
  }) {
    return PriceModel(
      entryHour ?? this.entryHour,
      exitHour ?? this.exitHour,
      price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'entryHour': entryHour,
      'exitHour': exitHour,
      'price': price,
    };
  }

  factory PriceModel.fromMap(Map<String, dynamic> map) {
    return PriceModel(
      map['entryHour'],
      map['exitHour'],
      map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PriceModel.fromJson(String source) =>
      PriceModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Price(entryHour: $entryHour, exitHour: $exitHour, price: $price)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Price &&
        other.entryHour == entryHour &&
        other.exitHour == exitHour &&
        other.price == price;
  }

  @override
  int get hashCode => entryHour.hashCode ^ exitHour.hashCode ^ price.hashCode;
}
