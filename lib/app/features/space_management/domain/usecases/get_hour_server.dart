import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';

abstract class GetHourServerUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParam extends Equatable {
  @override
  List<Object> get props => [];
}

class GetHourServerImpl extends GetHourServerUseCase<String, NoParam> {
  final SpaceManagementRepository repository;

  GetHourServerImpl(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParam params) async {
    return await repository.getHourNow();
  }
}
