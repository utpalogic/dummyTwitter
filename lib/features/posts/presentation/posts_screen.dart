import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saveload_app/features/posts/domain/posts_model.dart';
import 'package:saveload_app/features/posts/presentation/post_detail_screen.dart';
import 'package:saveload_app/features/posts/presentation/provider/post_providers.dart';
import 'package:saveload_app/features/quotes/presentatiom/provider/quote_provider.dart';

Post mypost = Post(
  id: 1,
  title: "His mother had always taught him",
  body:
      "His mother had always taught him not to ever think of himself as better than others. He'd tried to live by this motto. He never looked down on those who were less fortunate or who had less money than him. But the stupidity of the group of people he was talking to made him change his mind.",
  tags: ["history", "american", "crime"],
  reactions: Reactions(likes: 192, dislikes: 25),
  views: 305,
  userId: 121,
);

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(postsProvider);
    final randomQuoteAsync = ref.watch(randomQuoteProvider);

    return Scaffold(
      body: postAsync.when(
        data: (data) {
          return ListView(
            padding: const EdgeInsets.all(8),
            children: [
              randomQuoteAsync.when(
                data: (quote) => Card(
                  color: const Color.fromARGB(255, 236, 226, 226),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      '“${quote.quote}” — ${quote.author}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Failed to load quote"),
                ),
              ),

              SizedBox(height: 10),

              ...data.posts.map((post) => PostBox(post: post)),
            ],
          );
        },
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$error"),
              ElevatedButton(
                onPressed: () => ref.invalidate(postsProvider),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class PostBox extends StatelessWidget {
  final Post post;
  const PostBox({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final tagsText = post.tags.map((t) => "#$t").join(" ");

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 202, 214, 224),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                post.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "@user${post.userId}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "· 12h",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${post.body} ",
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.4,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: tagsText,
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _iconText(
                              Icons.thumb_down_alt_outlined,
                              "${post.reactions.dislikes}",
                              const Color.fromARGB(255, 136, 137, 139),
                            ),
                            SizedBox(width: 15),
                            _iconText(
                              Icons.favorite,
                              "${post.reactions.likes}",
                              const Color.fromARGB(255, 200, 64, 64),
                            ),
                            SizedBox(width: 15),
                            _iconText(
                              Icons.remove_red_eye,
                              "${post.views}",
                              Colors.blueAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.8, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }
}
