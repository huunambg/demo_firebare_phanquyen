import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_phanquyen/model/infor.dart';
import 'package:demo_phanquyen/screens/home/components/dialogadd.dart';
import 'package:demo_phanquyen/screens/login/login.dart';
import 'package:demo_phanquyen/service.dart';
import 'package:demo_phanquyen/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Infor> infors = [];
  final user = FirebaseAuth.instance.currentUser;
  String? id;
  void getuser() async {
    id = user!.uid;
  }

  // fetchdatabaselist() async {
  //   List items = [];
  //   dynamic _x = await Services().getData();
  //   if (_x == null) {
  //     print('error');
  //   } else {
  //     items = _x;
  //     items.forEach((element) {
  //       Infor a = new Infor(
  //           id: element['id'],
  //           tenKhach: element['tenKhach'],
  //           sdt: element['sdt'],
  //           gia: element['gia'],
  //           diemA: element['diemA'],
  //           diemB: element['diemB']);
  //       setState(() {
  //         if (a.id == id) {
  //           infors.add(a);
  //         }
  //         ;
  //       });
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
    // fetchdatabaselist();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("User:${user!.email}"),
        actions: [
          IconButton(
              onPressed: () {
                NDialog(
                  dialogStyle: DialogStyle(titleDivider: true),
                  title: Text("Thêm Nhân Viên"),
                  actions: <Widget>[CustomDialogAdd()],
                ).show(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 199, 235, 187),
            height: h * 0.7,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(id)
                    .collection("Infors")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Loi "),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        padding: EdgeInsets.all(5),
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
                                  "${snapshot.data!.docs[index]['tenKhach']}"),
                              leading:
                                  Text("${snapshot.data!.docs[index]['gia']}"),
                              subtitle: Text(
                                  "${snapshot.data!.docs[index]['diemA']} to  ${snapshot.data!.docs[index]['diemB']}"),
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
