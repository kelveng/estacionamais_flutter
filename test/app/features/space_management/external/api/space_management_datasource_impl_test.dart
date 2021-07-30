import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/network/network_info.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/process_ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';
import 'package:estaciona_mais/app/features/space_management/external/api/space_management_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'space_management_datasource_impl_test.mocks.dart';

@GenerateMocks([Dio, NetworkInfo])
void main() {
  final Dio mockDio = MockDio();
  final NetworkInfo networkInfo = MockNetworkInfo();
  final SpaceManagamentDataSourceImpl dataSource =
      SpaceManagamentDataSourceImpl(mockDio, networkInfo);

  group("getAllSpaces", () {
    test("Should get a ResourceNotFoundFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 404)));

      expect(() async => await dataSource.getAllSpaces(),
          throwsA(isA<ResourceNotFoundFailure>()));
    });

    test("Should get a ServerFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.getAllSpaces(),
          throwsA(isA<ServerFailure>()));
    });

    test("Should get a NoConnectionFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.getAllSpaces(),
          throwsA(isA<NoConnectionFailure>()));
    });

    test("Should get a list of Space", () async {
      final file = new File('test/resources/spaces.json');
      final jsonSpace = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.get(any)).thenAnswer((realInvocation) async =>
          await Response(statusCode: 200, data: jsonSpace));

      final result = await dataSource.getAllSpaces();

      expect(result, isA<List<Space>>());
    });
  });

  group("processTicket", () {
    final ProcessTicketModel ticket = ProcessTicketModel("TEST-1234", 1);
    test("Should get a ResourceNotFoundFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapProcess()))
          .thenThrow(DioError(response: Response(statusCode: 404)));

      expect(() async => await dataSource.processTicket(ticket),
          throwsA(isA<ResourceNotFoundFailure>()));
    });

    test("Should get a ServerFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapProcess()))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.processTicket(ticket),
          throwsA(isA<ServerFailure>()));
    });

    test("Should get a NoConnectionFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockDio.post(any, data: ticket.toMapProcess()))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.processTicket(ticket),
          throwsA(isA<NoConnectionFailure>()));
    });

    test("Should get a InvalidSpaceFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.post(any, data: ticket.toMapProcess())).thenThrow(DioError(
          response: Response(statusCode: 422, data: {
        "error": {"code": "01", "message": "Vaga nao encontrada"}
      })));

      expect(() async => await dataSource.processTicket(ticket),
          throwsA(isA<InvalidSpaceFailure>()));
    });

    test("Should get a Ticket with exit_time equals null", () async {
      final file = new File('test/resources/ticket_with_exit_time_null.json');
      final jsonSpace = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.post(any, data: ticket.toMapProcess())).thenAnswer(
          (realInvocation) async =>
              await Response(statusCode: 200, data: jsonSpace));

      final result = await dataSource.processTicket(ticket);

      expect(result, isA<Ticket>());
      expect(result.exitTime, null);
    });

    test("Should get a Ticket with exit_time diferent null", () async {
      final file = new File('test/resources/ticket.json');
      final jsonSpace = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.post(any, data: ticket.toMapProcess())).thenAnswer(
          (realInvocation) async =>
              await Response(statusCode: 200, data: jsonSpace));

      final result = await dataSource.processTicket(ticket);

      expect(result, isA<Ticket>());
      expect(result.exitTime, isA<DateTime>());
    });
  });

  group("cancelTicket", () {
    final TicketModel ticket = TicketModel(
        1, "NMK-1212", 2, DateTime.now(), DateTime.now(), "2", 120.00, "20:00");
    test("Should get a ResourceNotFoundFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapCancel()))
          .thenThrow(DioError(response: Response(statusCode: 404)));

      expect(() async => await dataSource.cancelTicket(ticket),
          throwsA(isA<ResourceNotFoundFailure>()));
    });

    test("Should get a ServerFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapCancel()))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.cancelTicket(ticket),
          throwsA(isA<ServerFailure>()));
    });

    test("Should get a InvalidTicketFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapCancel())).thenThrow(DioError(
          response: Response(statusCode: 422, data: {
        "error": {"code": "04", "message": "Ticket nao encontrado"}
      })));

      expect(() async => await dataSource.cancelTicket(ticket),
          throwsA(isA<InvalidTicketFailure>()));
    });

    test("Should get a NoConnectionFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockDio.post(any, data: ticket.toMapCancel()))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.cancelTicket(ticket),
          throwsA(isA<NoConnectionFailure>()));
    });

    test("Should get true if cancel ticket", () async {
      final file = new File('test/resources/cancel_ticket.json');
      final jsonSpace = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.post(any, data: ticket.toMapCancel())).thenAnswer(
          (realInvocation) async =>
              await Response(statusCode: 200, data: jsonSpace));

      final result = await dataSource.cancelTicket(ticket);

      expect(result, isA<bool>());
      expect(result, true);
    });
  });

  group("getTicketSpace", () {
    final TicketModel ticket = TicketModel(
        1, "NMK-1212", 2, DateTime.now(), DateTime.now(), "2", 120.00, "20:00");
    test("Should get a ResourceNotFoundFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 404)));

      expect(() async => await dataSource.getTicket(1),
          throwsA(isA<ResourceNotFoundFailure>()));
    });

    test("Should get a ServerFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.getTicket(1),
          throwsA(isA<ServerFailure>()));
    });

    test("Should get a NoConnectionFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockDio.get(any))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.getTicket(1),
          throwsA(isA<NoConnectionFailure>()));
    });

    test("Should get a Ticket", () async {
      final file = new File('test/resources/ticket.json');
      final jsonSpace = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.get(any)).thenAnswer((realInvocation) async =>
          await Response(statusCode: 200, data: jsonSpace));

      final result = await dataSource.getTicket(1);

      expect(result, isA<Ticket>());
    });
  });

  group("processTicket", () {
    final ProcessTicketModel ticket = ProcessTicketModel("TEST-1234", 1);
    test("Should get a ResourceNotFoundFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapProcess()))
          .thenThrow(DioError(response: Response(statusCode: 404)));

      expect(() async => await dataSource.processTicket(ticket),
          throwsA(isA<ResourceNotFoundFailure>()));
    });

    test("Should get a ServerFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapProcess()))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.processTicket(ticket),
          throwsA(isA<ServerFailure>()));
    });

    test("Should get a NoConnectionFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockDio.post(any, data: ticket.toMapProcess()))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.processTicket(ticket),
          throwsA(isA<NoConnectionFailure>()));
    });

    test("Should get a Ticket with exit_time equals null", () async {
      final file = new File('test/resources/ticket_with_exit_time_null.json');
      final jsonSpace = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.post(any, data: ticket.toMapProcess())).thenAnswer(
          (realInvocation) async =>
              await Response(statusCode: 200, data: jsonSpace));

      final result = await dataSource.processTicket(ticket);

      expect(result, isA<Ticket>());
      expect(result.exitTime, null);
    });

    test("Should get a Ticket with exit_time diferent null", () async {
      final file = new File('test/resources/ticket.json');
      final jsonSpace = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.post(any, data: ticket.toMapProcess())).thenAnswer(
          (realInvocation) async =>
              await Response(statusCode: 200, data: jsonSpace));

      final result = await dataSource.processTicket(ticket);

      expect(result, isA<Ticket>());
      expect(result.exitTime, isA<DateTime>());
    });
  });

  group("paymentTicket", () {
    final TicketModel ticket = TicketModel(
        1, "NMK-1212", 2, DateTime.now(), DateTime.now(), "2", 120.00, "20:00");
    test("Should get a ResourceNotFoundFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapPayment()))
          .thenThrow(DioError(response: Response(statusCode: 404)));

      expect(() async => await dataSource.paymentTicket(ticket),
          throwsA(isA<ResourceNotFoundFailure>()));
    });

    test("Should get a ServerFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapPayment()))
          .thenThrow(DioError(response: Response(statusCode: 500)));

      expect(() async => await dataSource.paymentTicket(ticket),
          throwsA(isA<ServerFailure>()));
    });

    test("Should get a InvalidTicketFailure error", () async {
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));

      when(mockDio.post(any, data: ticket.toMapPayment())).thenThrow(DioError(
          response: Response(statusCode: 422, data: {
        "error": {"code": "04", "message": "Ticket nao encontrado"}
      })));

      expect(() async => await dataSource.paymentTicket(ticket),
          throwsA(isA<InvalidTicketFailure>()));
    });

    test("Should get a Ticket with exit_time diferent null", () async {
      final file = new File('test/resources/ticket.json');
      final jsonSpace = json.decode(await file.readAsString());
      when(networkInfo.isConnected)
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockDio.post(any, data: ticket.toMapPayment())).thenAnswer(
          (realInvocation) async =>
              await Response(statusCode: 200, data: jsonSpace));

      final result = await dataSource.paymentTicket(ticket);

      expect(result, isA<Ticket>());
      expect(result.exitTime, isA<DateTime>());
    });
  });
}
