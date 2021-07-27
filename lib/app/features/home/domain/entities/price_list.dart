import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:estaciona_mais/app/features/home/domain/entities/price.dart';

abstract class PriceList extends Equatable {
  final List<Price> prices;

  PriceList(
    this.prices,
  );

  @override
  List<Object> get props => [prices];
}
