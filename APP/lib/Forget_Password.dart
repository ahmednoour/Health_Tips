import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailcontroller = TextEditingController();
  @override
  void dispose(){
    _emailcontroller.dispose();
    super.dispose();
  }
  Future verifyEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailcontroller.text.trim());
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              content: Text('Check your email...'),
            );
          }
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 10,
        title: Text(
            'Reset Password'
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text('Please enter your email',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20,),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailcontroller,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
              ),
            ),
          ),
          SizedBox(height: 20,),
          MaterialButton(onPressed:verifyEmail,
            child: Text(
              'Reset Password',
            ),
            color: Colors.grey[500],
          ),

        ],

      ),
    );
  }
}
