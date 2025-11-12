import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saveload_app/features/posts/domain/comments_model.dart';
import 'package:saveload_app/features/posts/domain/posts_model.dart';
import 'package:saveload_app/features/posts/presentation/provider/post_dependency_provider.dart';

final postsProvider = FutureProvider<PostsModel>((ref) async {
  return await ref.read(postRepoProvider).fetchPost();
});

final commentsProvider = FutureProvider.family.autoDispose<CommentsModel, int>((
  ref,
  id,
) async {
  return await ref.read(postRepoProvider).fetchCommentOfPost(id: id);
});

final singlePostProvider = FutureProvider.family<Post, int>((ref, id) async {
  return await ref.read(postRepoProvider).fetchOnePost(id: id);
});

