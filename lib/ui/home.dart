import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_exam/router/router_name.dart';
import 'package:flutter_exam/data/provider/user_provider.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserState userState = ref.watch(userProvider);

    return Scaffold(
        appBar: AppBar(title: const Text('User List')),
        body: ListView(shrinkWrap: true, children: [
          for (final user in userState.users)
            ListTile(
              title: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image(
                        width: 40.0,
                        height: 40.0,
                        image: NetworkImage(user.avatarUrl),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.login),
                      Text(user.siteAdmin == true ? '' : 'staff'),
                    ],
                  )
                ],
              ),
              onTap: () {
                ref.read(userProvider.notifier).getUser(user.login);
                context.go(context.namedLocation(RouterName.userDetail));
              },
            ),
        ]));
  }
}
