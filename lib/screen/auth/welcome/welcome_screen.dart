

import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/screen/auth/login/login_screen.dart';
import 'package:flutter_mechanic_app_fyp/screen/auth/signUp/sign_up_screen.dart';
import 'package:flutter/material.dart';
class WelcomeScreen extends StatefulWidget {
  final String userType;
  const WelcomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightblueColor,
      body:      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset('assets/images/logo.png', fit: BoxFit.cover,
              height: 120,
              width: 120,
            ),
          ),
          SizedBox(
            height: size.height*0.025,
          ),
          Text('ORVBA', style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 32),textAlign: TextAlign.center),
          // Text('THERAPY & COUNSELING', style:
          // TextStyle(color: Colors.white,fontWeight: FontWeight.w300,height: 2.5,fontSize: 12),textAlign: TextAlign.center,),

          SizedBox(
            height: size.height*0.05,
          ),
          Container(
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Container(

                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                    ],
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                    // border: Border.all(width: 0.5,color: Colors.black),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        buttonColor,
                        buttonColor,
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

                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen(userType: widget.userType,)),
                        );
                      }, child: Text('Login', style: buttonStyle)),
                ),

                SizedBox(
                  height: size.height*0.025,
                ),

                Container(

                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                    // ],
                    border: Border.all(color: Colors.white,width: 0.5),
                    color: buttonColor,
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

                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen(userType: widget.userType,)),
                        );

                      }, child: Text('Sign up', style: buttonStyle.copyWith(color: Colors.white))),
                ),

                SizedBox(
                  height: size.height*0.08,
                ),


                SizedBox(
                  height: size.height*0.025,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
