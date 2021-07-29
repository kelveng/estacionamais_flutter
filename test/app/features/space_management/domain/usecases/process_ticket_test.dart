import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';
import 'package:estaciona_mais/app/features/space_management/domain/usecases/process_ticket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'space_management_repository_mock.mocks.dart';

void main() {
  final SpaceManagementRepository repository = MockSpaceManagementRepository();
  final ProcessTicketUseCase processTicketUseCase = ProcessTicket(repository);
  group("processTicket", () {
    test("Should get a InvalidPlaceFailure error", () async {
      final result = await processTicketUseCase(Params(1, ""));
      expect(result.fold((l) => l, (r) => r), isA<InvalidPlaceFailure>());
    });

    test("Should get a InvalidSpaceFailure error", () async {
      final result = await processTicketUseCase(Params(-1, ""));
      expect(result.fold((l) => l, (r) => r), isA<InvalidSpaceFailure>());
    });

    test("Should get a Ticket", () async {
      TicketModel ticketModel = TicketModel(
          1, "NML-1122", 1, DateTime.now(), DateTime.now(), "2", 10);
      when(repository.processTicket("NML-1122", 1)).thenAnswer(
          (realInvocation) async => Future.value(Right(ticketModel)));
      final result = await processTicketUseCase(Params(1, "NML-1122"));
      expect(result.fold((l) => l, (r) => r), isA<Ticket>());
    });
  });
}
