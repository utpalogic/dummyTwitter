import 'package:saveload_app/features/auth/data/auth_remote_source.dart';
import 'package:saveload_app/features/auth/domain/auth_model.dart';
import 'package:saveload_app/features/auth/domain/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteSource source;
  AuthRepoImpl(this.source);
  @override
  Future<AuthModel> login({
    required String username,
    required String password,
  }) async {
    return await source.login(username: username, password: password);
  }
}
