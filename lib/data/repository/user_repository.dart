import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final apiUrl = 'https://api.github.com/users';
  final header = {'Authorization': 'Bearer {YOUR_AUTH}'};

  Future getUsers() async {
    return http.get(Uri.parse(apiUrl), headers: header);
  }

  Future getUser(String username) async {
    return http.get(Uri.parse(apiUrl + '/' + username), headers: header);
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
