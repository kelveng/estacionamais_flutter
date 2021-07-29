import 'package:dio/dio.dart';

class ResquestLogInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print(
        "REQUEST[${options.method}] => PATH: ${options.baseUrl + options.path} \n DATA: ${options.data} \n HEADERS: ${options.headers}");
    return options;
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print(
        "RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.baseUrl + response.requestOptions.path} \n RESULT: ${response.data} \n HEADERS: ${response.headers}");
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError e, ErrorInterceptorHandler handler) async {
    print(
        "ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.baseUrl + e.requestOptions.path} \n DATA: ${e.response?.data}");
    return super.onError(e, handler);
  }
}
