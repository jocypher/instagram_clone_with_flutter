
class User{
  final String email;
  final String uid;
  final String bio;
  final String photoUrl;
  final String username;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.following,
    required this.username
});

  Map<String, dynamic> toJson() => {
  'username' : username,
  'photoUrl': photoUrl,
  'email': email,
  'uid': uid,
  'bio': bio,
  'followers': followers,
  'following' : following,
  };

}