import 'package:flutter/material.dart';
import 'util/header.dart';

class About extends StatefulWidget {
  About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: false,
      ),
      body: Center(
        child: ListView(
          // scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(30),
          children: [
            setImage(),
            const SizedBox(height: 10),
            setTitle(),
            const SizedBox(height: 10),
            aboutMobstac(),
            const SizedBox(height: 30),
            setText("What is Beaconstac?"),
            playIntro(),
            const SizedBox(height: 20),
            setSocialText(),
            const SizedBox(height: 10),
            setSocialLinks()
          ],
        ),
      ),
    );
  }

  Widget aboutMobstac() {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: const TextStyle(
            letterSpacing: 1.0,
            fontSize: 20.0,
            color: Colors.black,
            fontFamily: 'Roboto'),
        children: <TextSpan>[
          TextSpan(
              text:
                  'MobStac started with a simple mission: to connect the digital and physical worlds through the use of innovative technology. With worldwide smartphone usage skyrocketing, our '),
          TextSpan(
              text: 'co-founders Sharat Potharaju and Ravi Pratap ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  '''realized that they would first need to address the world of mobile in pursuit of this goal.
                   
                   In June 2009, they founded MobStac in order to improve the accessibility and quality of mobile experiences offered by businesses and brands around the world. In these early years, we focused on helping publishers build adaptive mobile sites that would work seamlessly across multiple devices.
                   
                   In 2014, we shifted our focus to the emerging field of proximity-based marketing and analytics as a new way to bridge online and offline experiences. 
                   
                   Today, MobStac helps businesses and brands leverage BLE beacon technology to deliver context-rich experiences to their end users. Whether these are shoppers in brick-and-mortar stores, customers at restaurants or users interacting with your business in a number of other ways, we are excited about the possibilities for enhanced customer engagement with beacons. 
                   
                   We’ve seen that all components of these proximity marketing strategies must act in harmony in order to succeed, which is why our product Beaconstac offers hardware, software and a cloud-based platform to intuitively manage everything in one place.Here at MobStac, we believe personalized engagement and in-depth analytics should not be limited to the digital world. We envision a day when anyone—developers, marketers, product managers and everyone in between—can create equally amazing and insightful user experiences for physical spaces. In fact, this future is closer than you might think—and we’re working tirelessly to bring it even closer using the power of proximity.''')
        ],
      ),
    );
  }
}
