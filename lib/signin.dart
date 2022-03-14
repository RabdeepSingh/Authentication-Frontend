import 'dart:convert';
import 'package:authentication/User.dart';
import 'package:authentication/util/header.dart';
import 'package:authentication/signup.dart';
import 'package:authentication/dashboard.dart';
import 'package:authentication/util/session_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Signin extends StatefulWidget {
  Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  String baseUrl = "http://localhost:5000/Users/signin";

  UserLogin user = new UserLogin('', '');

  Future save() async {
    var res = await http.post(Uri.parse(baseUrl), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      'email': user.email,
      'password': user.password
    });

    Map<String, dynamic> userData = jsonDecode(res.body);

    print('\n LOGIN : ');
    print('MESSAGE : ' + userData['message']);
    print('STATUS CODE : ${userData['statusCode']}');

    if (userData['statusCode'] == 404) {
      Fluttertoast.showToast(
          msg: "User not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (userData['statusCode'] == 401) {
      Fluttertoast.showToast(
          msg: "Incorrect Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_LEFT,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      List<String> userVal = [
        userData['user']['id'].toString(),
        userData['user']['name'],
        userData['user']['email']
      ];
      print(userVal);

      await UserSecureStorage.setUserdata(userVal);

      print('USER ID : ${userData['user']['id']}');
      print('USER NAME : ${userData['user']['name']}');
      print('USER EMAIL : ${userData['user']['email']}');
      print('PASSWORD : ${userData['user']['password']}');

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Dashboard()));

      Fluttertoast.showToast(
          msg: "Login Successfull!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: SvgPicture.asset('images/top.svg'),
              ),
              Container(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 200),
                        buildTitle(),
                        SizedBox(height: 30),
                        buildEmail(),
                        SizedBox(height: 30),
                        buildPassword(),
                        SizedBox(height: 30),
                        buildSigninButton(),
                        SizedBox(height: 30),
                        buildSignupRedirect(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: setFloatingButton(context));
  }

  Widget buildTitle() {
    return Text(
      "Signin",
      style: TextStyle(
          fontFamily: 'Pacifico',
          fontWeight: FontWeight.bold,
          fontSize: 50,
          color: Colors.blue),
    );
  }

  Widget buildEmail() {
    return TextFormField(
      controller: TextEditingController(text: user.email),
      onChanged: (value) {
        user.email = value;
      },
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Email Required';
        } else if (value != null &&
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
          return null;
        } else {
          return 'Enter valid email';
        }
      },
      decoration: InputDecoration(
        hintText: 'Enter Email',
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.blueAccent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.blueAccent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.redAccent)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.redAccent)),
      ),
    );
  }

  Widget buildPassword() {
    return TextFormField(
      controller: TextEditingController(text: user.password),
      onChanged: (value) {
        user.password = value;
      },
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Password Required';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter Password',
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.blueAccent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.blueAccent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.redAccent)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.redAccent)),
      ),
    );
  }

  Widget buildSigninButton() {
    return Container(
      height: 50,
      width: 400,
      child: FlatButton(
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              save();
            } else {
              // print("not ok");
            }
            ;
          },
          child: Text(
            "Signin",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }

  Widget buildSignupRedirect() {
    return Row(
      children: [
        Text("Not have account ?",
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        InkWell(
          onTap: () {
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Signup()));
          },
          child: Text(" Signup",
              textAlign: TextAlign.justify,
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
