import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saveload_app/features/auth/presentation/provider/auth_dependency_provider.dart';
import 'package:saveload_app/features/posts/data/post_repo_impl.dart';
import 'package:saveload_app/features/posts/domain/post_repo.dart';

final postRepoProvider = Provider<PostRepo>((ref) {
  return PostRepoImpl(ref.watch(dioProvider));
});
