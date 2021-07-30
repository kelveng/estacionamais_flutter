import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/home/data/datasources/dashboard_datasource.dart';
import 'package:estaciona_mais/app/features/home/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/home/data/models/dashboard_model.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/dashboard.dart';
import 'package:estaciona_mais/app/features/home/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashBoardRepository {
  final DashboardDataSource dashboardDataSource;

  DashboardRepositoryImpl(this.dashboardDataSource);

  @override
  Future<Either<Failure, Dashboard>> getDashBoard() async {
    try {
      final DashBoardModel dashboardModel =
          await dashboardDataSource.getDashboard();
      return Right(dashboardModel);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
