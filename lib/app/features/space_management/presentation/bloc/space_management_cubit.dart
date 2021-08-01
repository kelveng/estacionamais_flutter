import 'package:estaciona_mais/app/features/space_management/domain/entities/entities.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/cancel_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/get_all_spaces_usecase.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/get_hour_server.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/get_ticket_by_id.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/payment_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/process_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/bloc/space_management_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceManagementCubit extends Cubit<SpaceManagementState> {
  final GetAllSpacesUseCase _allSpaceUseCase;
  final ProcessTicketUseCase _processUseCase;
  final GetHourServerUseCase _getHourServerUseCase;
  final GetTicketByIdUseCase _getTicketUseCase;
  final PaymentTicketUseCase _paymentTicketUseCase;
  final CancelTicketUseCase _cancelTicketUseCase;
  List<Space> _spaces = [];

  SpaceManagementCubit(
      this._allSpaceUseCase,
      this._processUseCase,
      this._getHourServerUseCase,
      this._getTicketUseCase,
      this._paymentTicketUseCase,
      this._cancelTicketUseCase)
      : super(InitialState([]));

  void loadSpaces() async {
    emit(LoadingState([]));
    final result = await _allSpaceUseCase(NoParams());

    result.fold((error) {
      if (error is NoConnectionFailure)
        return emit(ErrorState([], "Sem conexao"));
      if (error is ServerFailure)
        return emit(ErrorState([], "Erro no servidor."));
    }, (dashboard) {
      _spaces = dashboard;
      emit(SucessLoadSpacesState(_spaces));
    });
  }

  void selectSpace(Space space) async {
    if (!space.isBusy) {
      emit(LoadingState([]));
      final result = await _getHourServerUseCase(NoParam());
      result.fold((error) {
        if (error is NoConnectionFailure)
          return emit(ErrorProcessState(_spaces, "", space, "Sem conexao"));
        if (error is ServerFailure)
          return emit(ErrorProcessState(
              _spaces, "", space, "Nao foi possivel obter hora."));
      }, (hour) {
        return emit(RegisterEntryState(_spaces, space, false, hour));
      });
    } else {
      emit(LoadingState([]));
      final result = await _getTicketUseCase(ParamsId(space.ticketId));
      result.fold((error) {
        if (error is NoConnectionFailure)
          return emit(
              ManagmentTicketState(_spaces, space, null, false, "Sem conexao"));
        if (error is ServerFailure)
          return emit(ManagmentTicketState(
              _spaces, space, null, false, "Erro ao obter ticket"));
      }, (ticket) {
        return emit(ManagmentTicketState(_spaces, space, ticket, false, ""));
      });
    }
  }

  void createTicket(Space space, String place) async {
    emit(LoadingState([]));
    final result = await _processUseCase(Params(space.id, place));

    result.fold((error) {
      if (error is NoConnectionFailure)
        return emit(ErrorProcessState(_spaces, place, space, "Sem conexao"));
      if (error is ServerFailure)
        return emit(ErrorProcessState(
            _spaces, place, space, "Erro ao processar ticket"));
      if (error is InvalidPlaceFailure)
        return emit(ErrorProcessState(_spaces, place, space, "Placa inválida"));
      if (error is InvalidSpaceFailure)
        return emit(ErrorProcessState(_spaces, place, space, "Vaga inválida"));
    }, (dashboard) {
      return loadSpaces();
    });
  }

  void paymentTicket(Space space, Ticket ticket) async {
    emit(LoadingState(_spaces));
    final result = await _paymentTicketUseCase(ticket);

    result.fold((error) {
      if (error is NoConnectionFailure)
        return emit(
            ManagmentTicketState(_spaces, space, ticket, false, "Sem conexao"));
      if (error is InvalidTicketFailure)
        return emit(ManagmentTicketState(
            _spaces, space, ticket, false, "Ticket invalido"));
      if (error is InvalidSpaceFailure)
        return emit(ManagmentTicketState(
            _spaces, space, ticket, false, "Vaga invalida"));
      if (error is Failure)
        return emit(ManagmentTicketState(_spaces, space, ticket, false,
            "Servidor falhou ao processar pagamento."));
    }, (_) {
      return loadSpaces();
    });
  }

  void cancelTicket(Space space, Ticket ticket) async {
    emit(LoadingState(_spaces));
    final result = await _cancelTicketUseCase(ticket);

    result.fold((error) {
      if (error is NoConnectionFailure)
        return emit(
            ManagmentTicketState(_spaces, space, ticket, false, "Sem conexao"));
      if (error is InvalidTicketFailure)
        return emit(ManagmentTicketState(
            _spaces, space, ticket, false, "Ticket invalido"));
      if (error is InvalidSpaceFailure)
        return emit(ManagmentTicketState(
            _spaces, space, ticket, false, "Vaga invalida"));

      if (error is TicketProcessedFailure)
        return emit(ManagmentTicketState(
            _spaces, space, ticket, false, "Ticket processado anteriomente"));
      if (error is Failure)
        return emit(ManagmentTicketState(_spaces, space, ticket, false,
            "Servidor falhou ao processar pagamento."));
    }, (_) {
      return loadSpaces();
    });
  }

  void backToMap() {
    emit(SucessLoadSpacesState(_spaces));
  }
}
