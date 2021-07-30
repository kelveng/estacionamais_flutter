import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';

abstract class SpaceManagementState extends Equatable {
  final List<Space> spaces;
  const SpaceManagementState(this.spaces);
}

class InitialState extends SpaceManagementState {
  InitialState(List<Space> spaces) : super(spaces);

  @override
  List<Object> get props => [spaces];
}

class LoadingState extends SpaceManagementState {
  LoadingState(List<Space> spaces) : super(spaces);

  @override
  List<Object> get props => [spaces];
}

class SucessLoadSpacesState extends SpaceManagementState {
  SucessLoadSpacesState(List<Space> spaces) : super(spaces);

  @override
  List<Object> get props => [spaces];
}

class RegisterEntryState extends SpaceManagementState {
  final List<Space> spaces;
  final Space space;

  RegisterEntryState(this.spaces, this.space) : super(null);

  @override
  List<Object> get props => [spaces, space];
}

class ErrorState extends SpaceManagementState {
  final String error;
  ErrorState(List<Space> spaces, this.error) : super(spaces);

  @override
  List<Object> get props => [];
}

class ErrorProcessState extends SpaceManagementState {
  final List<Space> spaces;
  final Space space;
  final String place;
  final String error;

  ErrorProcessState(this.spaces, this.place, this.space, this.error)
      : super(spaces);

  @override
  List<Object> get props => [spaces, place, space, error];
}
