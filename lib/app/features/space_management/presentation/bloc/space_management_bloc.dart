import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'space_management_event.dart';
part 'space_management_state.dart';
class SpaceManagementBloc extends Bloc<SpaceManagementEvent, SpaceManagementState> {
  SpaceManagementBloc() : super(SpaceManagementInitial());
  @override
  Stream<SpaceManagementState> mapEventToState(
    SpaceManagementEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
