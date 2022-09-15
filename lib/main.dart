import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_exam/router/routes.dart';

final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myRouter = MyRouter();

    return MaterialApp.router(
      routeInformationParser: myRouter.router.routeInformationParser,
      routerDelegate: myRouter.router.routerDelegate,
      theme: ThemeData.dark(),
    );
  }
}
