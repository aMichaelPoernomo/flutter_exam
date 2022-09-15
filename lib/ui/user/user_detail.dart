import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_exam/router/router_name.dart';
import 'package:flutter_exam/data/provider/user_provider.dart';

class UserDetail extends ConsumerWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserState userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.go(context.namedLocation(RouterName.home)),
          ),
          title: Text(userState.userData?.login ?? '')),
      body: Center(
        child: Expanded(
          flex: 8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(150.0),
                      child: userState.userData?.avatarUrl != null
                          ? Image(
                              width: 150.0,
                              height: 150.0,
                              image: NetworkImage(
                                  userState.userData?.avatarUrl ?? ''),
                            )
                          : null),
                  Text(userState.userData?.name ?? ''),
                  Text(userState.userData?.bio ?? ''),
                  const Divider(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userState.userData?.login ?? ''),
                      Text(
                          userState.userData!.siteAdmin == true ? '' : 'staff'),
                    ],
                  ),
                  Text(userState.userData?.location ?? ''),
                  Text(userState.userData?.blog ?? ''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
