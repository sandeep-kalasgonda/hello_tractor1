import 'package:driver/mainScreen/main_screen.dart';
import 'package:driver/splashscreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:driver/globel/globel.dart';
import 'package:driver/authentiction/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/progress_dialog.dart';





class SignUpScreen extends StatefulWidget {
    

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm(){

    if(nameTextEditingController.text.length<3){
      Fluttertoast.showToast(msg:"name must be atleast 3 characters.");
    }
    else if (!emailTextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg:"Email address is not valid.");
    }
    else if(phoneTextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "Phone number is required.");
    }
    else if(passwordTextEditingController.text.length<6){
      Fluttertoast.showToast(msg: "Password must be atleast characters.");
    }
    else{
      saveUserInfo();

    }
  }
  saveUserInfo()async
  {
     showDialog(
        context: context, 
      barrierDismissible: false,
      builder: (BuildContext c){
        return ProgressDialog(massage: "Processing, Please wait....",);
      }
      );
      final User? firebaseUser =(
        await fAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error:" +msg.toString());
        })
        ).user;
        if (firebaseUser != null){
          Map userMap = {
            "id": firebaseUser.uid,
            "name":nameTextEditingController.text.trim(),
            "email":emailTextEditingController.text.trim(),
            "phone":phoneTextEditingController.text.trim(),
          };
          DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("users");
  driversRef.child(firebaseUser.uid).set(userMap);

  currentFirebaseUser = firebaseUser;
  Fluttertoast.showToast(msg: "Account has created");
  // ignore: use_build_context_synchronously
  Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
        else{
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "account has not been created");
        }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:Center(
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
                "Register as a Farmer",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
               SizedBox(height: 20,),
               Padding(
                 padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                 child: TextFormField(
                  controller: nameTextEditingController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: "sandeep kalasgonda",
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: TextFormField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    hintText: "8530790000",
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
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: (
                ) {
                  validateForm();
                 Navigator.push(context, MaterialPageRoute(builder: (c) => Mainscreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  '  Create Account  ',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 12.0),
              TextButton(
                  child: const Text(
                      "Already have an Account? Login Here"
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                  }
              ),
              const SizedBox(height: 12.0),
            ],

          ),
        ),
         ),
    );
  }
}
