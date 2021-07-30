import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/extract/data/datasources/extract_datasource.dart';
import 'package:estaciona_mais/app/features/extract/data/models/resume_space_model.dart';
import 'package:estaciona_mais/app/features/extract/data/repositories/extract_repository_impl.dart';
import 'package:estaciona_mais/app/features/extract/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/extract/domain/repositories/extract_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'extract_repository_impl_test.mocks.dart';

@GenerateMocks([ExtractDataSource])
void main() {
  final ExtractDataSource dataSource = MockExtractDataSource();
  final ExtractRepository repository = ExtractRepositoryImpl(dataSource);
  group("getExtract", () {
    test("Should get a NoConnectionFailure error", () async {
      when(dataSource.getExtract(any)).thenThrow(NoConnectionFailure());
      final result = await repository.getExtract(DateTime.now());
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<NoConnectionFailure>());
    });
    test("Should get a ServerFailure error", () async {
      when(dataSource.getExtract(any))
          .thenThrow(ServerFailure(code: "01", message: "error"));
      final result = await repository.getExtract(DateTime.now());
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });
    test("Should get a Generic error", () async {
      when(dataSource.getExtract(any)).thenThrow(GenericFailure());
      final result = await repository.getExtract(DateTime.now());
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<GenericFailure>());
    });

    test("Should get a List of ResumeSpace", () async {
      List<ResumeSpaceModel> resumes = [
        ResumeSpaceModel(1, "A1", 10.20),
        ResumeSpaceModel(2, "A2", 20.20)
      ];

      when(dataSource.getExtract(any))
          .thenAnswer((realInvocation) async => Future.value(resumes));
      final result = await repository.getExtract(DateTime.now());
      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r), isA<List<ResumeSpaceModel>>());
    });
  });
}
