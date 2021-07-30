import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';

abstract class GetTicketByIdUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class GetTicketById extends GetTicketByIdUseCase<Ticket, ParamsId> {
  final SpaceManagementRepository repository;

  GetTicketById(this.repository);

  @override
  Future<Either<Failure, Ticket>> call(ParamsId params) async {
    if (params.ticketId <= 0) return Left(InvalidTicketFailure());
    return await repository.getTicket(params.ticketId);
  }
}

class ParamsId extends Equatable {
  final int ticketId;

  ParamsId(this.ticketId);

  @override
  List<Object> get props => [];
}
