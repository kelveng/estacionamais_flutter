import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'extract_event.dart';
part 'extract_state.dart';
class ExtractBloc extends Bloc<ExtractEvent, ExtractState> {
  ExtractBloc() : super(ExtractInitial());
  @override
  Stream<ExtractState> mapEventToState(
    ExtractEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
