
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:flutter_mechanic_app_fyp/screen/auth/userType/usertype_screen.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_mechanic_app_fyp/screen/category/category_screen.dart';
// import 'package:flutter_mechanic_app_fyp/screen/detail/doctor_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/screen/userServices/my_services_user_screen.dart';
import 'package:flutter_mechanic_app_fyp/screen/userServices/view_user_services_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> pages = [
    'assets/images/casetoService.jpg',
    'assets/images/casetoService.jpg',
    'assets/images/casetoService.jpg',
  ];

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

  List<Categories> items = [
    Categories(
      image:'assets/images/loneliness.png',
      title:'Anxiety',
      description:'Single burger with beef',
    ),
    Categories(
      image:'assets/images/depression.png',
      title:'Depression',
      description:'Single burger with beef',
    ),
    Categories(
      image:'assets/images/anxiety.png',
      title:'Dementia',
      description:'Single burger with beef',
    ),


  ];




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightblueColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width*0.12,
            ),
            Image.asset('assets/images/logo.png',height: 40,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text(
                    'ORVBA',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  // Text(
                  //   'THERAPY & COUNSELING',
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 10,
                  //       fontWeight: FontWeight.w700),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: lightButtonGreyColor, //Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
                // gradient: LinearGradient(begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   stops: [
                //     0.1,
                //     0.9
                //   ], colors: [
                //     darkRedColor,
                //     lightRedColor,
                //   ],
                // ),
              ),
              margin: EdgeInsets.zero,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset( 'assets/images/logo.png',height: 70,width: 70,fit: BoxFit.scaleDown,),
                    SizedBox(
                      height: 8,
                    ),
                    Text(name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(email,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  //<-- SEE HERE
                  side: BorderSide(width: 1, color: whiteColor),
                  borderRadius: BorderRadius.circular(0),
                ),
                tileColor: whiteColor,
                leading: Container(
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(begin: Alignment.topRight,
                  //     end: Alignment.bottomLeft,
                  //     stops: [
                  //       0.1,
                  //       0.9
                  //     ], colors: [
                  //       lightRedColor,
                  //       darkRedColor
                  //     ],
                  //   ),
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                    width: 30,
                    height: 30,
                    //devSize.height*0.05,
                    child: Image.asset('assets/images/shutdown.png', fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,

                    )

                  // Icon(
                  //   Icons.local_fire_department,
                  //   color: Colors.white,
                  //   size: 20,
                  // )

                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                ),
                title: Text('Logout',),
                onTap: () async {

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  try {
                    return await _auth.signOut().whenComplete(() {
                      prefs.remove('userEmail');
                      prefs.remove('userType');
                      prefs.remove('userPassword');
                      prefs.remove('userId');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserType()));
                    });
                  } catch (e) {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: size.height*0.15,
            ),
          ],
        ),
      ),
      body:   SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
              height: size.height*0.02,
            ),
            CarouselSlider(

                items: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset('assets/images/slider2.jpg',fit: BoxFit.cover,
                        width: size.width*0.9,
                        height: size.height*0.2,
                      )),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset('assets/images/slider1.jpg',fit: BoxFit.cover,
                        width: size.width*0.9,
                        height: size.height*0.2,
                      )),
                  // ClipRRect(
                  //     borderRadius: BorderRadius.circular(0),
                  //     child: Image.asset('assets/images/slider2.png',fit: BoxFit.cover,
                  //       width: size.width*0.9,
                  //       height: size.height*0.2,
                  //     )),
                ],
                options: CarouselOptions(
                  height: size.height*0.2,
                  aspectRatio: 16/9,
                  viewportFraction: 0.99,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                )
            ),
            AnimatedSmoothIndicator(
              activeIndex: current,
              count: 3,//pages.length,
              effect: const JumpingDotEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  jumpScale: .7,
                  verticalOffset: 20,
                  activeDotColor: darkPeachColor,
                  dotColor: Colors.grey),
            ),

            SizedBox(
              height: size.height*0.02,
            ),

            GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyServicesUserScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 0),
                child: Container(
                  //width: size.width * 0.3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: Colors.white),
                    color: Colors.white,
                    gradient:  LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[primaryColor.withOpacity(0.3), primaryColor,],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor
                            .withOpacity(0.4),
                        spreadRadius: 1.2,
                        blurRadius: 0.8,
                        offset: Offset(0,
                            0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Center(
                          child: Container(

                            child: Image.asset('assets/images/box.png',
                              fit: BoxFit.scaleDown,
                              height: 50,
                              width: 50,
                            ),
                          )),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Center(
                        child: Text(
                          'My Services',
                          style: TextStyle(fontSize: 15,color: whiteColor,fontWeight: FontWeight.bold,),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: size.height*0.02,
            ),

            Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Mechanics',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: size.height*0.01,
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
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ViewUserServicesScreen(
                                    mechanicId: snapshot.data!.docs[index]["uid"].toString(),
                                    mechanicName: snapshot.data!.docs[index]["name"].toString(),
                                    mechanicPhone: snapshot.data!.docs[index]["phone"].toString(),
                                  )),
                                );
                              },
                              child: Container(
                                width: size.width*0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: whiteColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Container(
                                      color: Colors.white,
                                      width: size.width*0.3,
                                      height: size.height*0.15,
                                      child:  ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child:  Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: CachedNetworkImage(
                                            height: size.height * 0.25,

                                            width: size.width ,
                                            fit: BoxFit.cover,
                                            imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNDgyaDCaoDZJx8N9BBE6eXm5uXuObd6FPeg&usqp=CAU",
                                            placeholder: (context, url) => Container(
                                                height: 50, width: 50,
                                                child: Center(child: CircularProgressIndicator(color: Colors.white,))),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
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
                                              mainAxisAlignment: MainAxisAlignment.start,
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

                                        ],),
                                    ),
                                  ],
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

    );
  }
}

class Categories {

  final String image;
  final String title;
  final String description;

  Categories({
    required this.image,
    required this.title,
    required this.description,


  });

}