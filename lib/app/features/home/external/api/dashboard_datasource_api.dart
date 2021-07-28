import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/network/network_info.dart';
import 'package:estaciona_mais/app/features/home/data/datasources/dashboard_datasource.dart';
import 'package:estaciona_mais/app/features/home/data/models/dashboard_model.dart';
import 'package:estaciona_mais/app/features/home/domain/exceptions/failure.dart';

class DashboardDataSourceApi implements DashboardDataSource {
  final Dio dio;
  final NetworkInfo networkInfo;

  DashboardDataSourceApi(this.dio, this.networkInfo);

  @override
  Future<DashBoardModel> getDashboard() async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) throw NoConnectionFailure();

    try {
      final response = await dio.get("/dashboard");
      print(response.data);
      final data = response.data;
      final DashBoardModel dashBoardModel = DashBoardModel.fromMap(data);
      return dashBoardModel;
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
}
