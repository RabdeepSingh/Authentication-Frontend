import 'package:authentication/about.dart';
import 'package:authentication/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

YoutubePlayerController _controller = YoutubePlayerController(
  initialVideoId: 'F3_XE1qc700',
  flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
      loop: true,
      hideControls: false,
      hideThumbnail: false,
      disableDragSeek: false,
      isLive: false,
      forceHD: false),
);

Widget playIntro() {
  return Expanded(
    child: YoutubePlayer(
      controller: _controller,
      liveUIColor: Colors.amber,
    ),
  );
}

Widget setSocialText() {
  return Text('Social Links ',
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Pacifico',
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.blue));
}

Widget setFloatingButton(BuildContext context) {
  return SpeedDial(
    backgroundColor: Colors.blue[600],
    animatedIcon: AnimatedIcons.menu_close,
    children: [
      SpeedDialChild(
        child: Icon(Icons.contact_page),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        onTap: () => {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => Contact())),
        },
        label: 'Contact',
      ),
      SpeedDialChild(
        child: Icon(Icons.info),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        onTap: () => {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => About())),
        },
        label: 'About',
      ),
    ],
  );
}

Widget setSocialLinks() {
  return Row(
    children: [
      Expanded(
        child: IconButton(
            tooltip: 'Beaconstac website',
            onPressed: () => {launch('https://www.beaconstac.com/')},
            icon: FaIcon(FontAwesomeIcons.link)),
      ),
      Expanded(
        child: IconButton(
            tooltip: 'Twitter page of Beaconstac',
            onPressed: () => launch('https://twitter.com/beaconstac'),
            icon: FaIcon(FontAwesomeIcons.twitter)),
      ),
      Expanded(
        child: IconButton(
            tooltip: 'Facebook page of Beaconstac',
            onPressed: () => launch('https://www.facebook.com/beaconstac'),
            icon: FaIcon(FontAwesomeIcons.facebook)),
      ),
      Expanded(
        child: IconButton(
            tooltip: 'Instagram page of Beaconstac',
            onPressed: () =>
                launch('https://www.instagram.com/beaconstac/?hl=en'),
            icon: FaIcon(FontAwesomeIcons.instagram)),
      ),
      Expanded(
        child: IconButton(
            tooltip: 'LinkedIn page of Beaconstac',
            onPressed: () => launch('https://www.linkedin.com/company/mobstac'),
            icon: FaIcon(FontAwesomeIcons.linkedin)),
      ),
      Expanded(
        child: IconButton(
            tooltip: 'Youtube channel of Beaconstac',
            onPressed: () => launch(
                'https://www.youtube.com/channel/UCkr_QT-41Socd--jK37LNXA?app=desktop'),
            icon: FaIcon(FontAwesomeIcons.youtube)),
      )
    ],
  );
}

Widget setImage() {
  return CircleAvatar(
    radius: 50,
    child: ClipOval(
      child: Image.asset('images/bsqe.jpeg'),
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
        fontSize: 50,
        color: Colors.blue),
  );
}

Widget setText(String s) {
  return Text(
    '$s',
    textAlign: TextAlign.left,
    style: TextStyle(
        fontFamily: 'Pacifico',
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.blue),
  );
}
