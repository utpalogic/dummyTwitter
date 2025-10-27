import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saveload_app/features/auth/data/auth_remote_source.dart';
import 'package:saveload_app/features/auth/data/auth_repo_impl.dart';
import 'package:saveload_app/features/auth/domain/auth_repo.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com/",
      headers: {"Content-Type": "application/json"},
    ),
  );
});
final authSourceProvider = Provider<AuthRemoteSource>((ref) {
  return AuthRemoteSource(ref.watch(dioProvider));
});

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepoImpl(ref.watch(authSourceProvider));
});
