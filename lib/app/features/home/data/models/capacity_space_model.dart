import 'dart:convert';

import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';

class CapacitySpaceModel extends CapacitySpace {
  CapacitySpaceModel(int totalParkingLotsCount, int occupiedParkingLots)
      : super(totalParkingLotsCount, occupiedParkingLots);

  CapacitySpace copyWith({
    int totalParkingLotsCount,
    int occupiedParkingLots,
  }) {
    return CapacitySpaceModel(
      totalParkingLotsCount ?? this.totalParkingLotsCount,
      occupiedParkingLots ?? this.occupiedParkingLots,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalParkingLotsCount': totalParkingLotsCount,
      'occupiedParkingLots': occupiedParkingLots,
    };
  }

  factory CapacitySpaceModel.fromMap(Map<String, dynamic> map) {
    return CapacitySpaceModel(
      map['totalParkingLotsCount'],
      map['occupiedParkingLots'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CapacitySpaceModel.fromJson(String source) =>
      CapacitySpaceModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
