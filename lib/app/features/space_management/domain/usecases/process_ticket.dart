import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';

abstract class ProcessTicketUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class ProcessTicket extends ProcessTicketUseCase<Ticket, Params> {
  final SpaceManagementRepository repository;

  ProcessTicket(this.repository);

  @override
  Future<Either<Failure, Ticket>> call(Params params) async {
    if (params.spaceId <= 0) return Left(InvalidSpaceFailure());
    if (params.place.isEmpty) return Left(InvalidPlaceFailure());
    return await repository.processTicket(params.place, params.spaceId);
  }
}

class Params extends Equatable {
  final int spaceId;
  final String place;

  Params(this.spaceId, this.place);

  @override
  List<Object> get props => [];
}
