import 'package:app_med/Google_Firebase.dart';
import 'package:app_med/Sign_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EnterSymptoms extends StatefulWidget {
  const EnterSymptoms({Key? key}) : super(key: key);

  @override
  State<EnterSymptoms> createState() => _EnterSymptomsState();
}

class _EnterSymptomsState extends State<EnterSymptoms> {
  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    final predictButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          padding:const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {},
          child: Text(
            "Predict",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );


    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 70,),
                  Container(
                    width: w,
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          user.email!,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Symptoms");
                      }
                    }
                  ),
                  SizedBox(height: 50,),
                  predictButton,
                  SizedBox(height: 50,),
                  FloatingActionButton.extended(
                    onPressed: ()async{
                      await FirebaseServices().signOut();
                      Navigator.push( (context),
                          MaterialPageRoute(builder: (context) => SignScreen()));
                    },
                    label: Text(
                        "Logout",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight:FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: Colors.white,

                  )
                ],
              ),
            ),
          ),
        ),
    );
  }

}
