import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class CapacitySpace extends Equatable {
  final int totalParkingLotsCount;
  final int occupiedParkingLots;

  CapacitySpace(
    this.totalParkingLotsCount,
    this.occupiedParkingLots,
  );

  @override
  List<Object> get props => [totalParkingLotsCount, occupiedParkingLots];
}
