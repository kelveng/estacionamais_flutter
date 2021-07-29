import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';

abstract class SpaceManagementRepository {
  Future<Either<Failure, List<Space>>> getAllSpaces();
  Future<Either<Failure, Ticket>> getTicket(int ticketId);
  Future<Either<Failure, Ticket>> processTicket(String plate, int spaceId);
  Future<Either<Failure, Ticket>> paymentTicket(Ticket ticket);
  Future<Either<Failure, bool>> cancelTicket(Ticket ticket);
}
