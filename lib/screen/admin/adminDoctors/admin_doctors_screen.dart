import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/screen/admin/adminDoctors/add_doctors_screen.dart';
import 'package:flutter/material.dart';

class AdminDoctorsScreen extends StatefulWidget {
  const AdminDoctorsScreen({Key? key}) : super(key: key);

  @override
  _AdminDoctorsScreenState createState() => _AdminDoctorsScreenState();
}

class _AdminDoctorsScreenState extends State<AdminDoctorsScreen> {
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
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('Doctors'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDoctorScreen(
              status: 'add', name: '', email: '', phone: '', image: '', id: '', uid: '', password: '', category: '', specialization: '',
            )),
          );

        },
        child: Icon(Icons.add, color: Colors.white, size: 29,),
        backgroundColor: primaryColor,
        tooltip: 'Doctors',
        elevation: 5,
        splashColor: Colors.grey,
      ),

      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Doctors").snapshots(),
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
                            border: Border.all(width: 0.5,color: primaryColor),
                            borderRadius: BorderRadius.circular(10),


                            //whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                  decoration: BoxDecoration(

                                     color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: primaryColor)
                                  ),
                                  width: size.width * 0.17,
                                  child: CircleAvatar(
                                    backgroundColor: lightGreyColor,
                                    radius: 25,
                                    backgroundImage: NetworkImage(  snapshot
                                        .data!
                                        .docs[index]
                                    ["image"]
                                        .toString(),
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
                                                    snapshot.data!.docs[index]["specialization"].toString() ,
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
                                          Container(
                                            // color: Colors.greenAccent,
                                            // width: size.width * 0.27,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 10,),
                                                      SizedBox(width: 10,),
                                                      GestureDetector(
                                                          onTap:() {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => AddDoctorScreen(
                                                                status: 'update',
                                                                name: snapshot.data!.docs[index]["name"].toString(),
                                                                email: snapshot.data!.docs[index]["email"].toString(),
                                                                phone: snapshot.data!.docs[index]["phone"].toString(),
                                                                image: snapshot.data!.docs[index]["image"].toString(),
                                                                id: snapshot.data!.docs[index]["id"].toString(),
                                                                uid: snapshot.data!.docs[index]["uid"].toString(),
                                                                password: snapshot.data!.docs[index]["password"].toString(),
                                                                category: snapshot.data!.docs[index]["category"].toString(),
                                                                specialization: snapshot.data!.docs[index]["specialization"].toString(),
                                                              )),
                                                            );
                                                          },
                                                          child: Icon(Icons.edit, size: 25,color: Colors.blue,)),
                                                       // SizedBox(width: 10,),
                                                      // GestureDetector(
                                                      //     onTap:() {
                                                      //
                                                      //       showDialog(
                                                      //         context: context,
                                                      //         builder: (context) {
                                                      //           return AlertDialog(
                                                      //             title:
                                                      //             const Text('Delete'),
                                                      //             actions: [
                                                      //               TextButton(
                                                      //                 onPressed: () {
                                                      //                   Navigator.of(
                                                      //                       context)
                                                      //                       .pop();
                                                      //                 },
                                                      //                 child:
                                                      //                 Container(
                                                      //                     decoration: BoxDecoration(
                                                      //                         color: primaryColor1,
                                                      //                         borderRadius: BorderRadius.circular(10)
                                                      //                     ),
                                                      //                     child: Padding(
                                                      //                       padding: const EdgeInsets.all(16.0),
                                                      //                       child: const Text('Cancel', style: TextStyle(color: whiteColor),),
                                                      //                     )),
                                                      //               ),
                                                      //               TextButton(
                                                      //                 onPressed: () async {
                                                      //                   FirebaseFirestore
                                                      //                       .instance
                                                      //                       .collection(
                                                      //                       "Categories")
                                                      //                       .doc(snapshot
                                                      //                       .data!
                                                      //                       .docs[index]
                                                      //                       .id
                                                      //                       .toString())
                                                      //                       .delete()
                                                      //                       .whenComplete(
                                                      //                           () {
                                                      //                         Navigator.of(
                                                      //                             context)
                                                      //                             .pop();
                                                      //                         ScaffoldMessenger.of(context).showSnackBar(
                                                      //                             const SnackBar(
                                                      //                                 backgroundColor: Colors.red,
                                                      //                                 content:  Text('Successfully Deleted',style: TextStyle(color: whiteColor),)
                                                      //                             )
                                                      //                         );
                                                      //                       });
                                                      //                 },
                                                      //                 child:
                                                      //                 Container(
                                                      //                     decoration: BoxDecoration(
                                                      //                         color: Colors.red,
                                                      //                         borderRadius: BorderRadius.circular(10)
                                                      //                     ),
                                                      //                     child: Padding(
                                                      //                       padding: const EdgeInsets.all(16.0),
                                                      //                       child: const Text('Delete', style: TextStyle(color: whiteColor),),
                                                      //                     )),
                                                      //               ),
                                                      //             ],
                                                      //             content: Column(
                                                      //               crossAxisAlignment:
                                                      //               CrossAxisAlignment
                                                      //                   .start,
                                                      //               mainAxisSize:
                                                      //               MainAxisSize.min,
                                                      //               children: [
                                                      //                 const Text(
                                                      //                     'Are you sure you want to delete?'),
                                                      //               ],
                                                      //             ),
                                                      //           );
                                                      //         },
                                                      //       );
                                                      //
                                                      //     },
                                                      //     child: Icon(Icons.delete, size: 25,color: Colors.red,)),

                                                    ],
                                                  ),
                                                ),
                                              ],
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
