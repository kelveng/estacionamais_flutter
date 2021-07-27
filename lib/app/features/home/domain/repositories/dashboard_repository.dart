import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/home/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';

abstract class DashBoardRepository {
  Future<Either<Failure, Dashboard>> getDashBoard();
}
