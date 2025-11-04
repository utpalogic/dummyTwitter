import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saveload_app/features/posts/domain/post_repo.dart';
import 'package:saveload_app/features/posts/domain/posts_model.dart';
import 'package:saveload_app/features/posts/presentation/provider/post_dependency_provider.dart';

final postsNotifierProvider = NotifierProvider<PostsNotifier, List<PostsModel>>(
  () {
    return PostsNotifier();
  },
);

class PostsNotifier extends Notifier<List<PostsModel>> {
  PostRepo get repo => ref.read(postRepoProvider);

  @override
  List<PostsModel> build() {
    return [];
  }
}
