import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/model/firebase_auth.dart';
import 'package:flutter_mechanic_app_fyp/model/input_validator.dart';
import 'package:flutter_mechanic_app_fyp/screen/auth/login/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMechanicalServiceScreen extends StatefulWidget {
  final String name;
  final String descrition;
  final String price;
  final String docId;
  final String status;
  const AddMechanicalServiceScreen({Key? key,
    required this.name,
    required this.descrition,
    required this.price,
    required this.docId,
    required this.status,

  }) : super(key: key);

  @override
  _AddMechanicalServiceScreenState createState() => _AddMechanicalServiceScreenState();
}

class _AddMechanicalServiceScreenState extends State<AddMechanicalServiceScreen> {
  final TextEditingController _titleControoler = TextEditingController();
  final TextEditingController _descriptionControoler = TextEditingController();
  final TextEditingController _priceControoler = TextEditingController();
  final TextEditingController _passwordControoler = TextEditingController();
  final TextEditingController _confirmPasswordControoler = TextEditingController();
  final TextEditingController _firstNameControoler = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();

  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _isVisible = false;
  bool _isVisibleC = false;

  String name = '' , garageName = '',address = '',userType = '', status = '', uid = '';
  String text = '';
  int current = 0;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('Mechanic').where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
      setState(() {
        status = value.docs[0]['status'];
        name = value.docs[0]['name'];
        garageName = value.docs[0]['garageName'];
        address = value.docs[0]['address'];
        uid = value.docs[0]['uid'];

      });
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    if(widget.status == 'update') {
      setState(() {
        _titleControoler.text = widget.name;
        _descriptionControoler.text = widget.descrition;
        _priceControoler.text = widget.price;
      });
    }
    getData();
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
                          child:            Text('Add Service', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),textAlign: TextAlign.center),

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
                        controller: _titleControoler,
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
                          hintText:  "Service Name",

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
                        controller: _descriptionControoler,
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
                          hintText: "Service Description",

                          //make hint text
                          hintStyle: TextStyle(
                            color: buttonColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ) ,
                    SizedBox(
                      height: size.height*0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _priceControoler,
                        keyboardType: TextInputType.number,
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
                          hintText: "Service Charges",

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


                                if(_titleControoler.text.isEmpty)
                                {
                                  Fluttertoast.showToast(
                                      msg: "Service Name is required",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }

                                else if (
                                _descriptionControoler.text.isEmpty  ) {
                                  Fluttertoast.showToast(
                                      msg: "Enter Service Description",
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

                                  print(_titleControoler.text.toString());
                                  print( _descriptionControoler.text.toString());
                                  print( _passwordControoler.text.toString());
                                  //createAccount();
                                  //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();

                                  try {

                                    if(widget.status == 'update' ) {


                                      FirebaseFirestore.instance
                                          .collection("Services")
                                          .doc(widget.docId)
                                          .set({
                                        "mechanicName": name.toString(),
                                        "garageName": garageName.toString(),
                                        "mechanicId": uid,
                                        "servicePrice": _priceControoler.text,
                                        "serviceName": _titleControoler.text,
                                        "serviceDescription": _descriptionControoler.text,
                                        "address": address.toString(),

                                      }).then((value) => print('success'));

                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.of(context).pop();

                                      Fluttertoast.showToast(
                                        msg: "Service updated successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 4,
                                      );

                                    } else {


                                      FirebaseFirestore.instance
                                          .collection("Services")
                                          .doc()
                                          .set({
                                        "mechanicName": name.toString(),
                                        "garageName": _passwordControoler.text.trim(),
                                        "mechanicId": uid,
                                        "servicePrice": _priceControoler.text,
                                        "serviceName": _titleControoler.text,
                                        "serviceDescription": _descriptionControoler.text,
                                        "address": address.toString(),

                                      }).then((value) => print('success'));

                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.of(context).pop();

                                      Fluttertoast.showToast(
                                        msg: "Service added successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 4,
                                      );

                                    }



                                  }
                                  catch (e) {
                                    setState(() {
                                      _isLoading = false;
                                    });

                                    print(e.toString());
                                  }



                                }

                            }, child: Text(
                            widget.status == 'update' ? 'Update Service' :
                            'Add Service', style: buttonStyle)),
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
