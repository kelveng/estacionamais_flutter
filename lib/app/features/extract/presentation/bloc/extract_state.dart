import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';

abstract class ExtractState extends Equatable {
  final DateTime dateTime;
  const ExtractState(this.dateTime);
}

class ExtractInitial extends ExtractState {
  final DateTime dateTime;
  ExtractInitial(this.dateTime) : super(dateTime);
  @override
  List<Object> get props => [dateTime];
}

class RefreshState extends ExtractState {
  final DateTime dateTime;

  RefreshState(this.dateTime) : super(dateTime);
  @override
  List<Object> get props => [dateTime];
}

class ErrorState extends ExtractState {
  final DateTime dateTime;
  final String error;
  ErrorState(this.dateTime, this.error) : super(dateTime);
  @override
  List<Object> get props => [dateTime, error];
}

class LoadState extends ExtractState {
  final DateTime dateTime;
  final List<ResumeSpace> resumes;
  final double amount;
  LoadState(this.dateTime, this.resumes, this.amount) : super(dateTime);
  @override
  List<Object> get props => [dateTime, resumes, amount];
}
