class User {
  final String login;
  final String avatarUrl;
  final String bio;
  final String name;
  final bool siteAdmin;
  final String location;
  final String blog;

  User({
    this.login = '',
    this.avatarUrl = '',
    this.bio = '',
    this.name = '',
    this.siteAdmin = true,
    this.location = '',
    this.blog = '',
  });

  static User fromResponse(apiUser) {
    return User(
      login: (apiUser['login'] ?? '').toString(),
      avatarUrl: (apiUser['avatar_url'] ?? '').toString(),
      bio: (apiUser['bio'] ?? '').toString(),
      name: (apiUser['name'] ?? '').toString(),
      siteAdmin: apiUser['site_admin'] == true,
      location: (apiUser['location'] ?? '').toString(),
      blog: (apiUser['blog'] ?? '').toString(),
    );
  }
}
