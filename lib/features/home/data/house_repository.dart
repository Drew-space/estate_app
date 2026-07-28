import 'package:cloud_firestore/cloud_firestore.dart';

class HouseRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getHouses() {
    return firestore.collection('houses').snapshots().map((snapshot) {
      List<Map<String, dynamic>> houseList = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> houseData = doc.data();

        houseData['id'] = doc.id;
        houseList.add(houseData);
      }

      return houseList;
    });
  }
}
