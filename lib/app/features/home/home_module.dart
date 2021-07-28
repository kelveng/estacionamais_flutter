import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/network/network_info.dart';
import 'package:estaciona_mais/app/features/home/data/datasources/dashboard_datasource.dart';
import 'package:estaciona_mais/app/features/home/data/repositories/dashboard_repository_impl.dart';
import 'package:estaciona_mais/app/features/home/domain/repositories/dashboard_repository.dart';
import 'package:estaciona_mais/app/features/home/domain/usecases/get_dashboard_usecase.dart';
import 'package:estaciona_mais/app/features/home/domain/usecases/use_case.dart';
import 'package:estaciona_mais/app/features/home/external/api/dashboard_datasource_api.dart';
import 'package:estaciona_mais/app/features/home/presentation/bloc/home_cubit.dart';
import 'package:estaciona_mais/app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => DashboardDataSourceApi(i.get<Dio>(), i.get<NetworkInfo>())),
    Bind((i) => DashboardRepositoryImpl(i.get<DashboardDataSource>())),
    Bind((i) => GetDashBoardUseCaseImpl(i.get<DashBoardRepository>())),
    Bind.factory(
        (i) => HomeCubit(getDashboardUseCase: i.get<GetDashboardUseCase>()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
