import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? profession;
  final String? location;
  final String? workplace;
  final String? hometown;
  final String? education;
  final int? following;
  final int? followers;
  final int? lives;

  AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.profession,
    this.location,
    this.workplace,
    this.hometown,
    this.education,
    this.following,
    this.followers,
    this.lives,
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return AppUser(
      uid: doc.id,
      email: data['email'],
      displayName: data['displayName'],
      photoUrl: data['photoUrl'],
      profession: data['profession'],
      location: data['location'],
      workplace: data['workplace'],
      hometown: data['hometown'],
      education: data['education'],
      following: data['following'],
      followers: data['followers'],
      lives: data['lives'],
    );
  }
}