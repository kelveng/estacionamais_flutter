import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/network/network_info.dart';
import 'package:estaciona_mais/app/features/space_management/data/datasources/space_management_datasource.dart';
import 'package:estaciona_mais/app/features/space_management/data/repositories/space_management_repository_impl.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/cancel_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/get_all_spaces_usecase.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/get_hour_server.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/get_ticket_by_id.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/payment_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/process_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/external/api/space_management_datasource_impl.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/bloc/space_management_cubit.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/pages/space_management_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/space_management_repository.dart';

class SpaceManamentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) =>
        SpaceManagamentDataSourceImpl(i.get<Dio>(), i.get<NetworkInfo>())),
    Bind((i) =>
        SpaceManagementRepositoryImpl(i.get<SpaceManagementDataSource>())),
    Bind((i) => GetAllSpacesUseCaseImpl(i.get<SpaceManagementRepository>())),
    Bind((i) => ProcessTicket(i.get<SpaceManagementRepository>())),
    Bind((i) => GetHourServerImpl(i.get<SpaceManagementRepository>())),
    Bind((i) => GetTicketById(i.get<SpaceManagementRepository>())),
    Bind((i) => PaymentTicket(i.get<SpaceManagementRepository>())),
    Bind((i) => CancelTicket(i.get<SpaceManagementRepository>())),
    Bind.factory((i) => SpaceManagementCubit(
        i.get<GetAllSpacesUseCase>(),
        i.get<ProcessTicketUseCase>(),
        i.get<GetHourServerUseCase>(),
        i.get<GetTicketByIdUseCase>(),
        i.get<PaymentTicketUseCase>(),
        i.get<CancelTicketUseCase>()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SpaceManagamentPage()),
  ];
}
