import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/navagate/routes.dart';
import 'package:estaciona_mais/app/features/home/home_module.dart';
import 'package:estaciona_mais/app/features/space_management/space_management_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'common/network/network_info.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio(BaseOptions(
        baseUrl: 'https://estacionamaisbackend.herokuapp.com/api'))),
    Bind((i) => NetworkInfoImpl(DataConnectionChecker())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Routes.home, module: HomeModule()),
    ModuleRoute(Routes.spaceManagament, module: SpaceManamentModule()),
  ];
}
