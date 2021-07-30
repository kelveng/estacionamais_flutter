import 'package:estaciona_mais/app/features/space_management/data/datasources/space_management_datasource.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/process_ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';
import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';

class SpaceManagementRepositoryImpl implements SpaceManagementRepository {
  final SpaceManagementDataSource dataSource;

  SpaceManagementRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, bool>> cancelTicket(Ticket ticket) async {
    try {
      final bool isSucess = await dataSource.cancelTicket(ticket);
      return Right(isSucess);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, List<Space>>> getAllSpaces() async {
    try {
      final List<Space> spaceList = await dataSource.getAllSpaces();
      return Right(spaceList);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, Ticket>> getTicket(int ticketId) async {
    try {
      final Ticket ticketResponse = await dataSource.getTicket(ticketId);
      return Right(ticketResponse);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, Ticket>> paymentTicket(Ticket ticket) async {
    try {
      final Ticket ticketResponse = await dataSource.paymentTicket(ticket);
      return Right(ticketResponse);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, Ticket>> processTicket(
      String plate, int spaceId) async {
    try {
      final ProcessTicketModel processTicketModel =
          ProcessTicketModel(plate, spaceId);
      final Ticket ticket = await dataSource.processTicket(processTicketModel);
      return Right(ticket);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getHourNow() async {
    try {
      final String hour = await dataSource.getHour();
      return Right(hour);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
