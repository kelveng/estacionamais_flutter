import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';

abstract class PaymentTicketUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class PaymentTicket extends PaymentTicketUseCase<Ticket, Ticket> {
  final SpaceManagementRepository repository;

  PaymentTicket(this.repository);

  @override
  Future<Either<Failure, Ticket>> call(Ticket ticket) async {
    if (ticket.amount <= 0) return Left(InvalidAmountFailure());
    return await repository.paymentTicket(ticket);
  }
}
