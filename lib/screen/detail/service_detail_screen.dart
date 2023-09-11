import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/model/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

enum PaymentType { Credit_Debit, ConDelivery }


class ServiceDetailScreen extends StatefulWidget {
  final String mechanicName;
  final String mechanicId;
  final String serviceName;
  final String servicePrice;
  final String serviceDescription;
  final String garageName;
  final String userName;
  final String userEmail;
  final String address;
  final String status;
  final String payment;
  final String mechanicPhone;

  const ServiceDetailScreen({Key? key,
    required this.mechanicName,
    required this.mechanicId,
    required this.mechanicPhone,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceDescription,
    required this.garageName,
    required this.address,
    required this.userEmail,
    required this.userName,
    required this.payment,
    required this.status,

  }) : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  final TextEditingController _cardUserControler = TextEditingController();
  final TextEditingController _cardNumberControler = TextEditingController();
  final TextEditingController _cardCVCControler = TextEditingController();
  final TextEditingController _cardDateControler = TextEditingController();
  MethodsHandler _methodsHandler = MethodsHandler();
  PaymentType _site = PaymentType.ConDelivery;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String isCreated = '',  endTime = '' ;
  DateTime? _chosenDateTime;
  int y=0;
  String? renterEmail = '', renterName = '', renterUid = '',userType = '';

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    // print(widget.paymentMethod.toString());
    //  if(widget.way == "booking" || widget.way == "driver") {
    //    setState(() {
    //      _site = widget.paymentMethod.toString() == "Credit/Debit Card" ? PaymentType.Credit_Debit : PaymentType.ConDelivery;
    //      _cardUserControler.text = widget.cardHolderName.toString();
    //      _cardNumberControler.text = widget.cardHolderNumber.toString();
    //      _cardDateControler.text = widget.cardDate.toString();
    //      _cardCVCControler.text = widget.cardCVC.toString();
    //    });
    //  }
    getUser();
    setState(() {
      y=0;
      renterName = '';
      renterEmail = '';
      renterUid = '';
      isCreated = '';
      _isLoading = false;
    });
    getRenter();
    super.initState();
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      //userType = prefs.getString('userType')!;
      userType = prefs.getString('userType')!;
    });
    print(userType.toString() + '  userType here');
    print(widget.mechanicPhone.toString() + '  userType here');


  }

  getRenter() async {
    setState(() {
      y=1;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('Users')
        .where('uid',isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        renterName = value.docs[0]['name'];
        renterEmail = value.docs[0]['email'];
        renterUid = _auth.currentUser!.uid;
      });
    });
    print(renterName.toString() + ' name is here');
    print(renterEmail.toString() + ' name is here');
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightblueColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'Service Detail',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),

            Container(
              width: size.width * .9,
              // height: size.height*0.1,
              // decoration: BoxDecoration(
              //     color: whiteColor, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.only(left: 0, right: 0, top: 12, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Mechanic Name : '+widget.mechanicName.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  userType != 'Mechanic' ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Call ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // https://wa.me/+923314257676
                          // whatsapp://send?phone=+923314257676
                          try{

                            // if (await canLaunch('whatsapp://send?phone=+923426202434')) {
                            //   await launch('whatsapp://send?phone=+923426202434');
                            // }
                            //https://api.whatsapp.com/send?phone=+923426202434
                            if (await canLaunch('whatsapp://send?phone=${widget.mechanicPhone}')) {
                              await launch('whatsapp://send?phone=${widget.mechanicPhone}');
                            }
                            else {

                              Fluttertoast.showToast(
                                  msg: 'Sorry could not launch',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blueGrey,
                                  textColor: Colors.white);

                            }

                          } catch (e) {
                            print(e.toString()+ ' This is e');
                          }


                        },
                        child: Image.asset('assets/images/whatsapp.png',
                          width: 40,
                          fit: BoxFit.scaleDown,
                          height: 40,
                        ),
                      ),

                    ],
                  ) : Container(),

                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),

            Container(
              // height: size.height * 0.25,
              width: size.width,
              decoration: BoxDecoration(
                //color: lightButtonGreyColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height * 0.055,
                      color: lightButtonGreyColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Service Name ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.serviceName.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      height: size.height * 0.055,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Service Price',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                                'OMR ' + widget.servicePrice.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      height: size.height * 0.055,
                      color: lightButtonGreyColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Garage Name ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.garageName.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      height: size.height * 0.055,
                      color: lightButtonGreyColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'User Name ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.userName.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      height: size.height * 0.055,
                      color: lightButtonGreyColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'User Email ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.userEmail.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            widget.status != "view" ? SizedBox() :
            Column(children: [

              SizedBox(
                height: size.height * 0.01,
              ),

              Container(
                // height: size.height * 0.25,
                width: size.width,
                decoration: BoxDecoration(
                  color: lightButtonGreyColor,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        height: size.height * 0.055,
                        //   color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Payment',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.payment.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),





            ],
            ),

            SizedBox(
              height: size.height * 0.01,
            ),


            Container(
              // height: size.height * 0.25,
              width: size.width,
              decoration: BoxDecoration(
                color: lightButtonGreyColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Container(
                      // height: size.height * 0.055,
                      //   color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),

                            SizedBox(
                              height: size.height * 0.015,
                            ),

                            Text(
                              widget.address.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            widget.status == "view" ? SizedBox() :
            Column(
              children: [
                Container(
                  width: size.width * .9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Method',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  width: size.width * .9,
                  decoration: _site.toString() == 'PaymentType.Credit_Debit'
                      ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)))
                      : BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: primaryColor,
                              value: PaymentType.Credit_Debit,
                              groupValue: _site,
                              onChanged: (PaymentType? value) {
                                setState(() {
                                  _site = value!;
                                });
                                print(_site.toString());
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child:
                              Text('Credit/Debit/ATM Card', style: body3Black),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              _site.toString() == 'PaymentType.Credit_Debit'
                                  ? Icons.keyboard_arrow_down
                                  : Icons.arrow_forward_ios_sharp,
                              size: 25,
                              color: textColor,
                            ))
                      ],
                    ),
                  ),
                ),
                _site.toString() == 'PaymentType.Credit_Debit'
                    ? Column(
                  children: [
                    Container(
                      width: size.width * .9,
                      //  height: size.height*0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                            ),
                            child: Container(
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: greyColor1, width: 0.5),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  controller: _cardUserControler,
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.black,
                                  //   enabled: widget.way == "booking" || widget.way == "driver" ? false : true,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: whiteColor,
                                    contentPadding: EdgeInsets.only(
                                        left: 9.0, top: 0, bottom: 0),
                                    hintText: 'Card Holder Name',
                                    labelStyle: body1Black,
                                    hintStyle: TextStyle(color: greyColor),
                                  ),
                                  onChanged: (String value) {},
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: Container(
                                width: size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: greyColor1, width: 0.5),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  controller: _cardNumberControler,
                                  // enabled: widget.way == "booking" || widget.way == "driver" ? false : true,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: whiteColor,
                                    suffixIcon: Padding(
                                      padding:
                                      const EdgeInsets.only(right: 8),
                                      child: Image.asset(
                                        'assets/images/visa.png',
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 9.0, top: 10, bottom: 0),
                                    hintText: '0926379402630937223',
                                    labelStyle: body1Black,
                                    hintStyle: TextStyle(color: greyColor),
                                  ),
                                  onChanged: (String value) {},
                                )),
                          ),
                          Container(
                            width: size.width * .8,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                  ),
                                  child: Container(
                                      width: size.width * 0.45,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(4),
                                        border: Border.all(
                                            color: greyColor1, width: 0.5),
                                        color: Colors.white,
                                      ),
                                      child: TextFormField(
                                        controller: _cardDateControler,
                                        keyboardType: TextInputType.datetime,
                                        //   enabled: widget.way == "booking" || widget.way == "driver" ? false : true,
                                        cursorColor: Colors.black,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: whiteColor,
                                          contentPadding: EdgeInsets.only(
                                              left: 9.0, top: 0, bottom: 0),
                                          hintText: 'DD/MM/YYYY',
                                          labelStyle: body1Black,
                                          hintStyle:
                                          TextStyle(color: greyColor),
                                        ),
                                        onChanged: (String value) {},
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                  ),
                                  child: Container(
                                      width: size.width * 0.32,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(4),
                                        border: Border.all(
                                            color: greyColor1, width: 0.5),
                                        color: Colors.white,
                                      ),
                                      child: TextFormField(
                                        controller: _cardCVCControler,
                                        keyboardType: TextInputType.number,
                                        //     enabled: widget.way == "booking" || widget.way == "driver" ? false : true,
                                        cursorColor: Colors.black,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: whiteColor,
                                          contentPadding: EdgeInsets.only(
                                              left: 9.0, top: 0, bottom: 0),
                                          hintText: 'CVV',
                                          labelStyle: body1Black,
                                          hintStyle:
                                          TextStyle(color: greyColor),
                                        ),
                                        onChanged: (String value) {},
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * .03,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    : Container(),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  width: size.width * .9,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: primaryColor,
                              value: PaymentType.ConDelivery,
                              groupValue: _site,
                              onChanged: (PaymentType? value) {
                                setState(() {
                                  _site = value!;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: Text('Cash', style: body3Black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .01,

                ),
                Container(
                  width: size.width * .9,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:  10,
                      ),
                      Container(
                        width: size.width * .9,

                        child: Text(
                          ' Date & Time',
                          style: TextStyle(
                              fontSize:18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height:  8,
                      ),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();

                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => Container(
                                height: 500,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 400,
                                      child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.dateAndTime,
                                          use24hFormat: true,
                                          minimumDate: DateTime.now().subtract(Duration(days: 1)),
                                          initialDateTime: DateTime.now(),
                                          onDateTimeChanged: (val) {
                                            Duration diff = val.difference(DateTime.now());
                                            //DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

                                            setState(() {
                                              _chosenDateTime = val;
                                              String string1 = DateFormat().add_yMMMd().format(val);
                                              String time3 = DateFormat().add_jm().format(val);

                                              endTime = string1.toString() + ' at ' + time3.toString();

                                            });
                                            prefs.setString('selectedMorningTime', endTime.toString());

                                          }),
                                    ),

                                    // Close the modal
                                    CupertinoButton(
                                      child: const Text('OK'),
                                      onPressed: () {

                                        Navigator.of(context,rootNavigator: true).pop();
                                        //  _zonedScheduleNotification(selectedSeconds, morningH,morningM,'morning');
                                        //}

                                      },
                                    )
                                  ],
                                ),
                              ));
                        },
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.05,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              endTime.toString() == '' ?  'Pick Date & Time'  : endTime.toString(),
                              //time.toString(),
                              //' 07 : 10 ',
                              style: TextStyle(
                                  color: endTime == '' ? Colors.grey.withOpacity(0.5) : Colors.black,
                                  fontSize:  18, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:  10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    :

                SizedBox(
                  height: size.height * 0.06,
                  width: size.width * 0.9,
                  child: ElevatedButton(
                      onPressed: () async {
                        getRenter();
                        print(_site.toString());
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingnIn()));

                        if (endTime.toString() == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Choose Date & Time. Sunday is off. Choose time between 10:00AM to 11:00PM.')));
                        } else if (_chosenDateTime!.isBefore(DateTime.now())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Sorry Date is in past')));
                        } else {

                          if (_site.toString() ==
                              'PaymentType.Credit_Debit') {
                            if (_cardUserControler.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Enter Card User Name')));
                            } else if (_cardNumberControler.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Enter Card Number')));
                            } else if (_cardDateControler.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Enter Card Date')));

                            } else if (_cardCVCControler.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Enter Card CVV')));

                            }


                            else {



                              setState(() {
                                _isLoading = true;
                              });
                              print('we are in BookingVehicle');
                              FirebaseFirestore.instance
                                  .collection('BookedServices')
                                  .doc()
                                  .set({
                                "ServiceName": widget.serviceName.toString(),
                                "ServicePrice": widget.servicePrice.toString(),
                                "ServiceDescription": widget.serviceDescription.toString(),
                                "mechanicName": widget.mechanicName.toString(),
                                "mechanicPhone": widget.mechanicPhone.toString(),
                                "mechanicId": widget.mechanicId.toString(),
                                "garageName": widget.garageName.toString(),
                                "address": widget.address.toString(),
                                "bookingStatus": "Pending",
                                "bookingTime": DateTime.now().toString(),
                                "appointmentTime": endTime.toString(),
                                "userEmail": renterEmail,
                                "userName": renterName,
                                "userId": _auth.currentUser!.uid.toString(),
                                "paymentMethod": _site.toString() ==
                                    'PaymentType.Credit_Debit'
                                    ? 'Credit/Debit Card'
                                    : 'Cash',
                                "paymentPaid": _site.toString() ==
                                    'PaymentType.Credit_Debit'
                                    ? 'yes'
                                    : 'no',
                                "cardHolderName": _cardUserControler.text,
                                "cardDate": _cardDateControler.text,
                                "cardCVC": _cardCVCControler.text,
                                "cardHolderCardNumber": _cardNumberControler.text,
                              }).then((value) {
                                setState(() {
                                  _isLoading = false;
                                });
                                // Navigator.pop(context)

                                Navigator.of(context).pop();
                                // Navigator.pushReplacement(
                                //   context,
                                //   PageRouteBuilder(
                                //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 1, title: "", subTitle:""),
                                //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                //     transitionDuration: Duration(milliseconds: 100),
                                //   ),
                                // );
                                Fluttertoast.showToast(
                                  msg: "Successfully Booked",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 4,
                                );
                              });
                            }
                          }
                          else {


                            setState(() {
                              _isLoading = true;
                            });
                            print('we are in BookingVehicle');
                            FirebaseFirestore.instance
                                .collection('BookedServices')
                                .doc()
                                .set({
                              "ServiceName": widget.serviceName.toString(),
                              "ServicePrice": widget.servicePrice.toString(),
                              "ServiceDescription": widget.serviceDescription.toString(),
                              "mechanicName": widget.mechanicName.toString(),
                              "mechanicPhone": widget.mechanicPhone.toString(),
                              "mechanicId": widget.mechanicId.toString(),
                              "garageName": widget.garageName.toString(),
                              "address": widget.address.toString(),
                              "bookingStatus": "Pending",
                              "bookingTime": DateTime.now().toString(),
                              "appointmentTime": endTime.toString(),
                              "userEmail": renterEmail,
                              "userName": renterName,
                              "userId": _auth.currentUser!.uid.toString(),
                              "paymentMethod": _site.toString() ==
                                  'PaymentType.Credit_Debit'
                                  ? 'Credit/Debit Card'
                                  : 'Cash',
                              "paymentPaid": _site.toString() ==
                                  'PaymentType.Credit_Debit'
                                  ? 'yes'
                                  : 'no',
                              "cardHolderName": _cardUserControler.text,
                              "cardDate": _cardDateControler.text,
                              "cardCVC": _cardCVCControler.text,
                              "cardHolderCardNumber": _cardNumberControler.text,
                            }).then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              // Navigator.pop(context)

                              Navigator.of(context).pop();
                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilder(
                              //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 0, title: "", subTitle:""),
                              //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                              //     transitionDuration: Duration(milliseconds: 100),
                              //   ),
                              // );
                              Fluttertoast.showToast(
                                msg: "Successfully Booked",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 4,
                              );
                            });




                          }

                        }




                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text("Book Service", style: subtitleWhite)),
                ),
              ],
            ),



            SizedBox(
              height: size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
