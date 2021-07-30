import 'package:estaciona_mais/app/features/extract/data/datasources/extract_datasource.dart';
import 'package:estaciona_mais/app/features/extract/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';
import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/extract/domain/repositories/extract_repository.dart';

class ExtractRepositoryImpl implements ExtractRepository {
  final ExtractDataSource _dataSource;

  ExtractRepositoryImpl(this._dataSource);

  Future<Either<Failure, List<ResumeSpace>>> getExtract(DateTime date) async {
    try {
      final List<ResumeSpace> resumes = await _dataSource.getExtract(date);
      return Right(resumes);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
