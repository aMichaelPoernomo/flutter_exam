import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_exam/data/model/user.dart';
import 'package:flutter_exam/data/repository/user_repository.dart';

class UserState {
  List<User> users = [];
  User? userData;

  UserState({
    this.users = const [],
    this.userData,
  });

  static UserState clone({required UserState newState}) {
    return UserState(users: newState.users, userData: newState.userData);
  }
}

final userStateProvider = Provider<UserState>((ref) {
  return UserState();
});

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(this.userRepository) : super(UserState());

  final UserRepository userRepository;

  Future<void> getUsers() async {
    try {
      final response = await userRepository.getUsers();
      if (response.statusCode == 200) {
        final data = (jsonDecode(response.body) as List<dynamic>).map((user) {
          return User.fromResponse(user);
        }).toList();
        state.users = data;
        state = UserState.clone(newState: state);
      } else {
        throw Exception('Error response code');
      }
    } catch (e) {
      state.users = [];
      throw Exception('Failed to load users');
    }
  }

  Future<void> getUser(String username) async {
    try {
      final response = await userRepository.getUser(username);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userData = User.fromResponse(data);
        state.userData = userData;
        state = UserState.clone(newState: state);
      } else {
        throw Exception('Error response code');
      }
    } catch (e) {
      state.users = [];
      throw Exception('Failed to load user detail');
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final userNotifier = UserNotifier(ref.watch(userRepositoryProvider));
  userNotifier.getUsers();
  return userNotifier;
});
