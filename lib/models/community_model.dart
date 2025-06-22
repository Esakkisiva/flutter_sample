import 'package:cloud_firestore/cloud_firestore.dart';

class Community {
  final String id;
  final String name;
  final String description;
  final int memberCount;
  final String lastMessage;
  final String category;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.memberCount,
    required this.lastMessage,
    required this.category,
  });

  factory Community.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Community(
      id: doc.id,
      name: data['name'],
      description: data['description'],
      memberCount: data['memberCount'],
      lastMessage: data['lastMessage'],
      category: data['category'],
    );
  }
}