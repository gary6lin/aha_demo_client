import 'package:aha_demo/repositories/app_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AuthInterceptor extends Interceptor {
  late final _repo = GetIt.I<AppRepository>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] = await _repo.getIdToken();
    return super.onRequest(options, handler);
  }
}
