import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/home/data/datasources/dashboard_datasource.dart';
import 'package:estaciona_mais/app/features/home/data/models/balance_resume_model.dart';
import 'package:estaciona_mais/app/features/home/data/models/capacity_space_model.dart';
import 'package:estaciona_mais/app/features/home/data/models/dashboard_model.dart';
import 'package:estaciona_mais/app/features/home/data/models/price_list_model.dart';
import 'package:estaciona_mais/app/features/home/data/models/price_model.dart';
import 'package:estaciona_mais/app/features/home/data/repositories/dashboard_repository_impl.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';
import 'package:estaciona_mais/app/features/home/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/home/domain/repositories/dashboard_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dashboard_repository_impl_test.mocks.dart';

@GenerateMocks([DashboardDataSource])
void main() {
  MockDashboardDataSource datasourceMock;
  DashBoardRepository repository;

  setUp(() {
    datasourceMock = MockDashboardDataSource();
    repository = DashboardRepositoryImpl(datasourceMock);
  });

  group("Dashboard repository suit tests", () {
    test("Should get a NoConnectionFailure error", () async {
      when(datasourceMock.getDashboard()).thenThrow(NoConnectionFailure());
      final result = await repository.getDashBoard();
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<NoConnectionFailure>());
    });
    test("Should get a ServerFailure error", () async {
      when(datasourceMock.getDashboard())
          .thenThrow(ServerFailure(code: "01", message: "error"));
      final result = await repository.getDashBoard();
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });
    test("Should get a Generic error", () async {
      when(datasourceMock.getDashboard()).thenThrow(GenericFailure());
      final result = await repository.getDashBoard();
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<GenericFailure>());
    });

    test("Should get a BalanceResume", () async {
      BalanceResumeModel balanceResumeModel =
          BalanceResumeModel(amount: 10, date: DateTime.now());
      List<PriceModel> prices = [
        PriceModel(0, 1, 1.50),
        PriceModel(1, 2, 2.50)
      ];
      DashBoardModel dashBoardModel = DashBoardModel(CapacitySpaceModel(10, 5),
          PriceListModel(prices), balanceResumeModel);
      when(datasourceMock.getDashboard())
          .thenAnswer((realInvocation) async => Future.value(dashBoardModel));
      final result = await repository.getDashBoard();
      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r), isA<DashBoardModel>());
    });
  });
}
