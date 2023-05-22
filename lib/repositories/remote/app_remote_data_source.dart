import 'package:aha_demo/repositories/dto/response/users_statistic_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import '../../values/app_environments.dart';
import '../auth_interceptor.dart';
import '../dto/request/create_user_dto.dart';
import '../dto/request/update_user_info_dto.dart';
import '../dto/request/update_user_password_dto.dart';
import '../dto/response/users_result_dto.dart';

part 'app_remote_data_source.g.dart';

@RestApi()
abstract class AppRemoteDataSource {
  factory AppRemoteDataSource(Dio dio) {
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
    dio.interceptors.add(
      AuthInterceptor(),
    );
    return _AppRemoteDataSource(
      dio,
      baseUrl: AppEnvironments.host,
    );
  }

  @POST('/user')
  Future<void> createUser(@Body() CreateUserDto dto);

  @PATCH('/user/{uid}')
  Future<void> updateUser(@Path() String uid);

  @PATCH('/user/{uid}/info')
  Future<void> updateUserInfo(@Path() String uid, @Body() UpdateUserInfoDto dto);

  @PATCH('/user/{uid}/password')
  Future<void> updateUserPassword(@Path() String uid, @Body() UpdateUserPasswordDto dto);

  @GET('/users')
  Future<UsersResultDto> findUsers(@Query('pageSize') int pageSize, @Query('pageToken') String? pageToken);

  @GET('/users-statistic')
  Future<UsersStatisticDto> findUsersStatistic();
}
