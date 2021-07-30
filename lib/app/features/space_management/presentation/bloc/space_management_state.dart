import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/entities.dart';
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
  final bool isLoadingHour;
  final String hour;

  RegisterEntryState(this.spaces, this.space, this.isLoadingHour, this.hour)
      : super(spaces);

  @override
  List<Object> get props => [spaces, space, isLoadingHour, hour];
}

class ManagmentTicketState extends SpaceManagementState {
  final List<Space> spaces;
  final Space space;
  final Ticket ticket;
  final isLoading;
  final String error;

  ManagmentTicketState(
      this.spaces, this.space, this.ticket, this.isLoading, this.error)
      : super(spaces);

  @override
  List<Object> get props => [spaces, space, ticket];
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
