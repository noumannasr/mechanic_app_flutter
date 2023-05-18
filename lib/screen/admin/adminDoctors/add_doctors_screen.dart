import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/model/firebase_auth.dart';
import 'package:flutter_mechanic_app_fyp/model/input_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:place_picker/place_picker.dart';

class AddDoctorScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String image;
  final String password;
  final String id;
  final String specialization;
  final String category;
  final String status;
  final String uid;

  const AddDoctorScreen({Key? key
  ,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.id,
    required this.uid,
    required this.status,
    required this.password,
    required this.category,
    required this.specialization,
  }) : super(key: key);

  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final TextEditingController _emailControoler = TextEditingController();
  final TextEditingController _phoneControoler = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _firstNameControoler = TextEditingController();
  final TextEditingController _passwordControoler = TextEditingController();
  String dropdownvalue = 'Select Specialization';
  String category = 'Select Category';
  var darkRedColor = Colors.black;
  bool  _imageLoading = false;
  LocationResult? result;
  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _isVisible = false;
  bool _isVisibleC = false;
  List general = [];


  List items = [
    'Select Specialization',
    'Psychiatrist',
    'Dermatologist',
    'Orthopaedist',
    'Neurologist',
    'Psychologist',
  ];

  List itemsCategory = [
    'Select Category',
    'Anxiety',
    'Depression',
    'Dementia',
  ];



  // Al-Kamil and Al-Wafi


  PickedFile? _pickedFile;

  final FirebaseAuth auth = FirebaseAuth.instance;
  String? profileImage, docId, userType, driverEmail = '', driverName = '', driverUid = '';

  void _showPicker(context, bool isProfile) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(isProfile);

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(isProfile);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera(bool isProfile) async {

    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50))!;
    setState(() {
      _imageLoading = true;
      print('List Printed');
      getUrl(_pickedFile!.path).then((value) {
        if (value != null) {
          setState(() {
            profileImage = value.toString();
            _imageLoading = false;
          });
        } else {
          setState(() {
            _imageLoading = false;
          });
          print('sorry error');
        }
      });
    });
  }

  _imgFromGallery(bool isProfile) async {


    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50))!;
    setState(() {
      _imageLoading = true;
      print('List Printed');
      getUrl(_pickedFile!.path).then((value) {
        if (value != null) {
          setState(() {
            profileImage = value.toString();
            _imageLoading = false;
          });

        } else {
          setState(() {
            _imageLoading = false;
          });
          print('sorry error');
        }
      });
    });
  }

  Future<String?> getUrl(String path) async {
    final file = File(path);
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child("image" + DateTime.now().toString())
        .putFile(file);
    if (snapshot.state == TaskState.success) {
      return await snapshot.ref.getDownloadURL();
    }

  }



  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isVisible = false;
      _isVisibleC = false;
      _isLoading = false;
    });

    if(widget.status == 'update') {

      setState(() {
        // isCreated = '';
        _emailControoler.text = widget.email;
        _passwordControoler.text = widget.password;
        _phoneControoler.text = widget.phone;
        _firstNameControoler.text = widget.name;
        dropdownvalue = widget.specialization;
        category = widget.category;
        //selectedWaliyat = 'Select Waliyat';
        profileImage = widget.image;
        _isLoading = false;
        _imageLoading = false;
      });

    } else {

      setState(() {
        // isCreated = '';
        // _vehicle5Controoler.text = '';
        dropdownvalue = 'Select Specialization';
        category = 'Select Category';
        //selectedWaliyat = 'Select Waliyat';
        profileImage = "";
        _isLoading = false;
        _imageLoading = false;
      });

    }


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // setState(() {
    //   _imageLoading = false;
    // });

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,

        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
       // leading: IconButton(onPressed: (), icon: Icon(Icons.)),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: size.width*0.1),
            Image.asset('assets/images/logo.jpeg',height: 30,),
            SizedBox(width: 10),
            Center(
                child: Text('Add Doctor', style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),)
            ),
          ],
        ),
      ),

      //resizeToAvoidBottomInset: false,
      body:  SingleChildScrollView(
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                //height: size.height*0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)
                    )
                ),
                child: Column(
                  children: [
                    // Center(
                    //     child: Text('Case to service', style: TextStyle(color: Color(0xFF585858), fontSize: 16,fontWeight: FontWeight.bold),)
                    // ),

                    SizedBox(
                      height: size.height*0.02,
                    ),


                    Container(
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
                            borderRadius: BorderRadius.circular(0.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),

                          //create lable
                          labelText: 'Full Name',
                          //lable style
                          labelStyle: TextStyle(
                            color: darkRedColor,
                            fontSize: 13,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _emailControoler,
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
                            borderRadius: BorderRadius.circular(0.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),

                          //create lable
                          labelText: 'Email Address',
                          //lable style
                          labelStyle: TextStyle(
                            color: darkRedColor,
                            fontSize: 13,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
                        controller: _phoneControoler,
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
                            borderRadius: BorderRadius.circular(0.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),

                          //create lable
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: darkRedColor,
                            fontSize: 13,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                      child: TextFormField(
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
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),

                          //create lable
                          labelText: 'Password',
                          //lable style
                          labelStyle: TextStyle(
                            color: darkRedColor,
                            fontSize: 13,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.005,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: darkGreyTextColor1),
                            color: Colors.white,
                            // image: DecorationImage(
                            //   image: AssetImage("assets/images/signin/textfield.png"),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                value: dropdownvalue,

                                hint: const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Select Specialization',
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  ),
                                ),
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                isDense: true, // Reduces the dropdowns height by +/- 50%
                                icon: Padding(
                                  padding:
                                  const EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: darkRedColor,
                                  ),
                                ),
                                items: items.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w400,
                                            color: darkRedColor,
                                            fontSize: 13),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (selectedItem) {

                                  setState(() {
                                    dropdownvalue = selectedItem.toString();

                                  });


                                }
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .005,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(color: darkGreyTextColor1),
                            color: Colors.white,
                            // image: DecorationImage(
                            //   image: AssetImage("assets/images/signin/textfield.png"),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                value: category,

                                hint: const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    'Select Category',
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  ),
                                ),
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                isDense: true, // Reduces the dropdowns height by +/- 50%
                                icon: Padding(
                                  padding:
                                  const EdgeInsets.only(right: 8),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: darkRedColor,
                                  ),
                                ),
                                items: itemsCategory.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w400,
                                            color: darkRedColor,
                                            fontSize: 13),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (selectedItem) {

                                  setState(() {
                                    category = selectedItem.toString();

                                  });


                                }
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),


                    Column(children: [

                      Container(
                        //color: whiteColor,
                        width: size.width * 0.9,
                        height: size.height *0.055,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showPicker(context,true);
                              },
                              child: Container(
                                width: size.width * 0.9,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), border: Border.all(color: primaryColor, width: 1)),
                                //  width: size.width*0.15,
                                alignment: Alignment.centerLeft,
                                //  height: size.height*0.08,
                                child: Center(child: Text('Upload Image', style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),)),
                              ),
                            ),
                          ],),
                      ),
                    ],
                    ),

                    _imageLoading ? Center(child: CircularProgressIndicator(color: darkRedColor,)) : Container(),

                    profileImage == "" ? Container() :

                    Container(
                      height: 120, width: 120,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.network(profileImage.toString(),
                                height: 120, width: 120, fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            // color: Colors.white,
                            child: IconButton(onPressed: (){
                              setState(() {
                                profileImage = "";
                              });
                            }, icon: Icon(Icons.cancel, color: Colors.red, size: 20,)),
                          ),
                        ],),
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),



                    _isLoading
                        ? CircularProgressIndicator(
                      color: primaryColor,
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
                              primaryColor,
                              primaryColor,

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
                              MaterialStateProperty.all(primaryColor),
                              // elevation: MaterialStateProperty.all(3),
                              shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                            ),

                            onPressed: () async {
                              // if (_inputValidator.validateName(
                              //     _firstNameControoler.text) !=
                              //     'success' &&
                              //     _firstNameControoler.text.isNotEmpty) {
                              //   Fluttertoast.showToast(
                              //       msg: "Invalid User Name",
                              //       toastLength: Toast.LENGTH_SHORT,
                              //       gravity: ToastGravity.BOTTOM,
                              //       timeInSecForIosWeb: 1,
                              //       backgroundColor: Colors.black,
                              //       textColor: Colors.white,
                              //       fontSize: 16.0
                              //   );
                              // }
                              // else
                                if (_inputValidator.validateEmail(
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

                                else if(dropdownvalue == 'Select Specialization')
                                {
                                  Fluttertoast.showToast(
                                      msg: 'Select Specialization',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }


                                else if(profileImage == "")
                                {
                                  Fluttertoast.showToast(
                                      msg: "Upload Profile",
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
                                  //createAccount();
                                  //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
                                 // SharedPreferences prefs = await SharedPreferences.getInstance();


                                  SharedPreferences prefs = await SharedPreferences.getInstance();


                                  if(widget.status == 'update') {


                                    FirebaseFirestore.instance
                                        .collection("Doctors")
                                        .doc(widget.id.toString())
                                        .set({

                                      "email": _emailControoler.text.trim(),
                                      "password": _passwordControoler.text.trim(),
                                      "phone": _phoneControoler.text.trim(),
                                      "name": _firstNameControoler.text,
                                      "specialization": dropdownvalue.toString(),
                                      "image": profileImage.toString(),
                                      "category": category.toString(),
                                      "uid": widget.uid.toString(),

                                    }).then((value) {

                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.of(context).pop();

                                      Fluttertoast.showToast(
                                        msg: "Doctor updated successfully",
                                        toastLength: Toast.LENGTH_LONG,
                                        backgroundColor: Colors.green,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 4,
                                      );

                                    });


                                  } else {

                                    FirebaseFirestore.instance
                                        .collection("Doctors").where(
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

                                          User? result = (await _auth
                                              .createUserWithEmailAndPassword(
                                              email:
                                              _emailControoler.text.trim(),
                                              password: _passwordControoler.text
                                                  .trim()))
                                              .user;

                                          if(result != null) {

                                            var user = result;

                                            FirebaseFirestore.instance
                                                .collection("Doctors")
                                                .doc()
                                                .set({

                                              "email": _emailControoler.text.trim(),
                                              "password": _passwordControoler.text.trim(),
                                              "phone": _phoneControoler.text.trim(),
                                              "name": _firstNameControoler.text,
                                              "specialization": dropdownvalue.toString(),
                                              "image": profileImage.toString(),
                                              "category": category.toString(),
                                              "uid": user.uid.toString(),

                                            }).then((value) {

                                              setState(() {
                                                _isLoading = false;
                                              });
                                              Navigator.of(context).pop();

                                              Fluttertoast.showToast(
                                                msg: "Doctor created successfully",
                                                toastLength: Toast.LENGTH_LONG,
                                                backgroundColor: Colors.green,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 4,
                                              );

                                            });


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
                              }
                            }, child: Text('Submit', style: buttonStyle)),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.1,
                    ),


                  ],
                ),

              ),
            ],),
        ),
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