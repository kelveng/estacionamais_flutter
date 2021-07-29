import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';

abstract class GetAllSpacesUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllSpacesUseCaseImpl
    extends GetAllSpacesUseCase<List<Space>, NoParams> {
  final SpaceManagementRepository repository;

  GetAllSpacesUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<Space>>> call(NoParams params) async {
    return await repository.getAllSpaces();
  }
}
