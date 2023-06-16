import 'package:flutter/material.dart';

import '../model/categorie.dart';
import '../router/route_constante.dart';
import '../service/essor_service.dart';
import 'package:go_router/go_router.dart';

class CategorieScreen extends StatefulWidget {
  const CategorieScreen({super.key, required this.id});
  final String id;

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  var isLoaded = false;
  Categorie? post;
  late List post7 = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPosts(id) async {
    final posts = await EssorService().getCategorie(id);
    if (mounted) {
      if (posts != null) {
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
    return Center(
      child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  Text('Lire Aussi'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: post7.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteConst.post,
                              params: {'slug': post7[index].slug});
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
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
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  post7[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
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
    );
  }
}
