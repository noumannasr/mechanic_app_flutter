
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/model/firebase_auth.dart';
import 'package:flutter_mechanic_app_fyp/model/input_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/screen/auth/login/login_screen.dart';
import 'package:flutter_mechanic_app_fyp/screen/home/home_screen.dart';
import 'package:flutter_mechanic_app_fyp/screen/mechanic/mechanicHome/approval_screen.dart';
import 'package:flutter_mechanic_app_fyp/screen/mechanic/mechanicHome/mechanic_home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  final String userType;
  const SignUpScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailControoler = TextEditingController();
  final TextEditingController _garageControoler = TextEditingController();
  final TextEditingController _phoneControoler = TextEditingController();
  final TextEditingController _passwordControoler = TextEditingController();
  final TextEditingController _confirmPasswordControoler = TextEditingController();
  final TextEditingController _firstNameControoler = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();
  LocationResult? result;

  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _isVisible = false;
  bool _isVisibleC = false;



  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isVisible = false;
      _isVisibleC = false;
      _isLoading = false;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightblueColor,

      //resizeToAvoidBottomInset: false,
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Container(
                child:Stack(children: <Widget>[ //stack overlaps widgets
                  Opacity( //semi red clippath with more height and with 0.5 opacity
                    opacity: 0.5,
                    child: ClipPath(
                      clipper:WaveClipper(), //set our custom wave clipper
                      child:Container(
                        color:primaryColor,
                        height:200,
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      Container(
                        width: size.width,
                        color: primaryColor,
                        child: Row(children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 16,top: 50),
                            child: IconButton(onPressed: (){
                              Navigator.of(context).pop();

                            }, icon: Icon(Icons.arrow_back_ios, size: 18,color: whiteColor,)),
                          )

                        ],),
                      ),
                      ClipPath(  //upper clippath with less height
                        clipper:WaveClipper(), //set our custom wave clipper.
                        child:Container(
                          padding: EdgeInsets.only(bottom: 100),
                          color:primaryColor,
                          height:140,
                          alignment: Alignment.center,
                          child:            Text('Create Account', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),textAlign: TextAlign.center),

                        ),
                      ),
                    ],
                  ),
                ],)
            ),



            // SizedBox(
            //   height: size.height*0.03,
            // ),

            Container(
              decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)
                  )
              ),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [



                    SizedBox(
                      height: size.height*0.025,
                    ),


                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _firstNameControoler,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,

                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: widget.userType == 'Mechanic' ?  "Owner Name" : "User Name",

                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    widget.userType == 'Mechanic' ?  SizedBox(
                      height: size.height*0.02,
                    ): Container(),
                    widget.userType == 'Mechanic' ?  Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _garageControoler,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,

                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Garage Name",

                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ) : Container(),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _emailControoler,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,

                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Email",

                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),


                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _phoneControoler,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },

                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),

                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Phone Number",

                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),


                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,top: 0),
                      child: TextFormField(
                        autofocus: true,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        controller: _passwordControoler,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,

                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          focusColor: Colors.white,
                          //add prefix icon
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Password",


                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,top: 0),
                      child: TextFormField(
                        autofocus: true,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        controller: _confirmPasswordControoler,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,

                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          focusColor: Colors.white,
                          //add prefix icon
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Confirm Password",


                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),


                        ),
                      ),
                    ),
                    widget.userType != 'Mechanic' ? SizedBox() :
                    SizedBox(
                      height: size.height*0.02,
                    ),

                    widget.userType != 'Mechanic' ? SizedBox() :
                    Container(
                      //color: whiteColor,
                      width: size.width * 0.9,
                      height: size.height *0.055,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {

                              result = await Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PlacePicker(googleMapKey,
                                        displayLocation: LatLng(21.4735,55.9754),
                                      )));

                              if(result!.latLng != null) {

                                print(result!.formattedAddress.toString() + ' This is place formattedAddress');

                                setState(() {
                                  _addressControoler.text =  result!.formattedAddress.toString();
                                  //name =  prefs.getString('userName')!;
                                });
                              }

                            },
                            child: Container(
                              width: size.width * 0.9,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), border: Border.all(color: lightRedColor, width: 1)),
                              //  width: size.width*0.15,
                              alignment: Alignment.centerLeft,
                              //  height: size.height*0.08,
                              child: Center(child: Text('Pick Location on map', style: TextStyle(color: lightRedColor,fontWeight: FontWeight.bold),)),
                            ),
                          ),
                        ],),
                    ),
                    SizedBox(
                      height: size.height*0.025,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,top: 0),
                      child: TextFormField(
                        autofocus: true,

                        keyboardType: TextInputType.streetAddress,
                        controller: _addressControoler,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,

                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          focusColor: Colors.white,
                          //add prefix icon
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Address",


                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),


                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.height*0.025,
                    ),


                    // git init
                    // git add README.md
                    // git commit -m "first commit"
                    // git branch -M main
                    // git remote add origin https://github.com/junaid4jd/flutter_mechanic_app_fyp.git
                    // git push -u origin main

                    _isLoading
                        ? CircularProgressIndicator(
                      color: buttonColor,
                      strokeWidth: 2,
                    )
                        :

                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      child: Container(

                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 1.0],
                            colors: [
                              buttonColor,
                              buttonColor,

                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                              backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                              // elevation: MaterialStateProperty.all(3),
                              shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                            ),

                            onPressed: () async {

                              // Navigator.pushReplacement(
                              //   context,
                              //   PageRouteBuilder(
                              //     pageBuilder: (c, a1, a2) => HomeScreen(),
                              //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                              //     transitionDuration: Duration(milliseconds: 100),
                              //   ),
                              // );

                              if (_inputValidator.validateName(
                                  _firstNameControoler.text) !=
                                  'success' &&
                                  _firstNameControoler.text.isNotEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Invalid User Name",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }

                              else if (_inputValidator.validateName(
                                  _garageControoler.text) !=
                                  'success' &&
                                  _garageControoler.text.isNotEmpty  && widget.userType == "Mechanic" ) {
                                Fluttertoast.showToast(
                                    msg: "Invalid Garage Name",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }


                              else if (_inputValidator.validateEmail(
                                  _emailControoler.text) !=
                                  'success' &&
                                  _emailControoler.text.isNotEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Wrong email address",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }

                              else if (_inputValidator.validateMobile(
                                  _phoneControoler.text) !=
                                  'success' &&
                                  _phoneControoler.text.isNotEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Phone Number Starts with + followed by code then number (Hint +923346567876)",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }

                              else if ((_passwordControoler.text.length <
                                  7 &&
                                  _passwordControoler
                                      .text.isNotEmpty) &&
                                  (_confirmPasswordControoler.text.length < 7 &&
                                      _confirmPasswordControoler
                                          .text.isNotEmpty)) {
                                Fluttertoast.showToast(
                                    msg: "Password and Confirm Password must be same",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );

                              }
                              else if (_passwordControoler.text !=
                                  _confirmPasswordControoler.text) {
                                Fluttertoast.showToast(
                                    msg: "Password and Confirm Password must be same",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                              else {
                                if(_firstNameControoler.text.isEmpty)
                                {
                                  Fluttertoast.showToast(
                                      msg: "User Name is required",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }

                                else if (
                                    _garageControoler.text.isEmpty  && widget.userType == "Mechanic" ) {
                                  Fluttertoast.showToast(
                                      msg: "Enter Garage Name",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }


                                else if(_emailControoler.text.isEmpty)
                                {
                                  Fluttertoast.showToast(
                                      msg: "Email Address is required",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }

                                else if(_phoneControoler.text.isEmpty)
                                {
                                  Fluttertoast.showToast(
                                      msg: "Phone number is required",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }

                                else if(_passwordControoler.text.isEmpty)
                                {
                                  Fluttertoast.showToast(
                                      msg: "Password is required",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                                else if(_confirmPasswordControoler.text.isEmpty)
                                {
                                  Fluttertoast.showToast(
                                      msg: "Confirm Password is required",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }

                                else if ( result == null ) {
                                  Fluttertoast.showToast(
                                      msg: "Choose garage location on map",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }

                                else if (
                                _addressControoler.text.isEmpty ) {
                                  Fluttertoast.showToast(
                                      msg: "Enter Address",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }



                                else {
                                  setState(() {
                                    _isLoading = true;
                                    print('We are in loading');
                                    //  state = ButtonState.loading;
                                  });

                                  print(_firstNameControoler.text.toString());
                                  print( _emailControoler.text.toString());
                                  print( _passwordControoler.text.toString());
                                  print( _phoneControoler.text.toString());
                                  //createAccount();
                                  //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();

                                  FirebaseFirestore.instance
                                      .collection(widget.userType.toString()).where(
                                      "email",isEqualTo: _emailControoler.text.trim()).get().then((value) async {


                                    if(value.docs.isNotEmpty) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Fluttertoast.showToast(
                                        msg: "Sorry email account already exists",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 4,
                                      );
                                    }
                                    else {

                                      try {

                                        User? result1 = (await _auth
                                            .createUserWithEmailAndPassword(
                                            email:
                                            _emailControoler.text.trim(),
                                            password: _passwordControoler.text
                                                .trim()))
                                            .user;

                                        if(result1 != null) {

                                          var user = result1;



                                          FirebaseFirestore.instance
                                              .collection(widget.userType.toString())
                                              .doc()
                                              .set({
                                            "email": _emailControoler.text.trim(),
                                            "password": _passwordControoler.text.trim(),
                                            "uid": user.uid,
                                            "status": "Pending",
                                            "name": _firstNameControoler.text,
                                            "phone": _phoneControoler.text,
                                            "garageName": _garageControoler.text,
                                            "userType": widget.userType.toString(),
                                            "lat": result!.latLng!.latitude,
                                            "long": result!.latLng!.longitude,
                                            "address":_addressControoler.text.toString(),

                                          }).then((value) => print('success'));




                                          prefs.setString('userType',
                                              widget.userType.toString());
                                          prefs.setString('userEmail',
                                              _emailControoler.text.trim());
                                          prefs.setString('userPassword',
                                              _passwordControoler.text.trim());
                                          prefs.setString('name',
                                              _firstNameControoler.text.trim());
                                          prefs.setString('userId', user.uid);
                                          print('Account creation successful');
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Navigator.of(context).pop();

                                          if(widget.userType.toString() == "Mechanic") {
                                            Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (c, a1, a2) => ApprovalScreen(),
                                                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                transitionDuration: Duration(milliseconds: 100),
                                              ),
                                            );
                                          } else {

                                            Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (c, a1, a2) => HomeScreen(),
                                                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                transitionDuration: Duration(milliseconds: 100),
                                              ),
                                            );
                                          }

                                          Fluttertoast.showToast(
                                            msg: "Account created successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 4,
                                          );


                                        }
                                        else {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          print('error');
                                        }

                                      }
                                      on FirebaseAuthException catch (e) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        if(e.code == 'email-already-in-use') {

                                          showAlertDialog(context, 'Sorry', 'The email address is already in use by another account.');
                                        }
                                        print(e.message);
                                        print(e.code);
                                      }

                                      await Future.delayed(Duration(seconds: 1));

                                    }

                                  });



                                }
                              }
                            }, child: Text('Sign Up', style: buttonStyle)),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.1,
                    ),


                  ],
                ),
              ),

            ),
          ],),
      ),
    );
  }




}

showAlertDialog(BuildContext context, String title, String content) {
  // set up the button

  CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: Text("$title"),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("$content"),
    ),
    actions: [
      // CupertinoDialogAction(
      //     child: Text("YES"),
      //     onPressed: ()
      //     {
      //       Navigator.of(context).pop();
      //     }
      // ),
      CupertinoDialogAction(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          })
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class FoodItem {

  final String image;
  final String title;
  final String description;

  FoodItem({
    required this.image,
    required this.title,
    required this.description,


  });

}