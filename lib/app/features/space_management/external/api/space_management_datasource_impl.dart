import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/network/network_info.dart';
import 'package:estaciona_mais/app/features/space_management/data/datasources/space_management_datasource.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/space_model.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/ticket.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/space.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/process_ticket_model.dart';
import 'package:estaciona_mais/app/features/space_management/domain/exceptions/failure.dart';

class SpaceManagamentDataSourceImpl implements SpaceManagementDataSource {
  final Dio dio;
  final NetworkInfo networkInfo;

  SpaceManagamentDataSourceImpl(this.dio, this.networkInfo);

  @override
  Future<bool> cancelTicket(TicketModel ticket) async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) throw NoConnectionFailure();

    try {
      final response =
          await dio.post("/cancelticket", data: ticket.toMapCancel());

      return response.data["sucess"];
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        throw ResourceNotFoundFailure();
      } else if (e.response.statusCode == 422) {
        final String codeError = getCodeError(e.response.data);
        if (codeError == "04") throw InvalidTicketFailure();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw GenericFailure();
    }
  }

  @override
  Future<List<Space>> getAllSpaces() async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) throw NoConnectionFailure();

    try {
      final response = await dio.get("/space");
      final data = response.data;
      final List<Space> spaces =
          (data as List).map((data) => SpaceModel.fromMap(data)).toList();
      return spaces;
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        throw ResourceNotFoundFailure();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw GenericFailure();
    }
  }

  @override
  Future<Ticket> getTicket(int ticketId) async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) throw NoConnectionFailure();

    try {
      final response = await dio.get("/ticket/$ticketId");
      final Ticket ticket = TicketModel.fromMap(response.data);
      return ticket;
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        throw ResourceNotFoundFailure();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw GenericFailure();
    }
  }

  @override
  Future<Ticket> paymentTicket(TicketModel ticket) async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) throw NoConnectionFailure();

    try {
      final response =
          await dio.post("/paymentticket", data: ticket.toMapPayment());
      final Ticket ticketResponse = TicketModel.fromMap(response.data);
      return ticketResponse;
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        throw ResourceNotFoundFailure();
      } else if (e.response.statusCode == 422) {
        final String codeError = getCodeError(e.response.data);
        if (codeError == "04") throw InvalidTicketFailure();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw GenericFailure();
    }
  }

  @override
  Future<Ticket> processTicket(ProcessTicketModel processTicketModel) async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) throw NoConnectionFailure();

    try {
      final response =
          await dio.post("/ticket", data: processTicketModel.toMapProcess());
      final Ticket ticket = TicketModel.fromMap(response.data);
      return ticket;
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        throw ResourceNotFoundFailure();
      } else if (e.response.statusCode == 422) {
        final String codeError = getCodeError(e.response.data);
        if (codeError == "01") throw InvalidSpaceFailure();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw GenericFailure();
    }
  }

  @override
  Future<String> getHour() async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) throw NoConnectionFailure();

    try {
      final response = await dio.get("/time");
      return response.data["hour"];
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        throw ResourceNotFoundFailure();
      }
      throw ServerFailure();
    } catch (e) {
      throw GenericFailure();
    }
  }

  String getCodeError(Map<String, dynamic> error) {
    String codeError = "";
    if (error["error"] != null && error["error"]["code"] != null)
      codeError = error["error"]["code"];
    return codeError;
  }
}
