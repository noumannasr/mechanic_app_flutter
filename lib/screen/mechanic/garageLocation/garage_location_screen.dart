import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mechanic_app_fyp/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class GarageLocationScreen extends StatefulWidget {
  final double lat;
  final double long;
  const GarageLocationScreen({Key? key,
  required this.long,
    required this.lat
  }) : super(key: key);

  @override
  _GarageLocationScreenState createState() => _GarageLocationScreenState();
}

class _GarageLocationScreenState extends State<GarageLocationScreen> {

  String onTapped = 'cover';

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.4735, 55.9754),
    zoom: 15.4746,
  );
  openMap() async {
    if (await canLaunch(
        'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}')) {
      await launch(
          'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}');
    } else {
      throw 'Could not launch https://api.whatsapp.com/send/?phone=03314257676';

    }
  }

  List<Marker> _marker = [];
   List<Marker> _list =[];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _list.clear();
      onTapped = 'cover';

      _kGooglePlex = CameraPosition(
        target: LatLng(widget.lat, widget.long),
        zoom: 15.4746,
      );

      _list =  [
        Marker(
            markerId: MarkerId('1'),
            position: LatLng(widget.lat, widget.long),
            infoWindow: InfoWindow(
              title: 'My Position',
            )
        ),];

      _marker.addAll(_list);
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: oneColor,
        title: Text(
          'Garage Location',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => DashBoardScreen(index:1)));
              // Scaffold.of(context).openDrawer();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),

      body:    Padding(
        padding: const EdgeInsets.all(0.0),
        child: GestureDetector(
          onTap: () async {
            if (await canLaunch(
                'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}')) {
              await launch(
                  'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}');
            } else {
              throw 'Could not launch https://api.whatsapp.com/send/?phone=03314257676';
            }
          },
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () async {
                if (await canLaunch(
                    'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}')) {
                  await launch(
                      'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}');
                } else {
                  throw 'Could not launch https://api.whatsapp.com/send/?phone=03314257676';
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  markers: Set<Marker>.of(_marker),
                  onTap: (Lat) {
                    openMap();
                  },
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
