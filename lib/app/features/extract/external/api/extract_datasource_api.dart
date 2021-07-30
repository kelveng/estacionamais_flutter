import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/common/network/network_info.dart';
import 'package:estaciona_mais/app/common/utils/datetime_utils.dart';
import 'package:estaciona_mais/app/features/extract/data/datasources/extract_datasource.dart';
import 'package:estaciona_mais/app/features/extract/data/models/resume_space_model.dart';
import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';
import 'package:estaciona_mais/app/features/extract/domain/exceptions/failure.dart';

class ExtractDataSourceApi implements ExtractDataSource {
  final Dio dio;
  final NetworkInfo networkInfo;

  ExtractDataSourceApi(this.dio, this.networkInfo);

  @override
  Future<List<ResumeSpace>> getExtract(DateTime date) async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) throw NoConnectionFailure();

    try {
      final response =
          await dio.get("/extract/${DateTimeUtils.getDateFormatServer(date)}");
      final data = response.data;
      final List<ResumeSpaceModel> resumes =
          (data as List).map((data) => ResumeSpaceModel.fromMap(data)).toList();
      return resumes;
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
