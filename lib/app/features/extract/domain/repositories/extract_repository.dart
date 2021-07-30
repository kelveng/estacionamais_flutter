import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';
import 'package:estaciona_mais/app/features/extract/domain/exceptions/failure.dart';

abstract class ExtractRepository {
  Future<Either<Failure, List<ResumeSpace>>> getExtract(DateTime date);
}
