import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/get_all_spaces_usecase.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/process_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/bloc/space_management_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpaceManagementCubit extends Cubit<SpaceManagementState> {
  final GetAllSpacesUseCase useCase;
  final ProcessTicketUseCase processUseCase;
  List<Space> _spaces = [];

  SpaceManagementCubit(this.useCase, this.processUseCase)
      : super(InitialState([]));

  void loadSpaces() async {
    emit(LoadingState([]));
    final result = await useCase(NoParams());

    result.fold((error) {
      if (error is NoConnectionFailure)
        return emit(ErrorState([], "Sem conexao"));
      if (error is ServerFailure) return emit(ErrorState([], "Sem conexao"));
    }, (dashboard) {
      _spaces = dashboard;
      emit(SucessLoadSpacesState(_spaces));
    });
  }

  void selectSpace(Space space) {
    emit(RegisterEntryState(_spaces, space));
  }

  void createTicket(Space space, String place) async {
    emit(LoadingState([]));
    final result = await processUseCase(Params(space.id, place));

    result.fold((error) {
      if (error is NoConnectionFailure)
        return emit(ErrorProcessState(_spaces, place, space, "Sem conexao"));
      if (error is ServerFailure)
        return emit(ErrorProcessState(
            _spaces, place, space, "Erro ao processar ticket"));
    }, (dashboard) {
      return emit(
          ErrorProcessState(_spaces, place, space, "Erro ao processar ticket"));
    });
  }

  void backToMap() {
    emit(SucessLoadSpacesState(_spaces));
  }
}
