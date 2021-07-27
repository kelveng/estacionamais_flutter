import 'package:dio/dio.dart';

class OptionsDio {
  get options => BaseOptions(
      baseUrl: 'https://estacionamaisbackend.herokuapp.com/api/',
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: validateStatus);

  bool validateStatus(status) {
    return status == 200;
  }
}
