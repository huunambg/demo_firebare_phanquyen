import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_phanquyen/screens/login/login.dart';
import 'package:demo_phanquyen/main.dart';
import 'package:demo_phanquyen/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Admin: ${user!.email}"),
      ),
      body: Column(
        children: [
          Container(
            height: h*0.7,
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Infors').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Loi "),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                               
                          return Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(191, 69, 157, 216),
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              title: Text(
                                  "${snapshot.data!.docs[index]['tenKhach'].toString()}"),
                              leading: Text(
                                  "${snapshot.data!.docs[index]['gia'].toString()}"),
                              subtitle: Text(
                                  "${snapshot.data!.docs[index]['diemA'].toString()}  to  ${snapshot.data!.docs[index]['diemB'].toString()}"),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          Center(
            child: CustomButton(
                text: "Sigout",
                onpressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }),
          ),
        ],
      ),
    );
  }
}
