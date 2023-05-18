import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/screen/auth/userType/usertype_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({Key? key}) : super(key: key);

  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          color: lightblueColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/logo.png', fit: BoxFit.scaleDown,)),

              SizedBox(
                height: 10,),
              Center(child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Kindly wait for admin approval your status is Pending', style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 32),textAlign: TextAlign.center),
              )),
              SizedBox(
                height: size.height*0.05,
              ),
              Container(

                decoration: BoxDecoration(

                  // border: Border.all(width: 0.5,color: Colors.black),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      darkRedColor,
                      lightRedColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
                      backgroundColor:
                      MaterialStateProperty.all(buttonColor),
                      // elevation: MaterialStateProperty.all(3),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),

                    onPressed: () async {

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      try {
                        return await _auth.signOut().whenComplete(() {
                          prefs.remove('userEmail');
                          prefs.remove('userType');
                          prefs.remove('userPassword');
                          prefs.remove('userId');
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserType()));
                        });
                      } catch (e) {
                        return null;
                      }
                    }, child: Text('OK', style: buttonStyle)),
              ),
              SizedBox(
                height: size.height*0.03,
              ),

            ],
          ),
        ),
      );


  }
}
