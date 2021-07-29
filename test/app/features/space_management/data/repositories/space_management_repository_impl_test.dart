import 'package:dartz/dartz.dart';
import 'package:estaciona_mais/app/features/space_management/data/datasources/space_management_datasource.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/space_model.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/data/repositories/space_management_repository_impl.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/entities.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/domain/repositories/space_management_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'space_management_repository_impl_test.mocks.dart';

@GenerateMocks([SpaceManagementDataSource])
void main() {
  final SpaceManagementDataSource spaceManagementDataSource =
      MockSpaceManagementDataSource();
  final SpaceManagementRepository repository =
      SpaceManagementRepositoryImpl(spaceManagementDataSource);

  group("getAllSpaces", () {
    test("Should get a NoConnectionFailure error", () async {
      when(spaceManagementDataSource.getAllSpaces())
          .thenThrow(NoConnectionFailure());
      final result = await repository.getAllSpaces();
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<NoConnectionFailure>());
    });

    test("Should get a ServerFailure error", () async {
      when(spaceManagementDataSource.getAllSpaces())
          .thenThrow(ServerFailure(code: "01", message: "error"));
      final result = await repository.getAllSpaces();
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });

    test("Should get a Generic error", () async {
      when(spaceManagementDataSource.getAllSpaces())
          .thenThrow(GenericFailure());
      final result = await repository.getAllSpaces();
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<GenericFailure>());
    });

    test("Should get a List of Spaces", () async {
      List<SpaceModel> spaces = [
        SpaceModel(1, "A1", false, 0),
        SpaceModel(2, "A2", false, 0)
      ];
      when(spaceManagementDataSource.getAllSpaces())
          .thenAnswer((realInvocation) async => await Future.value(spaces));
      final result = await repository.getAllSpaces();
      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r), isA<List<Space>>());
    });
  });

  group("processTicket", () {
    test("Should get a NoConnectionFailure error", () async {
      when(spaceManagementDataSource.processTicket(any))
          .thenThrow(NoConnectionFailure());
      final result = await repository.processTicket("TEST-1234", 1);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<NoConnectionFailure>());
    });

    test("Should get a ServerFailure error", () async {
      when(spaceManagementDataSource.processTicket(any))
          .thenThrow(ServerFailure(code: "01", message: "error"));
      final result = await repository.processTicket("TEST-1234", 1);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });

    test("Should get a Generic error", () async {
      when(spaceManagementDataSource.processTicket(any))
          .thenThrow(GenericFailure());
      final result = await repository.processTicket("TEST-1234", 1);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<GenericFailure>());
    });

    test("Should get a Ticket", () async {
      final TicketModel ticket = TicketModel(
          1, "TEST-1234", 1, DateTime.now(), DateTime.now(), "1", 100.24);
      when(spaceManagementDataSource.processTicket(any))
          .thenAnswer((realInvocation) async => await Future.value(ticket));
      final result = await repository.processTicket("TEST-1234", 1);

      expect(result, isA<Right>());
      expect(result.fold((l) => l, (r) => r), isA<Ticket>());
    });
  });

  group("paymentTicket", () {
    final TicketModel ticket = TicketModel(
        1, "TEST-1234", 1, DateTime.now(), DateTime.now(), "2", 100.24);
    test("Should get a NoConnectionFailure error", () async {
      when(spaceManagementDataSource.paymentTicket(any))
          .thenThrow(NoConnectionFailure());
      final result = await repository.paymentTicket(ticket);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<NoConnectionFailure>());
    });

    test("Should get a ServerFailure error", () async {
      when(spaceManagementDataSource.paymentTicket(any))
          .thenThrow(ServerFailure(code: "01", message: "error"));
      final result = await repository.paymentTicket(ticket);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });

    test("Should get a Generic error", () async {
      when(spaceManagementDataSource.paymentTicket(any))
          .thenThrow(GenericFailure());
      final result = await repository.paymentTicket(ticket);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<GenericFailure>());
    });

    test("Should get a Confirm payment Ticket", () async {
      when(spaceManagementDataSource.paymentTicket(any))
          .thenAnswer((realInvocation) async => await Future.value(ticket));
      final result = await repository.paymentTicket(ticket);

      expect(result.fold((l) => l, (r) => r), isA<Ticket>());
      expect(result.fold((l) => null, (r) => r).status, "2");
    });
  });

  group("cancelTicket", () {
    final TicketModel ticket = TicketModel(
        1, "NMK-1212", 2, DateTime.now(), DateTime.now(), "2", 120.00);
    test("Should get a NoConnectionFailure error", () async {
      when(spaceManagementDataSource.cancelTicket(any))
          .thenThrow(NoConnectionFailure());
      final result = await repository.cancelTicket(ticket);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<NoConnectionFailure>());
    });

    test("Should get a ServerFailure error", () async {
      when(spaceManagementDataSource.cancelTicket(any))
          .thenThrow(ServerFailure(code: "01", message: "error"));
      final result = await repository.cancelTicket(ticket);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });

    test("Should get a Generic error", () async {
      when(spaceManagementDataSource.cancelTicket(any))
          .thenThrow(GenericFailure());
      final result = await repository.cancelTicket(ticket);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<GenericFailure>());
    });

    test("Should get true if cancel ticket", () async {
      when(spaceManagementDataSource.cancelTicket(any))
          .thenAnswer((realInvocation) async => await Future.value(true));
      final result = await repository.cancelTicket(ticket);

      expect(result.fold((l) => l, (r) => r), isA<bool>());
      expect(result.fold((l) => null, (r) => r), true);
    });
  });

  group("getTicket", () {
    final TicketModel ticket = TicketModel(
        1, "TEST-1234", 1, DateTime.now(), DateTime.now(), "2", 100.24);
    test("Should get a NoConnectionFailure error", () async {
      when(spaceManagementDataSource.getTicket(any))
          .thenThrow(NoConnectionFailure());
      final result = await repository.getTicket(1);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<NoConnectionFailure>());
    });

    test("Should get a ServerFailure error", () async {
      when(spaceManagementDataSource.getTicket(any))
          .thenThrow(ServerFailure(code: "01", message: "error"));
      final result = await repository.getTicket(1);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });

    test("Should get a Generic error", () async {
      when(spaceManagementDataSource.getTicket(any))
          .thenThrow(GenericFailure());
      final result = await repository.getTicket(1);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<GenericFailure>());
    });

    test("Should get a InvalidTicketFailure error", () async {
      when(spaceManagementDataSource.getTicket(any))
          .thenThrow(InvalidTicketFailure());
      final result = await repository.getTicket(1);
      expect(result, isA<Left>());
      expect(result.fold((l) => l, (r) => r), isA<InvalidTicketFailure>());
    });

    test("Should get a Ticket", () async {
      when(spaceManagementDataSource.getTicket(any))
          .thenAnswer((realInvocation) async => await Future.value(ticket));
      final result = await repository.getTicket(1);

      expect(result.fold((l) => l, (r) => r), isA<Ticket>());
      expect(result.fold((l) => null, (r) => r).status, "2");
    });
  });
}
