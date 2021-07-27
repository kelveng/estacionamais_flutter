import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';
import 'package:estaciona_mais/app/features/home/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/home/domain/repositories/dashboard_repository.dart';
import 'package:estaciona_mais/app/features/home/domain/usecases/use_case.dart';

class GetDashBoardUseCaseImpl
    implements GetDashboardUseCase<Dashboard, NoParams> {
  final DashBoardRepository _repository;

  GetDashBoardUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, Dashboard>> call(NoParams noParams) async {
    return await _repository.getDashBoard();
  }
}
