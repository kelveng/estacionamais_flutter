import 'package:estaciona_mais/app/features/space_management/data/models/process_ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';

abstract class SpaceManagementDataSource {
  Future<List<Space>> getAllSpaces();
  Future<Ticket> getTicket(int ticketId);
  Future<Ticket> processTicket(ProcessTicketModel processTicketModel);
  Future<Ticket> paymentTicket(TicketModel ticket);
  Future<bool> cancelTicket(TicketModel ticket);
}
