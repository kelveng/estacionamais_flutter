import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/network/network_info.dart';
import 'package:estaciona_mais/app/features/home/data/datasources/dashboard_datasource.dart';
import 'package:estaciona_mais/app/features/home/data/models/dashboard_model.dart';
import 'package:estaciona_mais/app/features/home/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/home/external/api/dashboard_datasource_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dashboard_datasource_api_test.mocks.dart';

@GenerateMocks([Dio, NetworkInfo])
void main() {
  final MockDio mockDio = MockDio();
  final NetworkInfo networkInfo = MockNetworkInfo();
  final DashboardDataSource dataSource =
      DashboardDataSourceApi(mockDio, networkInfo);

  group("Dashboard data source suit tests", () {
    test("Should get a ResourceNotFoundFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 404)));

      expect(() async => await dataSource.getDashboard(),
          throwsA(isA<ResourceNotFoundFailure>()));
    });

    test("Should get a ServerFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.getDashboard(),
          throwsA(isA<ServerFailure>()));
    });

    test("Should get a NoConnectionFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.getDashboard(),
          throwsA(isA<NoConnectionFailure>()));
    });

    test("Should get a DashBoardModel", () async {
      final file = new File('test/resources/dashboard.json');
      final jsonResponse = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.get(any)).thenAnswer((realInvocation) async =>
          await Response(statusCode: 200, data: jsonResponse));

      final result = await dataSource.getDashboard();

      expect(result, isA<DashBoardModel>());
    });
  });
}
