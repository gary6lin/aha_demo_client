import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import '../auth_interceptor.dart';
import '../dto/register_dto.dart';

part 'app_remote_data_source.g.dart';

@RestApi()
abstract class AppRemoteDataSource {
  factory AppRemoteDataSource(Dio dio) {
    if (kDebugMode) {
      dio.interceptors
        ..add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        )
        ..add(
          AuthInterceptor(),
        );
    }
    return _AppRemoteDataSource(
      dio,
      baseUrl: 'http://localhost:3000/',
    );
  }

  @POST('/user')
  Future<void> createUser(@Body() RegisterDto dto);
}
