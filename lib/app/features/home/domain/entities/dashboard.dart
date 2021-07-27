import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:estaciona_mais/app/features/home/domain/entities/balance_resume.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/capacity_space.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/price_list.dart';

abstract class Dashboard extends Equatable {
  final CapacitySpace capacitySpace;
  final PriceList priceList;
  final BalanceResume balanceResume;

  Dashboard(
    this.capacitySpace,
    this.priceList,
    this.balanceResume,
  );

  @override
  List<Object> get props => [capacitySpace, priceList, balanceResume];
}
