
import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/screen/auth/login/login_screen.dart';
import 'package:flutter_mechanic_app_fyp/screen/auth/welcome/welcome_screen.dart';




class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightblueColor,
      resizeToAvoidBottomInset: false,
      body: Container(

        width: size.width,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   stops: [0.0, 1.0],
          //   colors: [
          //     darkRedColor,
          //     lightRedColor,
          //
          //   ],
          // ),

        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child:Stack(children: <Widget>[ //stack overlaps widgets
                  Opacity( //semi red clippath with more height and with 0.5 opacity
                    opacity: 0.5,
                    child: ClipPath(
                      clipper:WaveClipper(), //set our custom wave clipper
                      child:Container(
                        color:Colors.lightBlue,
                        height:240,
                      ),
                    ),
                  ),

                  ClipPath(  //upper clippath with less height
                    clipper:WaveClipper(), //set our custom wave clipper.
                    child:Container(
                        padding: EdgeInsets.only(bottom: 50),
                        color:Colors.lightBlueAccent,
                        height:220,
                        alignment: Alignment.center,
                        child:            Text('WELCOME TO ORVBA', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),textAlign: TextAlign.center),

                    ),
                  ),
                ],)
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/images/logo.png', fit: BoxFit.scaleDown,
                height: size.height*0.15,
                width: size.width*0.7,
              ),
            ),
            SizedBox(
              height: size.height*0.05,
            ),
            // Text('THERAPY & COUNSELING', style:
            // TextStyle(color: Colors.white,fontWeight: FontWeight.w300,height: 2.5,fontSize: 12),textAlign: TextAlign.center,),
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

                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        LoginScreen(userType: 'Admin',)));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                  }, child: Text('Admin', style: buttonStyle)),
            ),
          SizedBox(
            height: size.height*0.03,
          ),
            Container(

              decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                // ],
                border: Border.all(color: Colors.white,width: 0.2),
               // color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    darkRedColor,
                    lightRedColor,
                  ],
                ),
                // color: Colors.deepPurple.shade300,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen(userType: 'Users',)));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                    // );

                  }, child: Text('User', style: buttonStyle.copyWith(color: Colors.white))),
            ),
          SizedBox(
            height: size.height*0.03,
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

                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        LoginScreen(userType: 'Mechanic',)));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                  }, child: Text('Mechanic', style: buttonStyle)),
            ),


        ],),
      ),
    );
  }
}
