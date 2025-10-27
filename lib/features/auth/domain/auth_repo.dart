import 'package:saveload_app/features/auth/domain/auth_model.dart';

abstract class AuthRepo {
  Future<AuthModel> login({required String username, required String password});
}
