import 'package:app_med/Sign_Screen.dart';
import 'package:app_med/Welcome_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: const AssetImage('images/Doctor.png'),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 6,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Online doctor is\nalways with you',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text('For your health you should \nconsult us ..',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.7),
                      ),

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen(),
                        ),
                      );
                },
                color: Colors.lightBlue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





