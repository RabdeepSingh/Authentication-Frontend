import 'package:authentication/util/header.dart';
import 'package:authentication/util/session_data.dart';
import 'package:flutter/material.dart';
import 'package:authentication/signin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future logout() async {
    print("logout");
    await UserSecureStorage.deleteUserdata();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
  }

  var userVal = ["", "", ""];
  getUserData() async {
    var userData = await UserSecureStorage.getUserdata();
    setState(() {
      userVal[0] = userData![0];
      userVal[1] = userData[1];
      userVal[2] = userData[2];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DASHBOARD"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              setImage(),
              setTitle(),
              addTable(),
              SizedBox(height: 200),
              logoutButton(),
            ],
          ),
        ),
        floatingActionButton: setFloatingButton(context));
  }

  Widget addTable() {
    return DataTable(columns: [
      DataColumn(
          label: Text('USER INFO',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Colors.blue))),
      DataColumn(label: Text('')),
    ], rows: [
      DataRow(cells: [
        DataCell(Text(
          'ID',
          style: TextStyle(fontFamily: 'Roboto'),
        )),
        DataCell(showId()),
      ]),
      DataRow(cells: [
        DataCell(Text('NAME', style: TextStyle(fontFamily: 'Roboto'))),
        DataCell(showName()),
      ]),
      DataRow(cells: [
        DataCell(Text('Email', style: TextStyle(fontFamily: 'Roboto'))),
        DataCell(showEmail()),
      ])
    ]);
  }

  Widget showId() {
    return Text(userVal[0] != '' ? '${userVal[0]}' : 'Loading...',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          color: Color.fromARGB(255, 56, 52, 52),
        ));
  }

  Widget showName() {
    return Text(userVal[1] != '' ? userVal[1] : 'Loading...',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          color: Color.fromARGB(255, 56, 52, 52),
        ));
  }

  Widget showEmail() {
    return Text(userVal[2] != '' ? userVal[2] : 'Loading...',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          color: Color.fromARGB(255, 56, 52, 52),
        ));
  }

  Widget logoutButton() {
    return FlatButton(
      minWidth: 200.0,
      height: 50,
      color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      onPressed: () {
        logout();

        Fluttertoast.showToast(
            msg: "Logout Successfull!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      child: Text(
        "Logout",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
