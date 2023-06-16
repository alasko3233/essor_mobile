// ignore_for_file: prefer_const_constructors

import 'package:esoor/screen/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/journal.dart';
import '../router/route_constante.dart';
import '../service/auth.dart';
import '../service/essor_service.dart';
import 'categorie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLoaded = false;
  late Journal? journal = null;
  late List post3 = [];
  late List post12 = [];
  late List post_filter = [];
  // List<dynamic>? most;

  List<Tab> tabs = [
    Tab(
      child: Text('Accueil'),
    ),
    Tab(
      child: Text('Actualité'),
    ),
    Tab(
      child: Text('Société'),
    ),
    Tab(
      child: Text('Sports'),
    ),
    Tab(
      child: Text('Culture'),
    ),
    Tab(
      child: Text('Economie'),
    ),
  ];
  final storage = const FlutterSecureStorage();
  Future<void> _readAll() async {
    final all = await storage.readAll(
      aOptions: _getAndroidOptions(),
    );
    print(all);
  }

  void readToken() async {
    final token = await storage.read(
      key: 'token',
      aOptions: _getAndroidOptions(),
    );
    Provider.of<Auth>(context, listen: false).tryToken(token);

    print('mytoken $token');
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJournal();
    _readAll();
    readToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getJournal() async {
    final loadedJournal = await EssorService().getJournal();
    // most = journal.mostviews
    if (mounted) {
      if (loadedJournal != null) {
        journal = loadedJournal;
        post3 = journal!.posts.toList().take(3).toList().reversed.toList();
        post_filter = journal!.posts
            .where((post) => post.isAlert == 1)
            .toList()
            .take(2)
            .toList()
            .reversed
            .toList();
        post12 = journal!.posts.toList().take(12).toList().reversed.toList();

        // print(post3);
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_literals_to_create_immutables
          backgroundColor: Colors.black,
          title: Text('ESSOR'),
          actions: [
            Consumer<Auth>(builder: (context, auth, child) {
              if (!auth.authenticed) {
                return Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context.pushNamed(RouteConst.login);
                        },
                        icon: Icon(CupertinoIcons.person_alt_circle_fill)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text(
                        "S'abonner",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        context.pushNamed(RouteConst.setting);
                      },
                    ),
                  ],
                );
              } else {
                return Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context.pushNamed(RouteConst.setting);
                        },
                        icon: Icon(Icons.person)),
                    if (auth.user?.isActive == 0) ...[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Text(
                          "S'abonner",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          context.pushNamed(RouteConst.setting);
                        },
                      )
                    ] else
                      ...[],
                  ],
                );
              }
            }),
          ],
          bottom: PreferredSize(
              child: TabBar(isScrollable: true, tabs: tabs),
              preferredSize: Size.fromHeight(30)),
        ),
        body: TabBarView(children: [
          Visibility(
              visible: isLoaded,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: journal == null
                  ? const Center(child: Text("Journal non disponible"))
                  : Accueil(
                      journal: journal,
                      post_filter: post_filter,
                      post3: post3,
                      post12: post12)),
          CategorieScreen(id: '1'),
          CategorieScreen(id: '2'),
          CategorieScreen(id: '3'),
          CategorieScreen(id: '4'),
          CategorieScreen(id: '5'),
        ]),
      ),
    );
  }
}

class Accueil extends StatelessWidget {
  const Accueil({
    super.key,
    required this.journal,
    required this.post_filter,
    required this.post3,
    required this.post12,
  });

  final Journal? journal;
  final List post_filter;
  final List post3;
  final List post12;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return PostScreen(slug: journal!.principale.slug);
                    });
                // context.pushNamed(RouteConst.post,
                //     params: {'slug': journal!.principale.slug});
              },
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      stops: [0.2, 1.0],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ).createShader(bounds),
                    blendMode: BlendMode.darken,
                    child: Image.network(journal!.principale.image),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (journal!.principale.subjectedSubscription == 1)
                            Image.asset(
                              'assets/custom/abonnement.PNG',
                              width: 20,
                              height: 20,
                            ),
                          Expanded(
                            child: Text(
                              journal!.principale.title,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Image.network(journal!.principale.image),
            // Text(journal!.principale.description),
            Container(
              color: Colors.black,
              child: Column(
                children: post_filter
                    .map((post) => GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return PostScreen(slug: post.slug);
                              });

                          // context.pushNamed(RouteConst.post,
                          //     params: {'slug': post.slug});
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.white70,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              if (post.subjectedSubscription == 1)
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    'assets/custom/abonnement.PNG',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    post.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )))
                    .toList(),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        useSafeArea: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return PostScreen(slug: journal!.secondaire.slug);
                        });

                    // context.pushNamed(RouteConst.post,
                    //     params: {'slug': journal!.secondaire.slug});
                  },
                  // Navigator.pushNamed(context, '/posts', arguments: journal!.secondaire.slug),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        if (journal!.secondaire.subjectedSubscription == 0)
                          Image.asset(
                            'assets/custom/abonnement.PNG',
                            width: 20,
                            height: 20,
                          ),
                        ListTile(
                          leading: ClipRRect(
                            child: Image.network(
                              journal!.secondaire.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            journal!.secondaire.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(''),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        useSafeArea: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return PostScreen(slug: journal!.tertiaire.slug);
                        });

                    // context.pushNamed(RouteConst.post,
                    //     params: {'slug': journal!.secondaire.slug});
                  },

                  //  context.pushNamed('/posts', arguments: journal!.secondaire.slug),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        if (journal!.tertiaire.subjectedSubscription == 1)
                          Image.asset(
                            'assets/custom/abonnement.PNG',
                            width: 20,
                            height: 20,
                          ),
                        ListTile(
                          leading: ClipRRect(
                            child: Image.network(
                              journal!.tertiaire.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            journal!.tertiaire.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(''),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: post3.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        useSafeArea: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return PostScreen(slug: post3[index].slug);
                        });

                    // context.pushNamed(RouteConst.post,
                    //     params: {'slug': post3[index].slug});
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        if (post3[index].subjectedSubscription == 1)
                          Image.asset(
                            'assets/custom/abonnement.PNG',
                            width: 20,
                            height: 20,
                          ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            post3[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        ClipRRect(
                          child: Image.network(
                            post3[index].image,
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
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return PostScreen(slug: journal!.subcategories.slug);
                    });

                // context.pushNamed(RouteConst.post,
                //     params: {'slug': journal!.subcategories.slug});
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 15, right: 10, left: 10),
                    child: Image.network(journal!.subcategories.image),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        height: 70,
                        width: 20,
                        color: Colors.white.withOpacity(0.9),
                        child: Center(
                          child: Text(
                            journal!.subcategories.title,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: post12.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        useSafeArea: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return PostScreen(slug: post12[index].slug);
                        });

                    // context.pushNamed(RouteConst.post,
                    //     params: {'slug': post12[index].slug});
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
                        if (post12[index].subjectedSubscription == 1)
                          Image.asset(
                            'assets/custom/abonnement.PNG',
                            width: 20,
                            height: 20,
                          ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            post12[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        ClipRRect(
                          child: Image.network(
                            post12[index].image,
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
        ),
      ],
    );
  }
}
