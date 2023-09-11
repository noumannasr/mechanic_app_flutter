import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';

import '../../detail/service_detail_screen.dart';

class ServiceRequestScreen extends StatefulWidget {
  const ServiceRequestScreen({Key? key}) : super(key: key);

  @override
  _ServiceRequestScreenState createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // backgroundColor: primaryColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: buttonColor,

            bottom: TabBar(
              indicatorColor: primaryColor,
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(text: 'New',),
                Tab(text: 'Confirmed',),
                Tab(text: 'Cancelled',),
              ],
            ),
            centerTitle: true,
            title: Text('Service Requests'),
          ),
          body: TabBarView(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("BookedServices").where("mechanicId", isEqualTo: _auth.currentUser!.uid ).where("bookingStatus", isEqualTo: "Pending" ).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: primaryColor,
                    ));
                  }
                  else if(snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  }
                  else {
                    return Container(
                      width: size.width*0.95,

                      child:   ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return   Padding(
                              padding: const EdgeInsets.only(left: 8,right: 8,top: 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) => ServiceDetailScreen(
                                        mechanicPhone: snapshot.data!.docs[index]["mechanicPhone"].toString(),
                                        userEmail: snapshot.data!.docs[index]["userEmail"].toString(),
                                        userName: snapshot.data!.docs[index]["userName"].toString(),
                                        mechanicId: snapshot.data!.docs[index]["mechanicId"].toString(),
                                        mechanicName: snapshot.data!.docs[index]["mechanicName"].toString() ,
                                        serviceName: snapshot.data!.docs[index]["ServiceName"].toString(),
                                        serviceDescription: snapshot.data!.docs[index]["ServiceDescription"].toString(),
                                        servicePrice: snapshot.data!.docs[index]["ServicePrice"].toString(),
                                        garageName: snapshot.data!.docs[index]["garageName"].toString(),
                                        address: snapshot.data!.docs[index]["address"].toString(), status: 'view',
                                        payment: snapshot.data!.docs[index]["paymentMethod"].toString(),

                                      ),
                                      transitionsBuilder: (c, anim, a2, child) =>
                                          FadeTransition(opacity: anim, child: child),
                                      transitionDuration: Duration(milliseconds: 100),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: size.width*0.85,


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: whiteColor,
                                    ),
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
                                          //   color: redColor,
                                          //width: size.width*0.5,

                                          child:  Column(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(

                                                width: size.width*0.55,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,top: 8),
                                                      child: Text(
                                                        "Service Id : #" + "${index+1}"
                                                        , style: TextStyle(
                                                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.55,
                                                //  color: Colors.green,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,),
                                                      child: Text(
                                                        "Service Name : " + snapshot.data!.docs[index]["ServiceName"].toString()
                                                        , style: TextStyle(
                                                          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.55,
                                                child:   Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Garage Name : " + snapshot.data!.docs[index]["garageName"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600, height: 1.3),),
                                                ),
                                              ),


                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.55,
                                                child:   Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(

                                                    "Address : " + snapshot.data!.docs[index]["address"].toString() + " "
                                                    , style: TextStyle(
                                                      color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),

                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:() {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text('Approve Service'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      color: Colors.red,
                                                                    ),
                                                                    width: size.width*0.22,
                                                                    alignment: Alignment.center,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8),
                                                                      child: Text(
                                                                        'No'

                                                                        , style: TextStyle(
                                                                          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () async {
                                                                    FirebaseFirestore.instance.collection("BookedServices").
                                                                    doc(snapshot.data!.docs[index].id.toString()).update({
                                                                      "bookingStatus": "Confirmed"
                                                                    }).whenComplete((){
                                                                      Navigator.of(context).pop();
                                                                    });
                                                                  },
                                                                  child:Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      color: Colors.green,
                                                                    ),
                                                                    width: size.width*0.22,
                                                                    alignment: Alignment.center,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8),
                                                                      child: Text(
                                                                        'Yes'

                                                                        , style: TextStyle(
                                                                          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                              content: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  const Text('Are you sure you want to approve this service?'),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.green,
                                                        ),
                                                        width: size.width*0.22,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            'Approve'

                                                            , style: TextStyle(
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text('Reject Service'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: const Text('No'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () async {
                                                                    FirebaseFirestore.instance.collection("BookedServices").
                                                                    doc(snapshot.data!.docs[index].id.toString()).update({
                                                                      "bookingStatus": "Cancelled"
                                                                    }).whenComplete((){
                                                                      Navigator.of(context).pop();
                                                                    });
                                                                  },
                                                                  child: const Text('Yes'),
                                                                ),
                                                              ],
                                                              content: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  const Text('Are you sure you want to reject this service?'),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: redColor,
                                                        ),
                                                        width: size.width*0.22,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            'Cancel'

                                                            , style: TextStyle(
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),


                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.02,
                                              ),
                                            ],),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }


                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("BookedServices").where("mechanicId", isEqualTo: _auth.currentUser!.uid ).where("bookingStatus", isEqualTo: "Confirmed" ).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: primaryColor,
                    ));
                  }
                  else if(snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  }
                  else {
                    return Container(
                      width: size.width*0.95,

                      child:   ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) => ServiceDetailScreen(
                                        mechanicPhone: snapshot.data!.docs[index]["mechanicPhone"].toString(),
                                        userEmail: snapshot.data!.docs[index]["userEmail"].toString(),
                                        userName: snapshot.data!.docs[index]["userName"].toString(),
                                        mechanicId: snapshot.data!.docs[index]["mechanicId"].toString(),
                                        mechanicName: snapshot.data!.docs[index]["mechanicName"].toString() ,
                                        serviceName: snapshot.data!.docs[index]["ServiceName"].toString(),
                                        serviceDescription: snapshot.data!.docs[index]["ServiceDescription"].toString(),
                                        servicePrice: snapshot.data!.docs[index]["ServicePrice"].toString(),
                                        garageName: snapshot.data!.docs[index]["garageName"].toString(),
                                        address: snapshot.data!.docs[index]["address"].toString(), status: 'view',
                                        payment: snapshot.data!.docs[index]["paymentMethod"].toString(),

                                      ),
                                      transitionsBuilder: (c, anim, a2, child) =>
                                          FadeTransition(opacity: anim, child: child),
                                      transitionDuration: Duration(milliseconds: 100),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: size.width*0.85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: whiteColor,
                                    ),
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
                                          //   color: redColor,
                                          //width: size.width*0.5,

                                          child:  Column(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(

                                                width: size.width*0.55,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,top: 8),
                                                      child: Text(
                                                        "Service Id : #" + "${index+1}"
                                                        , style: TextStyle(
                                                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.55,
                                                //  color: Colors.green,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,),
                                                      child: Text(
                                                        "Service Name : " + snapshot.data!.docs[index]["ServiceName"].toString()
                                                        , style: TextStyle(
                                                          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.55,
                                                child:   Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Garage Name : " + snapshot.data!.docs[index]["garageName"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600, height: 1.3),),
                                                ),
                                              ),


                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.55,
                                                child:   Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(

                                                    "Address : " + snapshot.data!.docs[index]["address"].toString() + " "
                                                    , style: TextStyle(
                                                      color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),


                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:() {

                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color:
                                                          Colors.green,
                                                        ),
                                                        width: size.width*0.4,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            snapshot.data!.docs[index]["bookingStatus"].toString()

                                                            , style: TextStyle(
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.02,
                                              ),
                                            ],),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }


                },
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("BookedServices").where("mechanicId", isEqualTo: _auth.currentUser!.uid ).where("bookingStatus", isEqualTo: "Cancelled" ).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: primaryColor,
                    ));
                  }
                  else if(snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  }
                  else {
                    return Container(
                      width: size.width*0.95,

                      child:   ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) => ServiceDetailScreen(
                                        mechanicPhone: snapshot.data!.docs[index]["mechanicPhone"].toString(),
                                        userEmail: snapshot.data!.docs[index]["userEmail"].toString(),
                                        userName: snapshot.data!.docs[index]["userName"].toString(),
                                        mechanicId: snapshot.data!.docs[index]["mechanicId"].toString(),
                                        mechanicName: snapshot.data!.docs[index]["mechanicName"].toString() ,
                                        serviceName: snapshot.data!.docs[index]["ServiceName"].toString(),
                                        serviceDescription: snapshot.data!.docs[index]["ServiceDescription"].toString(),
                                        servicePrice: snapshot.data!.docs[index]["ServicePrice"].toString(),
                                        garageName: snapshot.data!.docs[index]["garageName"].toString(),
                                        address: snapshot.data!.docs[index]["address"].toString(), status: 'view',
                                        payment: snapshot.data!.docs[index]["paymentMethod"].toString(),

                                      ),
                                      transitionsBuilder: (c, anim, a2, child) =>
                                          FadeTransition(opacity: anim, child: child),
                                      transitionDuration: Duration(milliseconds: 100),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: size.width*0.85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: whiteColor,
                                    ),
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
                                          //   color: redColor,
                                          //width: size.width*0.5,

                                          child:  Column(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(

                                                width: size.width*0.55,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,top: 8),
                                                      child: Text(
                                                        "Mechanic Id : #" + "${index+1}"
                                                        , style: TextStyle(
                                                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.55,
                                                //  color: Colors.green,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8,),
                                                      child: Text(
                                                        "Service Name : " + snapshot.data!.docs[index]["ServiceName"].toString()
                                                        , style: TextStyle(
                                                          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                    ),

                                                    // Icon(Icons.favorite, color:greyColor,size: 20,)

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.55,
                                                child:   Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(
                                                    "Garage Name : " + snapshot.data!.docs[index]["garageName"].toString()
                                                    , style: TextStyle(
                                                      color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600, height: 1.3),),
                                                ),
                                              ),


                                              SizedBox(
                                                height: size.height*0.01,
                                              ),
                                              Container(

                                                width: size.width*0.55,
                                                child:   Padding(
                                                  padding: const EdgeInsets.only(left: 8,),
                                                  child: Text(

                                                    "Address : " + snapshot.data!.docs[index]["address"].toString() + " "
                                                    , style: TextStyle(
                                                      color: Colors.green, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                                ),
                                              ),

                                              SizedBox(
                                                height: size.height*0.01,
                                              ),


                                              Container(

                                                width: size.width*0.48,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap:() {

                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color:
                                                          Colors.red ,
                                                        ),
                                                        width: size.width*0.4,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            snapshot.data!.docs[index]["bookingStatus"].toString()

                                                            , style: TextStyle(
                                                              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),),
                                                        ),
                                                      ),
                                                    ),

                                                  ],),
                                              ),

                                              SizedBox(
                                                height: size.height*0.02,
                                              ),
                                            ],),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }


                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
