import 'package:dio/dio.dart';
import 'package:saveload_app/features/auth/domain/auth_model.dart';
import 'package:saveload_app/features/auth/domain/auth_repo.dart';

class AuthRemoteSource extends AuthRepo {
  final Dio _dio;
  AuthRemoteSource(this._dio);

  @override
  Future<AuthModel> login({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(
      "auth/login",
      data: {"username": username, "password": password},
      options: Options(headers: {"Content-Type": "application/json"}),
    );
    return AuthModel.fromJson(response.data);
  }
}
