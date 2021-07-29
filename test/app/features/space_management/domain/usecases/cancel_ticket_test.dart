import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/cancel_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/payment_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/process_ticket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'space_management_repository_mock.mocks.dart';

void main() {
  final SpaceManagementRepository repository = MockSpaceManagementRepository();
  final CancelTicketUseCase cancelTicketUseCase = CancelTicket(repository);
  group("cancelTicket", () {
    test("Should get a TicketProcessedFailure error", () async {
      TicketModel ticketModel =
          TicketModel(1, "NML-1122", 1, DateTime.now(), DateTime.now(), "2", 0);
      final result = await cancelTicketUseCase(ticketModel);
      expect(result.fold((l) => l, (r) => r), isA<TicketProcessedFailure>());
    });

    test("Should get a Ticket", () async {
      TicketModel ticketModel = TicketModel(
          1, "NML-1122", 1, DateTime.now(), DateTime.now(), "1", 10);

      when(repository.paymentTicket(ticketModel)).thenAnswer(
          (realInvocation) async => Future.value(Right(ticketModel)));
      final result = await cancelTicketUseCase(ticketModel);
      expect(result.fold((l) => l, (r) => r), isA<Ticket>());
    });
  });
}
