import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/features/home/external/api/client/custom_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'common/network/network_info.dart';
import 'features/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => CustomDio().newDio()),
    Bind((i) => NetworkInfoImpl(DataConnectionChecker())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
