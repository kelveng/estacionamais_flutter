import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';

abstract class SpaceManagementRepository {
  Future<Either<Failure, List<Space>>> getAllSpaces();
}
