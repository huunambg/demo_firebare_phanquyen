import 'dart:developer';
import 'dart:ffi';

import 'package:demo_phanquyen/model/infor.dart';
import 'package:demo_phanquyen/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ndialog/ndialog.dart';

class CustomDialogAdd extends StatefulWidget {
  const CustomDialogAdd({super.key});

  @override
  State<CustomDialogAdd> createState() => _CustomDialogAddState();
}

class _CustomDialogAddState extends State<CustomDialogAdd> {
  final user = FirebaseAuth.instance.currentUser;
  final tenKhachcontroller = TextEditingController();
  final sdtcontroller = TextEditingController();
  final diemAcontroller = TextEditingController();
  final diemBcontroller = TextEditingController();
  final giacontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: tenKhachcontroller,
            decoration: InputDecoration(
                labelText: "Nhập Tên",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: sdtcontroller,
            decoration: InputDecoration(
                labelText: "Nhập số điện thoại",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: diemAcontroller,
            decoration: InputDecoration(
                labelText: "Nhập điểm A",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: diemBcontroller,
            decoration: InputDecoration(
                labelText: "Nhập điểm B",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          margin: EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: giacontroller,
            decoration: InputDecoration(
                labelText: "Nhập gía",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Row(
          children: [
            TextButton(
                child: Text("Thêm"),
                onPressed: () async {
                  setState(() {});
                  Infor _infor = new Infor();
                  final x = Services();
                  _infor.tenKhach = tenKhachcontroller.text;
                  _infor.sdt = int.parse(sdtcontroller.text);
                  _infor.diemA = diemAcontroller.text;
                  _infor.diemB = diemBcontroller.text;
                  _infor.gia = int.parse(giacontroller.text);
                  x.addInfors(_infor,user!.uid);
                  Navigator.pop(context);
                }),
            TextButton(
                child: Text("Quay lại"),
                onPressed: () => Navigator.pop(context)),
          ],
        )
      ],
    );
  }
}
