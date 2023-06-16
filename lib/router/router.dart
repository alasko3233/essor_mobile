import 'package:esoor/screen/abonnement.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screen/categorie.dart';
import '../screen/home.dart';
import '../screen/login.dart';
import '../screen/post.dart';
import '../screen/setting.dart';
import 'route_constante.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  GoRouter router = GoRouter(debugLogDiagnostics: true, routes: [
    GoRoute(
      name: RouteConst.home,
      path: '/',
      pageBuilder: (context, state) {
        return const MaterialPage(child: HomeScreen());
      },
    ),
    GoRoute(
      name: RouteConst.login,
      path: '/login',
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginScreen());
      },
    ),
    GoRoute(
      name: RouteConst.setting,
      path: '/setting',
      pageBuilder: (context, state) {
        return const MaterialPage(child: SettingScreen());
      },
    ),
    GoRoute(
      name: RouteConst.abonnement,
      path: '/abonnement',
      pageBuilder: (context, state) {
        return const MaterialPage(child: AbonnementScreen());
      },
    ),
    GoRoute(
      name: RouteConst.post,
      path: '/post/:slug',
      pageBuilder: (context, state) {
        return MaterialPage(child: PostScreen(slug: state.params["slug"]!));
      },
    ),
    GoRoute(
      name: RouteConst.categorie,
      path: '/categories/:id',
      pageBuilder: (context, state) {
        return MaterialPage(child: CategorieScreen(id: state.params["id"]!));
      },
    ),
  ]);
}
