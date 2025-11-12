import 'package:dio/dio.dart';
import 'package:saveload_app/features/posts/domain/comments_model.dart';
import 'package:saveload_app/features/posts/domain/posts_model.dart';

abstract class PostRepo {
  Future<PostsModel> fetchPost();
  Future<Post> fetchOnePost({required int id});
  Future<CommentsModel> fetchCommentOfPost({required int id});
  
}
