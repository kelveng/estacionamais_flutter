import 'package:dio/dio.dart';
import 'package:estaciona_mais/app/features/home/external/api/client/request_log_interceptor.dart';

class CustomDio {
  Dio obterDio() {
    final client = Dio();
    client.options.baseUrl = 'https://estacionamaisbackend.herokuapp.com/api';
    client.interceptors.add(ResquestLogInterceptor());

    client.options.connectTimeout = 30000;
    client.options.receiveTimeout = 30000;
    client.options.validateStatus = validateStatus;
    return client;
  }

  bool validateStatus(status) {
    return status < 500;
  }
}
