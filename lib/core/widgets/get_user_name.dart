import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GetUserName extends StatelessWidget {
  const GetUserName({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Text('User');
    }

    final uid = user.uid;
    final userBox = Hive.box('userBox');

    final cachedUsername = userBox.get('username_$uid');

    if (cachedUsername != null) {
      return Text(cachedUsername);
    }

    final users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildSkeleton();
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return const Text('User');
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        final username = data['username'] ?? 'User';

        userBox.put('username_$uid', username);

        return Text(username);
      },
    );
  }

  Widget _buildSkeleton() {
    return Container(
      width: 90,
      height: 14,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
