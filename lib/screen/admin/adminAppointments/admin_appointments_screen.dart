import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mechanic_app_fyp/screen/detail/doctor_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/model/firebase_auth.dart';


class AdminAppointmentScreen extends StatefulWidget {
  const AdminAppointmentScreen({Key? key}) : super(key: key);

  @override
  _AdminAppointmentScreenState createState() => _AdminAppointmentScreenState();
}

class _AdminAppointmentScreenState extends State<AdminAppointmentScreen> {
  String? renterEmail = '', renterName = '', renterUid = '';
  MethodsHandler _methodsHandler = MethodsHandler();
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
            title: Text('Appointments'),
          ),
          body: TabBarView(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Mechanic").where("status", isEqualTo: "Pending" ).snapshots(),
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

                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => DoctorDetailScreen(
                                  //     image: snapshot.data!.docs[index]["doctorImage"].toString(),
                                  //     name: snapshot.data!.docs[index]["doctorName"].toString(),
                                  //     userEmail: snapshot.data!.docs[index]["userEmail"].toString(),
                                  //     userName: snapshot.data!.docs[index]["userName"].toString(),
                                  //     specialization: snapshot.data!.docs[index]["doctorSpec"].toString(),
                                  //     category: snapshot.data!.docs[index]["doctorCategory"].toString(),
                                  //     doctorId: snapshot.data!.docs[index]["doctorId"].toString(),
                                  //     phone: snapshot.data!.docs[index]["doctorPhone"].toString(),
                                  //     email: snapshot.data!.docs[index]["appointmentTime"].toString(),
                                  //     status: "view",
                                  //     payment: snapshot.data!.docs[index]["paymentMethod"].toString() ,
                                  //   )),
                                  // );


                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    width: size.width*0.85,


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
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
                                            child:  CachedNetworkImage(
                                              height: size.height * 0.25,

                                              width: size.width ,
                                              fit: BoxFit.cover,
                                              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNDgyaDCaoDZJx8N9BBE6eXm5uXuObd6FPeg&usqp=CAU",
                                              placeholder: (context, url) => Container(
                                                  height: 50, width: 50,
                                                  child: Center(child: CircularProgressIndicator(color: lightButtonGreyColor,))),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
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
                                                        "Name : " + snapshot.data!.docs[index]["name"].toString()
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
                                                              title: const Text('Approve Mechanic'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(0),
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
                                                                    FirebaseFirestore.instance.collection("Mechanic").
                                                                    doc(snapshot.data!.docs[index].id.toString()).update({
                                                                      "status": "Confirmed"
                                                                    }).whenComplete((){
                                                                      Navigator.of(context).pop();
                                                                    });
                                                                  },
                                                                  child:Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(0),
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
                                                                  const Text('Are you sure you want to approve this Mechanic?'),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(0),
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
                                                              title: const Text('Reject Mechanic'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: const Text('No'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () async {
                                                                    FirebaseFirestore.instance.collection("Mechanic").
                                                                    doc(snapshot.data!.docs[index].id.toString()).update({
                                                                      "status": "Cancelled"
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
                                                                  const Text('Are you sure you want to reject this Mechanic?'),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(0),
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
                stream: FirebaseFirestore.instance.collection("Mechanic").where("status", isEqualTo: "Confirmed" ).snapshots(),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => DoctorDetailScreen(
                                  //     image: snapshot.data!.docs[index]["doctorImage"].toString(),
                                  //     userEmail: snapshot.data!.docs[index]["userEmail"].toString(),
                                  //     userName: snapshot.data!.docs[index]["userName"].toString(),
                                  //     name: snapshot.data!.docs[index]["doctorName"].toString(),
                                  //     specialization: snapshot.data!.docs[index]["doctorSpec"].toString(),
                                  //     category: snapshot.data!.docs[index]["doctorCategory"].toString(),
                                  //     doctorId: snapshot.data!.docs[index]["doctorId"].toString(),
                                  //     phone: snapshot.data!.docs[index]["doctorPhone"].toString(),
                                  //     email: snapshot.data!.docs[index]["appointmentTime"].toString(),
                                  //     status: "view",
                                  //     payment: snapshot.data!.docs[index]["paymentMethod"].toString() ,
                                  //   )),
                                  // );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: size.width*0.85,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
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
                                            child:  CachedNetworkImage(
                                              height: size.height * 0.25,

                                              width: size.width ,
                                              fit: BoxFit.cover,
                                              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNDgyaDCaoDZJx8N9BBE6eXm5uXuObd6FPeg&usqp=CAU",
                                              placeholder: (context, url) => Container(
                                                  height: 50, width: 50,
                                                  child: Center(child: CircularProgressIndicator(color: lightButtonGreyColor,))),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
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
                                                        "Name : " + snapshot.data!.docs[index]["name"].toString()
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
                                                          borderRadius: BorderRadius.circular(0),
                                                          color:
                                                          snapshot.data!.docs[index]["status"].toString() == 'Confirmed' ?
                                                          Colors.green :

                                                          primaryColor,
                                                        ),
                                                        width: size.width*0.4,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            snapshot.data!.docs[index]["status"].toString()

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
                stream: FirebaseFirestore.instance.collection("Mechanic").where("status", isEqualTo: "Cancelled" ).snapshots(),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => DoctorDetailScreen(
                                  //     image: snapshot.data!.docs[index]["doctorImage"].toString(),
                                  //     name: snapshot.data!.docs[index]["doctorName"].toString(),
                                  //     userEmail: snapshot.data!.docs[index]["userEmail"].toString(),
                                  //     userName: snapshot.data!.docs[index]["userName"].toString(),
                                  //     specialization: snapshot.data!.docs[index]["doctorSpec"].toString(),
                                  //     category: snapshot.data!.docs[index]["doctorCategory"].toString(),
                                  //     doctorId: snapshot.data!.docs[index]["doctorId"].toString(),
                                  //     phone: snapshot.data!.docs[index]["doctorPhone"].toString(),
                                  //     email: snapshot.data!.docs[index]["appointmentTime"].toString(),
                                  //     status: "view",
                                  //     payment: snapshot.data!.docs[index]["paymentMethod"].toString() ,
                                  //   )),
                                  // );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: size.width*0.85,


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
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
                                            child:  CachedNetworkImage(
                                              height: size.height * 0.25,

                                              width: size.width ,
                                              fit: BoxFit.cover,
                                              imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNDgyaDCaoDZJx8N9BBE6eXm5uXuObd6FPeg&usqp=CAU",
                                              placeholder: (context, url) => Container(
                                                  height: 50, width: 50,
                                                  child: Center(child: CircularProgressIndicator(color: lightButtonGreyColor,))),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
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
                                                        "Name : " + snapshot.data!.docs[index]["name"].toString()
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
                                                          borderRadius: BorderRadius.circular(0),
                                                          color:
                                                          snapshot.data!.docs[index]["status"].toString() == 'Cancelled' ?
                                                          Colors.red :

                                                          primaryColor,
                                                        ),
                                                        width: size.width*0.4,
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8),
                                                          child: Text(
                                                            snapshot.data!.docs[index]["status"].toString()

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
