import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/payment_ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/process_ticket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'space_management_repository_mock.mocks.dart';

void main() {
  final SpaceManagementRepository repository = MockSpaceManagementRepository();
  final PaymentTicketUseCase paymentTicketUseCase = PaymentTicket(repository);
  group("paymentTicket", () {
    test("Should get a InvalidAmountFailure error", () async {
      TicketModel ticketModel = TicketModel(
          1, "NML-1122", 1, DateTime.now(), DateTime.now(), "2", -10);
      final result = await paymentTicketUseCase(ticketModel);
      expect(result.fold((l) => l, (r) => r), isA<InvalidAmountFailure>());
    });

    test("Should get a Ticket", () async {
      TicketModel ticketModel = TicketModel(
          1, "NML-1122", 1, DateTime.now(), DateTime.now(), "2", 10);

      when(repository.paymentTicket(ticketModel)).thenAnswer(
          (realInvocation) async => Future.value(Right(ticketModel)));
      final result = await paymentTicketUseCase(ticketModel);
      expect(result.fold((l) => l, (r) => r), isA<Ticket>());
    });
  });
}
