import 'package:dio/dio.dart';
import 'package:saveload_app/features/posts/domain/comments_model.dart';
import 'package:saveload_app/features/posts/domain/post_repo.dart';
import 'package:saveload_app/features/posts/domain/posts_model.dart';

class PostRepoImpl implements PostRepo {
  final Dio _dio;
  PostRepoImpl(this._dio);
  @override
  Future<CommentsModel> fetchCommentOfPost({required int id}) async {
    final response = await _dio.get("posts/$id/comments");
    return CommentsModel.fromJson(response.data);
  }

  @override
  Future<Post> fetchOnePost({required int id}) async {
    final response = await _dio.get("posts/$id");
    return Post.fromJson(response.data);
  }

  @override
  Future<PostsModel> fetchPost() async {
    final response = await _dio.get("posts");
    return PostsModel.fromJson(response.data);
  }
}
