import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_exam/router/router_name.dart';
import 'package:flutter_exam/ui/home.dart';
import 'package:flutter_exam/ui/user/user_detail.dart';
import 'package:flutter_exam/ui/todo.dart';

class MyRouter {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
      name: RouterName.home,
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const Home(),
    ),
    GoRoute(
      name: RouterName.userDetail,
      path: '/user_detail',
      builder: (BuildContext context, GoRouterState state) =>
          const UserDetail(),
    ),
    GoRoute(
      name: RouterName.todo,
      path: '/todo',
      builder: (BuildContext context, GoRouterState state) =>
          const TodoListView(),
    ),
  ]);
}
