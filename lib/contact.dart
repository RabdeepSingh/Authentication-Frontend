import 'package:authentication/util/header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: ListView(
          children: [
            SizedBox(height: 20),
            setImage("images/bsqe.jpeg"),
            const SizedBox(height: 20),
            setTitle(),
            const SizedBox(height: 60),
            Row(
              children: [
                setImage("images/india.jpg"),
                setImage("images/usa.jpg"),
              ],
            ),
            SizedBox(height: 25),
            Row(children: [
              setAddress('29, MG Road'),
              setAddress('450 Lexington Avenue, 4th Floor'),
            ]),
            SizedBox(height: 5),
            Row(
              children: [
                setAddress('Bengaluru , Karnataka'),
                setAddress('New York, NY'),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                setAddress('560001'),
                setAddress('10017'),
              ],
            ),
            SizedBox(height: 25),
            setEmail(),
            SizedBox(height: 25),
            setContact(),
            SizedBox(height: 25),
            setSocialText(),
            setSocialLinks(),
          ],
        ),
      ),
    );
  }

  Widget setEmail() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '',
        children: <TextSpan>[
          TextSpan(
              text: 'Get in touch at :',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                fontFamily: 'Roboto',
                color: Colors.black,
              )),
          TextSpan(
              text: '\nhello@beaconstac.com',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch('https://gmail.com')),
        ],
      ),
    );
  }

  Widget setContact() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '',
        children: <TextSpan>[
          TextSpan(
              text: 'Contact no. :',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                fontFamily: 'Roboto',
                color: Colors.black,
              )),
          TextSpan(
              text: '\n+1 (646) 968 0378',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launch('tel://+15555648583')),
        ],
      ),
    );
  }

  Widget setAddress(String s) {
    return Expanded(
      flex: 1,
      child: Text('$s',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Roboto',
          )),
    );
  }

  Widget setImage(String s) {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        radius: 50,
        child: ClipOval(
          child: Image.asset(s),
        ),
      ),
    );
  }

  Widget setTitle() {
    return Text(
      "Mobstac",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Pacifico',
          fontWeight: FontWeight.bold,
          fontSize: 55,
          color: Colors.blue),
    );
  }
}
