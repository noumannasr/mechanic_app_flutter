import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'dart:math' as math;
class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  _AdminUserScreenState createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: buttonColor,
        centerTitle: true,
        title: Text('Users'),
      ),

      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
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
                        // Navigator.push(
                        //   context,
                        //   PageRouteBuilder(
                        //     pageBuilder: (c, a1, a2) => UserDetailScreen(
                        //       docId: snapshot.data!.docs[index].id.toString(),
                        //       userStatus: "Students",
                        //
                        //     ),
                        //     transitionsBuilder: (c, anim, a2, child) =>
                        //         FadeTransition(opacity: anim, child: child),
                        //     transitionDuration: Duration(milliseconds: 100),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 0, right: 0),
                        child: Container(
                          width: size.width * 0.95,

                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: primaryColor1),
                            borderRadius: BorderRadius.circular(0),
                            //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                            gradient:  LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors:

                              <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5), ],
                            ),


                            //whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    // color: Colors.green,
                                  ),
                                  width: size.width * 0.17,
                                  child: CircleAvatar(
                                    backgroundColor: lightGreyColor,
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNDgyaDCaoDZJx8N9BBE6eXm5uXuObd6FPeg&usqp=CAU"
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
                                          Container(
                                            //  color: Colors.orange,
                                            width: size.width * 0.48,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child:  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                    ["name"]
                                                        .toString() ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: secondaryColor1,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w800,
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
                                                    ["email"]
                                                        .toString() ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: secondaryColor1,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        height: 1.3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: 1,
                                            height: 40,
                                            color: Colors.grey.withOpacity(0.3),
                                          ),
                                          SizedBox(width: 5,),
                                          // Container(
                                          //   // color: Colors.greenAccent,
                                          //   // width: size.width * 0.27,
                                          //   child: Column(
                                          //     children: [
                                          //       Container(
                                          //         child: Row(
                                          //           children: [
                                          //
                                          //
                                          //             GestureDetector(
                                          //                 onTap:() {
                                          //                   // Navigator.push(
                                          //                   //     context,
                                          //                   //     MaterialPageRoute(
                                          //                   //         builder: (BuildContext
                                          //                   //         context) =>
                                          //                   //             AddStudentsScreen(
                                          //                   //               studentFirstName:
                                          //                   //               snapshot.data!.docs[index]
                                          //                   //               [
                                          //                   //               "studentFirstName"]
                                          //                   //                   .toString(),
                                          //                   //               studentPhone: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[index][
                                          //                   //               "studentPhone"]
                                          //                   //                   .toString(),
                                          //                   //               studentEmail: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[index][
                                          //                   //               "studentEmail"]
                                          //                   //                   .toString(),
                                          //                   //               studentLastName:
                                          //                   //               snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[
                                          //                   //               index]
                                          //                   //               [
                                          //                   //               "studentLastName"]
                                          //                   //                   .toString(),
                                          //                   //               company: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[index][
                                          //                   //               "company"]
                                          //                   //                   .toString(),
                                          //                   //               paymentOption: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[index][
                                          //                   //               "paymentOption"]
                                          //                   //                   .toString(),
                                          //                   //               paymentNote: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[index][
                                          //                   //               "paymentNote"]
                                          //                   //                   .toString(),
                                          //                   //               sendCopyOfCardNote: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[index][
                                          //                   //               "sendCopyOfCardNote"]
                                          //                   //                   .toString(),
                                          //                   //               docId: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[index]
                                          //                   //                   .id
                                          //                   //                   .toString(),
                                          //                   //               note: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[index]
                                          //                   //               ["note"]
                                          //                   //                   .toString(),
                                          //                   //               companyInSkillPass:
                                          //                   //               snapshot.data!
                                          //                   //                   .docs[
                                          //                   //               index]
                                          //                   //               [
                                          //                   //               "companyInSkillPass"],
                                          //                   //               sendCopyOfCard: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[
                                          //                   //               index][
                                          //                   //               "sendCopyOfCard"],
                                          //                   //               list: classes,
                                          //                   //               selectedClass: snapshot
                                          //                   //                   .data!
                                          //                   //                   .docs[index][
                                          //                   //               "className"]
                                          //                   //                   .toString(), // currentlyAddedStudents
                                          //                   //               status: 'Update', currentStudents:
                                          //                   //             snapshot
                                          //                   //                 .data!
                                          //                   //                 .docs[index][
                                          //                   //             "currentlyAddedStudents"]
                                          //                   //               ,
                                          //                   //             )));
                                          //                 },
                                          //                 child: Icon(Icons.edit, size: 25,color: Colors.blue,)),
                                          //             SizedBox(width: 10,),
                                          //             GestureDetector(
                                          //                 onTap:() {
                                          //
                                          //                   showDialog(
                                          //                     context: context,
                                          //                     builder: (context) {
                                          //                       return AlertDialog(
                                          //                         title:
                                          //                         const Text('Delete'),
                                          //                         actions: [
                                          //                           TextButton(
                                          //                             onPressed: () {
                                          //                               Navigator.of(
                                          //                                   context)
                                          //                                   .pop();
                                          //                             },
                                          //                             child:
                                          //                             Container(
                                          //                                 decoration: BoxDecoration(
                                          //                                     color: primaryColor1,
                                          //                                     borderRadius: BorderRadius.circular(10)
                                          //                                 ),
                                          //                                 child: Padding(
                                          //                                   padding: const EdgeInsets.all(16.0),
                                          //                                   child: const Text('Cancel', style: TextStyle(color: whiteColor),),
                                          //                                 )),
                                          //                           ),
                                          //                           TextButton(
                                          //                             onPressed: () async {
                                          //                               FirebaseFirestore
                                          //                                   .instance
                                          //                                   .collection(
                                          //                                   "Categories")
                                          //                                   .doc(snapshot
                                          //                                   .data!
                                          //                                   .docs[index]
                                          //                                   .id
                                          //                                   .toString())
                                          //                                   .delete()
                                          //                                   .whenComplete(
                                          //                                       () {
                                          //                                     Navigator.of(
                                          //                                         context)
                                          //                                         .pop();
                                          //                                     ScaffoldMessenger.of(context).showSnackBar(
                                          //                                         const SnackBar(
                                          //                                             backgroundColor: Colors.red,
                                          //                                             content:  Text('Successfully Deleted',style: TextStyle(color: whiteColor),)
                                          //                                         )
                                          //                                     );
                                          //                                   });
                                          //                             },
                                          //                             child:
                                          //                             Container(
                                          //                                 decoration: BoxDecoration(
                                          //                                     color: Colors.red,
                                          //                                     borderRadius: BorderRadius.circular(10)
                                          //                                 ),
                                          //                                 child: Padding(
                                          //                                   padding: const EdgeInsets.all(16.0),
                                          //                                   child: const Text('Delete', style: TextStyle(color: whiteColor),),
                                          //                                 )),
                                          //                           ),
                                          //                         ],
                                          //                         content: Column(
                                          //                           crossAxisAlignment:
                                          //                           CrossAxisAlignment
                                          //                               .start,
                                          //                           mainAxisSize:
                                          //                           MainAxisSize.min,
                                          //                           children: [
                                          //                             const Text(
                                          //                                 'Are you sure you want to delete?'),
                                          //                           ],
                                          //                         ),
                                          //                       );
                                          //                     },
                                          //                   );
                                          //
                                          //                 },
                                          //                 child: Icon(Icons.delete, size: 25,color: Colors.red,)),
                                          //
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
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
