import 'package:driver/authentiction/signup_screen.dart';
import 'package:driver/mainScreen/main_screen.dart';
import 'package:driver/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:driver/globel/globel.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm(){

     if (!emailTextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg:"Email address is not valid.");
    }
    else if(passwordTextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "Password is required.");
    }
    else{
      LoginUserNow();
    }
  }
  LoginUserNow()async
  {
     showDialog(
        context: context, 
      barrierDismissible: false,
      builder: (BuildContext c){
        return ProgressDialog(massage: "Processing, Please wait....",);
      }
      );
      final User? firebaseUser =(
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error:" +msg.toString());
        })
        ).user;
        if (firebaseUser != null)
          {{
            DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("driver");
            driversRef.child(firebaseUser.uid).once().then((driverKey){
              final snap = driverKey.snapshot;
              if(snap.value != null){
                currentFirebaseUser = firebaseUser;
                Fluttertoast.showToast(msg: "Login Successful");
                Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));

              }
              else{
                Fluttertoast.showToast(msg: "No record exist with this email.");
                fAuth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
              }
            });

          }}
        else{
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "UnLogin Successful");
        }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
              const SizedBox(height: 80,),
                Center(
                  child: Image.asset(
                  "image/logo.png", // Path to your logo image file
                  width: 150 ,
                  height: 150,
                            ),
                ),
              const SizedBox(height: 15,),
               const Text(
                "Login as a Driver",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),  
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: TextFormField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: "abc@gmail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey

                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: TextFormField(
                  controller: passwordTextEditingController ,
                  keyboardType: TextInputType.text,
                  obscureText:true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: "********",
                   border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey
                  
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
               const SizedBox(height: 15,),
               ElevatedButton(
                onPressed: () {
                 validateForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  '  Login ',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),

               const SizedBox(height: 12.0),

              TextButton(
                child: const Text(
                  "Don't have an Account? Signup here"
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c) => SignUpScreen()));
                }
              ),
           
        ]) ,
      ),
    );
  }
}