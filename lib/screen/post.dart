import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/post.dart';
import '../service/essor_service.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../router/route_constante.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.slug});
  final String slug;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var isLoaded = false;
  Post? post;
  late List post7 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts(widget.slug);
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPosts(slug) async {
    final posts = await EssorService().getPost(slug);
    // most = journal.mostviews
    if (mounted) {
      if (posts != null) {
        // print(post3);
        post = posts;
        post7 = post!.posts.toList().take(7).toList().reversed.toList();

        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: DraggableScrollableSheet(
        initialChildSize: 1,
        builder: (context, scrollController) => Visibility(
            visible: isLoaded,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post?.postcategoriename ?? '',
                          style: const TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      post?.post.title ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post?.post.description ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Par ${post?.postauthor}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Publié le ${post?.post.createdAt}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    if (post?.post.subjectedSubscription == 1) ...[
                      const SizedBox(height: 8),
                      const Text('Article réservé aux abonnés'),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [const Icon(CupertinoIcons.share_up)],
                    ),
                    const SizedBox(height: 5),
                    Image.network(post?.post.image ?? ''),
                    if (post?.user == null &&
                            post?.post.subjectedSubscription == 1 ||
                        (post?.user != null &&
                            post?.user.isactive == 0 &&
                            post?.post.subjectedSubscription == 1)) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.6),
                              Colors.white
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Html(
                          data: post?.post.content != null
                              ? '${post?.post.content.substring(0, 500)} ....'
                              : '',
                          style: {
                            'p': Style(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                            ),
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          const Text('La suite est réservée aux abonnés.'),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('S\'abonner pour lire la suite'),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Déjà abonné ? Se connecter'),
                          ),
                        ],
                      ),
                    ] else if (post?.user != null &&
                        post?.user.isactive == 1 &&
                        post?.post.subjectedSubscription == 1) ...[
                      const SizedBox(height: 8),
                      Html(
                        data: post?.post.content ?? '',
                        style: {
                          'p': Style(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                          ),
                        },
                      ),
                    ] else if (post?.post.subjectedSubscription == 0) ...[
                      const SizedBox(height: 8),
                      Html(
                        data: post?.post.content ?? '',
                        style: {
                          'p': Style(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              fontSize: const FontSize(16)),
                        },
                      ),
                    ],
                    const SizedBox(height: 8),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        top: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              'Lire Aussi',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: post7.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                useSafeArea: true,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return PostScreen(slug: post7[index].slug);
                                });

                            // context.pushNamed(RouteConst.post,
                            //     params: {'slug': post7[index].slug});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                if (post7[index].subjectedSubscription == 1)
                                  Image.asset(
                                    'assets/custom/abonnement.PNG',
                                    width: 30,
                                    height: 30,
                                  ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    post7[index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    post7[index].image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
