import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';
import 'package:estaciona_mais/app/features/extract/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/extract/domain/repositories/extract_repository.dart';

abstract class GetExtractUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class GetExtract extends GetExtractUseCase<List<ResumeSpace>, Params> {
  final ExtractRepository _repository;

  GetExtract(this._repository);

  @override
  Future<Either<Failure, List<ResumeSpace>>> call(Params params) async {
    return await _repository.getExtract(params.date);
  }
}

class Params extends Equatable {
  final DateTime date;

  Params(this.date);

  @override
  List<Object> get props => [date];
}
