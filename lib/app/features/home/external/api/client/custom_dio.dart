import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/features/home/external/api/client/request_log_interceptor.dart';

class CustomDio {
  Dio newDio() {
    var client = Dio(
        BaseOptions(baseUrl: 'https://estacionamaisbackend.herokuapp.com/api'));
    client.interceptors.add(ResquestLogInterceptor());
    return client;
  }
}
