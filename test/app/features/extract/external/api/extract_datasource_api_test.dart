import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/network/network_info.dart';
import 'package:estaciona_mais/app/features/extract/data/datasources/extract_datasource.dart';
import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';
import 'package:estaciona_mais/app/features/extract/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/extract/external/api/extract_datasource_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'extract_datasource_api_test.mocks.dart';

@GenerateMocks([Dio, NetworkInfo])
void main() {
  final NetworkInfo networkInfo = MockNetworkInfo();
  final Dio mockDio = MockDio();
  final ExtractDataSource dataSource =
      ExtractDataSourceApi(mockDio, networkInfo);
  group("getExtract", () {
    DateTime date = DateTime.now();
    test("Should get a ResourceNotFoundFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 404)));

      expect(() async => await dataSource.getExtract(date),
          throwsA(isA<ResourceNotFoundFailure>()));
    });

    test("Should get a ServerFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.getExtract(date),
          throwsA(isA<ServerFailure>()));
    });

    test("Should get a NoConnectionFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 200)));

      expect(() async => await dataSource.getExtract(date),
          throwsA(isA<NoConnectionFailure>()));
    });

    test("Should get a List of ResumeSpace", () async {
      final file = new File('test/resources/resumes_spaces.json');
      final jsonResponse = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.get(any)).thenAnswer((realInvocation) async =>
          await Response(statusCode: 200, data: jsonResponse));

      final result = await dataSource.getExtract(date);

      expect(result, isA<List<ResumeSpace>>());
    });
  });
}
