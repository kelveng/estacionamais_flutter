import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';
import 'package:estaciona_mais/app/features/extract/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/extract/domain/usecases/get_extract.dart';
import 'package:estaciona_mais/app/features/extract/presentation/bloc/extract_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtractCubit extends Cubit<ExtractState> {
  DateTime _date = DateTime.now();
  List<ResumeSpace> _resumes = [];
  final GetExtractUseCase _getExtractUseCase;
  ExtractCubit(this._getExtractUseCase) : super(ExtractInitial(DateTime.now()));

  void loadExtract() async {
    final result = await _getExtractUseCase(Params(_date));
    result.fold((error) {
      if (error is NoConnectionFailure)
        return emit(ErrorState(_date, "Sem conexao"));
      if (error is Failure)
        return emit(ErrorState(_date, "Erro ao obter dados"));
    }, (resumeSpaces) {
      double amount = 0;
      _resumes = resumeSpaces;
      for (var item in _resumes) {
        amount += item.total;
      }
      emit(LoadState(_date, _resumes, amount));
    });
  }

  void backDate() async {
    _date = _date.subtract(Duration(days: 1));
    emit(RefreshState(_date));
    loadExtract();
  }

  void nextDate() async {
    _date = _date.add(Duration(days: 1));
    emit(RefreshState(_date));
    loadExtract();
  }
}
