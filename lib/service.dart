import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_phanquyen/model/infor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_phanquyen/model/user.dart';

class Services {
  Future addUsers(Users user, String id) async {
    final docUsers = FirebaseFirestore.instance.collection('Users');
    user.id = id;
    await docUsers.doc(id).set(user.toJson());
  }

  Future addInfors(Infor infor, String id) async {
    final docUsers = FirebaseFirestore.instance
        .collection('Users')
        .doc(id)
        .collection("Infors")
        .doc();
    await docUsers.set(infor.toJson());
    final docInfors =
        FirebaseFirestore.instance.collection('Infors').doc(docUsers.id);
    await docInfors.set(infor.toJson());
  }
}

















// Future addUsers2(Users user, String id) async {
  //   final docUsers = FirebaseDatabase.instance.reference().child("Users");
  //   await docUsers.child(id).set(
  //     {'email': user.email, 'pasword': user.password, 'role': user.role},
  //   );
  // }