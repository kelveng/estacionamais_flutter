import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/use_case.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';

class GetAllSpacesUseCaseImpl extends UseCase<List<Space>, NoParams> {
  final SpaceManagementRepository repository;

  GetAllSpacesUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<Space>>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
