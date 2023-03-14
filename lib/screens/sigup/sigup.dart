import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_phanquyen/model/user.dart';
import 'package:demo_phanquyen/screens/home/home_admin.dart';
import 'package:demo_phanquyen/screens/home/home_user.dart';
import 'package:demo_phanquyen/screens/login/login.dart';
import 'package:demo_phanquyen/service.dart';
import 'package:demo_phanquyen/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// day la man hinh dang ki
class Singup extends StatelessWidget {
  const Singup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: sg(),
    );
  }
}

class sg extends StatefulWidget {
  const sg({super.key});

  @override
  State<sg> createState() => _sgState();
}

class _sgState extends State<sg> {
  bool ischeckpass = true;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final retypepassword = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text("Singup"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
            SizedBox(
              height: 20,
            ),
            TextField(
                obscureText: ischeckpass,
                controller: passwordcontroller,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          ischeckpass = !ischeckpass;
                        });
                      },
                      child: Icon(ischeckpass
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
            SizedBox(
              height: 30,
            ),
            TextField(
                obscureText: ischeckpass,
                controller: retypepassword,
                decoration: InputDecoration(
                    labelText: "Retype-Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)))),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              text: "Sigup",
              onpressed: onpressed,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text("Back to Login"),
            )
          ],
        ),
      ),
    );
  }

// su kien kiem tra  tai khoan so voi database
  void onpressed() {
    if (emailcontroller.text != '' && passwordcontroller.text != '') {
      if (passwordcontroller.text != retypepassword.text) {
        CherryToast.error(title: Text("Re-entered password does not match"))
            .show(context);
      } else {
        singup();
      }
    }
  }

  Future singup() async {
    try {
      final _newuser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim());
      if (_newuser != null) {
        addUsers();
        try {
          final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim());
          if (user != null) {
            final useid = await FirebaseAuth.instance.currentUser;
            final id = useid?.uid;
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(id)
                .get()
                .then((value) {
              if (value['role'] == 'user') {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Admin()));
              }
              ;
            });
          } else {
            print("erorr");
          }
        } on FirebaseAuthException catch (e) {
          CherryToast.error(title: Text(e.toString())).show(context);
        }
      }
    } on FirebaseAuthException catch (e) {
      CherryToast.error(title: Text(e.toString())).show(context);
    }
  }

  void addUsers() async {
    final docUsers = await FirebaseFirestore.instance.collection("Users");
    final userid = await FirebaseAuth.instance.currentUser;
    Users _user = new Users();
    final x = Services();
    _user.email = emailcontroller.text;
    _user.password = passwordcontroller.text;
    _user.role = "user";
    final id = userid?.uid;
    x.addUsers(_user, id!);
  }
}
