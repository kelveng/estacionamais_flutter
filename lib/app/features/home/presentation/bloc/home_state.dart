import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class InitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class SucessState extends HomeState {
  final Dashboard dashboard;

  SucessState(this.dashboard);

  @override
  List<Object> get props => [dashboard];
}

class ErrorState extends HomeState {
  final String error;

  ErrorState(this.error);
  @override
  List<Object> get props => [error];
}
