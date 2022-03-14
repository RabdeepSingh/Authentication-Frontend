import 'dart:convert';
import 'package:authentication/util/header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:authentication/User.dart';
import 'package:authentication/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String baseUrl = "http://localhost:5000/Users/signup";
  UserRegister user = new UserRegister('', '', '');

  Future save() async {
    var res = await http.post(Uri.parse(baseUrl), headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      'name': user.name,
      'email': user.email,
      'password': user.password
    });

    Map<String, dynamic> userData = jsonDecode(res.body);
    print("\nREGISTRATION : ");
    print('USER NAME : ' + user.name);
    print('USER EMAIL : ' + user.email);
    print('USER PASSWORD : ' + user.password);
    if (userData['message'] == 'User Already Exists!') {
      Fluttertoast.showToast(
          msg: "User Already Exists!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Signin()));
      Fluttertoast.showToast(
          msg: "User Registration Successfull",
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
            child: Stack(children: [
          Positioned(
              top: 0,
              child: SvgPicture.asset(
                'images/top.svg',
              )),
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
                    buildName(),
                    SizedBox(height: 30),
                    buildEmail(),
                    SizedBox(height: 30),
                    buildPassword(),
                    SizedBox(height: 30),
                    buildSignupButton(),
                    SizedBox(height: 30),
                    buildSigninRedirect(),
                  ],
                ),
              ),
            ),
          )
        ])),
        floatingActionButton: setFloatingButton(context));
  }

  Widget buildTitle() {
    return Text(
      "Signup",
      style: TextStyle(
          fontFamily: 'Pacifico',
          fontWeight: FontWeight.bold,
          fontSize: 50,
          color: Colors.blue),
    );
  }

  Widget buildName() {
    return TextFormField(
      controller: TextEditingController(text: user.name),
      onChanged: (value) {
        user.name = value;
      },
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Name Required';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter Name',
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

  Widget buildEmail() {
    return TextFormField(
      controller: TextEditingController(text: user.email),
      onChanged: (value) {
        user.email = value;
      },
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Email required';
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

  Widget buildSignupButton() {
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
              print("not ok");
            }
          },
          child: Text(
            "Signup",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }

  Widget buildSigninRedirect() {
    return Row(
      children: [
        Text("Already have account ?",
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        InkWell(
          onTap: () {
            Navigator.push(
                context, new MaterialPageRoute(builder: (context) => Signin()));
          },
          child: Text(" Signin ",
              textAlign: TextAlign.justify,
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
