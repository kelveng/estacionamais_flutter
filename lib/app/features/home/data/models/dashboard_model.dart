import 'dart:convert';

import 'package:estaciona_mais/app/features/home/data/models/price_list_model.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';

import 'balance_resume_model.dart';
import 'capacity_space_model.dart';

class DashBoardModel extends Dashboard {
  DashBoardModel(CapacitySpaceModel capacitySpace, PriceListModel priceList,
      BalanceResumeModel balanceResume)
      : super(capacitySpace, priceList, balanceResume);

  Dashboard copyWith({
    CapacitySpaceModel capacitySpace,
    PriceListModel priceList,
    BalanceResumeModel balanceResume,
  }) {
    return DashBoardModel(
      capacitySpace ?? this.capacitySpace,
      priceList ?? this.priceList,
      balanceResume ?? this.balanceResume,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'capacitySpace': (capacitySpace as CapacitySpaceModel).toMap(),
      'priceList': (priceList as PriceListModel).toMap(),
      'balanceResume': (balanceResume as BalanceResumeModel).toMap(),
    };
  }

  factory DashBoardModel.fromMap(Map<String, dynamic> map) {
    return DashBoardModel(
      CapacitySpaceModel.fromMap(map['data']['capacitySpace']),
      PriceListModel.fromMap(map['data']),
      BalanceResumeModel.fromMap(map['data']['balance']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashBoardModel.fromJson(String source) =>
      DashBoardModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
