import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/screen/detail/service_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewUserServicesScreen extends StatefulWidget {
  final String mechanicName;
  final String mechanicId;
  const ViewUserServicesScreen({Key? key
  ,
    required this.mechanicName,
    required this.mechanicId,
  }) : super(key: key);

  @override
  _ViewUserServicesScreenState createState() => _ViewUserServicesScreenState();
}

class _ViewUserServicesScreenState extends State<ViewUserServicesScreen> {

  String name = '' , email = '',uid = '',userType = '';
  String text = '';
  int current = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      //userType = prefs.getString('userType')!;
      email = prefs.getString('userEmail')!;
      uid = prefs.getString('userId')!;
    });

    FirebaseFirestore.instance.collection('Users').where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
      setState(() {
        name = value.docs[0]['name'];
        email = value.docs[0]['email'];
      });
    });




  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightblueColor,

      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('Services',style: TextStyle(color: Colors.white,fontSize: 14),),
      ),

      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Services").where('mechanicId',isEqualTo: widget.mechanicId.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: primaryColor,
                ));
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            // got data from snapshot but it is empty

            return Center(child: Text("No Data Found"));
          } else {
            return Center(
              child: Container(
                width: size.width * 0.95,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => ServiceDetailScreen(
                              mechanicId: widget.mechanicId,
                              mechanicName: widget.mechanicName,
                              userEmail: email,
                              userName: name,
                              serviceName: snapshot.data!.docs[index]["serviceName"].toString(),
                              serviceDescription: snapshot.data!.docs[index]["serviceDescription"].toString(),
                              servicePrice: snapshot.data!.docs[index]["servicePrice"].toString(),
                              garageName: snapshot.data!.docs[index]["garageName"].toString(),
                              address: snapshot.data!.docs[index]["address"].toString(),
                                status: '', payment: '',

                            ),
                            transitionsBuilder: (c, anim, a2, child) =>
                                FadeTransition(opacity: anim, child: child),
                            transitionDuration: Duration(milliseconds: 100),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 0, left: 0, right: 0),
                        child: Container(
                          width: size.width * 0.95,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1,color: primaryColor1),
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                  // color: redColor,
                                  width: size.width*0.3,
                                  height: size.height*0.15,
                                  child:  ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.asset("assets/images/logo.png"),
                                    ),
                                  ),
                                ),

                                Container(
                                  //  color: redColor,
                                  // width: size.width * 0.73,

                                  child: Column(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              //  color: Colors.orange,
                                              width: size.width * 0.48,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // color: Colors.yellow,
                                                    alignment: Alignment.topLeft,
                                                    child:  Text(
                                                      "Service Id #${index+1}" ,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                  Container(
                                                    // color: Colors.yellow,
                                                    alignment: Alignment.topLeft,
                                                    child:  Text(
                                                      snapshot
                                                          .data!
                                                          .docs[index]
                                                      ["serviceName"]
                                                          .toString() ,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          height: 1.3),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: size.width*0.55,
                                                    // color: Colors.yellow,
                                                    alignment: Alignment.topLeft,
                                                    child:  Text(
                                                      snapshot
                                                          .data!
                                                          .docs[index]
                                                      ["serviceDescription"]
                                                          .toString() ,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w400,
                                                          height: 1.3),
                                                      maxLines: 2,
                                                    ),
                                                  ),

                                                  Container(
                                                    // color: Colors.yellow,
                                                    alignment: Alignment.topLeft,
                                                    child:  Text(
                                                      "OMR " + snapshot
                                                          .data!
                                                          .docs[index]
                                                      ["servicePrice"]
                                                          .toString() ,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  //Container(child: Text('AdminHome'),),
                ),
              ),
            );
          }
        },
      ),

    );
  }
}
