import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:saveload_app/features/auth/data/auth_repo_impl.dart';
import 'package:saveload_app/features/auth/domain/auth_model.dart';
import 'package:saveload_app/features/auth/domain/auth_repo.dart';
import 'package:saveload_app/features/auth/presentation/provider/auth_dependency_provider.dart';
import 'package:saveload_app/features/auth/screens/home.dart';
import 'package:saveload_app/features/auth/screens/login_screen.dart';
import 'package:saveload_app/features/navigation/main_navigation_screen.dart';
import 'package:saveload_app/features/posts/presentation/posts_screen.dart';

final authProvider = NotifierProvider<AuthController, AuthModel?>(() {
  return AuthController();
});

class AuthController extends Notifier<AuthModel?> {
  AuthRepo get repo => ref.read(authRepoProvider);
  @override
  AuthModel? build() {
    return null;
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final auth = await repo.login(username: username, password: password);
    await storage.write(key: "auth", value: jsonEncode(auth));
    state = auth as AuthModel?;
  }

  final storage = const FlutterSecureStorage();

  Future<AuthModel?> checkLoginStatus(BuildContext context) async {
    final data = await storage.read(key: "auth");
    //print("Auth data in storage: $data");

    if (data != null) {
      state = AuthModel.fromJson(jsonDecode(data));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      );
    } else {
      state = null;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await storage.delete(key: "auth");
    state = null;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
