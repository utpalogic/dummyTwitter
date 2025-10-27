import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saveload_app/features/posts/domain/comments_model.dart';
import 'package:saveload_app/features/posts/domain/posts_model.dart';
import 'package:saveload_app/features/posts/presentation/posts_screen.dart';
import 'package:saveload_app/features/posts/presentation/provider/post_providers.dart';

class PostDetailScreen extends ConsumerWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentAsync = ref.watch(commentsProvider(post.id));
    final TextEditingController commentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Post Details")),
      body: Column(
        children: [
          PostBox(post: post),

          Expanded(
            child: commentAsync.when(
              data: (data) {
                return ListView.builder(
                  itemCount: data.comments.length,
                  itemBuilder: (context, index) {
                    final comment = data.comments[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFB0C4DE),
                            ),
                          ),
                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      comment.user.fullName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "@${comment.user.username}",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comment.body,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 20),

                          Column(
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "${comment.likes}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) =>
                  Center(child: Text("Error: $error")),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),

          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFB0C4DE),
                    ),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      final text = commentController.text;
                      if (text.isNotEmpty) {
                        print("User typed: $text");
                        commentController.clear();
                      }
                    },
                    icon: const Icon(Icons.send, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
