import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';

abstract class CancelTicketUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class CancelTicket extends CancelTicketUseCase<Ticket, Ticket> {
  final SpaceManagementRepository repository;

  CancelTicket(this.repository);

  @override
  Future<Either<Failure, Ticket>> call(Ticket ticket) async {
    if (ticket.status != "1") return Left(TicketProcessedFailure());
    return await repository.paymentTicket(ticket);
  }
}
