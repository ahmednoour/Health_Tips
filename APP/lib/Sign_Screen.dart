import 'package:app_med/Enter_Symptoms.dart';
import 'package:app_med/Forget_Password.dart';
import 'package:app_med/Google_Firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_med/Get_Started.dart';
import 'package:app_med/SignUp_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Welcome_Screen.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  //Form key
  final formKey = GlobalKey<FormState>();
  //editing controller
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //firebase
  final _auth = FirebaseAuth.instance;
  bool isHiddenPassword=true;

  @override
  Widget build(BuildContext context) {

    final emailfield = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),

    ));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: isHiddenPassword,
        validator: (value) {
          RegExp regex =  RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: InkWell(
            onTap: _togglePasswordView,
            child: Icon(
                Icons.visibility
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.blueAccent,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                     child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/hospital.png'),
                      ),
                    ),
                  ),
                    ),
                    SizedBox(height: 45),
                    emailfield,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 10,),
                    GestureDetector(
                       child: Text("Forget your password?",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[500]
                          ),
                        ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgetPasswordPage(),
                      )),

                    ),
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 30),
                    RichText(text: TextSpan(
                      text: "OR ",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 20,
                      )
                    ),),
                    SizedBox(height: 30,),
                    FloatingActionButton.extended(
                      onPressed:() async {
                        await FirebaseServices().signInWithGoogle();
                        Navigator.push( (context),
                            MaterialPageRoute(builder: (context) => EnterSymptoms()));

                      },
                      icon: Image.asset("images/G.png",
                        height: 32,
                        width: 32,
                      ),

                      label: Text('Sign in with Gmail',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

void signIn(String email,String password) async {
  if(formKey.currentState!.validate()){
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid)=>
      {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EnterSymptoms() )),

      }).catchError((e)
          {
            Fluttertoast.showToast(msg: e!.message);
          });
    }
  }

  void _togglePasswordView(){
    if(isHiddenPassword==true)
    {
      isHiddenPassword=false;
    }
    else
    {
      isHiddenPassword=true;
    }
    setState(() {

    });
  }

}



