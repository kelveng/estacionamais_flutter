import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/network/network_info.dart';
import 'package:estaciona_mais/app/features/extract/data/datasources/extract_datasource.dart';
import 'package:estaciona_mais/app/features/extract/data/repositories/extract_repository_impl.dart';
import 'package:estaciona_mais/app/features/extract/domain/repositories/extract_repository.dart';
import 'package:estaciona_mais/app/features/extract/domain/usecases/get_extract.dart';
import 'package:estaciona_mais/app/features/extract/external/api/extract_datasource_api.dart';
import 'package:estaciona_mais/app/features/extract/presentation/bloc/extract_cubit.dart';
import 'package:estaciona_mais/app/features/extract/presentation/pages/extract_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExtractModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => ExtractDataSourceApi(i.get<Dio>(), i.get<NetworkInfo>())),
    Bind((i) => ExtractRepositoryImpl(i.get<ExtractDataSource>())),
    Bind((i) => GetExtract(i.get<ExtractRepository>())),
    Bind.factory((i) => ExtractCubit(i.get<GetExtractUseCase>()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ExtractPage()),
  ];
}
