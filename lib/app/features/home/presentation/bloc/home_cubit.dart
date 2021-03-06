import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:estaciona_mais/app/features/home/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/home/domain/usecases/use_case.dart';
import 'package:estaciona_mais/app/features/home/presentation/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetDashboardUseCase getDashboardUseCase;

  HomeCubit({this.getDashboardUseCase}) : super(InitialState());

  void loadDashboard() async {
    emit(LoadingState());
    final result = await getDashboardUseCase(NoParams());

    result.fold((error) {
      if (error is NoConnectionFailure) return emit(ErrorState("Sem conexao"));
      if (error is Failure) return emit(ErrorState("Servidor falhou"));
    }, (dashboard) => emit(SucessState(dashboard)));
  }
}
