import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:frontend/backend/globals.dart' as globals;

class HeaderWidget extends StatefulWidget {
  bool heart;

  HeaderWidget({
    Key? key,
    required this.heart,
  }) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  var lat;
  var long;
  String town = "";
  var c;

  String date = DateFormat("yMMMMd").format(DateTime.now());
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    if (globals.lat == 0.0 || globals.long == 0.0) {
      lat = globalController.getLatitude().value;
      long = globalController.getLongitude().value;
    } else {
      lat = globals.lat;
      long = globals.long;
    }

    getAddress(lat, long);

    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      town = place.locality!;
    });
    c = town;
  }

  Future addToFavorites() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    widget.heart = !widget.heart;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('favorites');
    return collectionRef.doc(uid).collection('favorites').doc(town).set({
      'city': town,
    }).then((value) => print(town));
  }

  Future deleteFavorites() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    FirebaseFirestore.instance
        .collection('favorites')
        .doc(user!.uid)
        .collection('favorites')
        .doc(town)
        .delete()
        .then(
          (doc) => print('deleted doc'),
          onError: (e) => print("Error updating document $e"),
        );
    widget.heart = !widget.heart;
  }

  void _toggle() {
    setState(() {
      if (widget.heart) {
        deleteFavorites();
      } else {
        addToFavorites();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool h = widget.heart;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(children: <Widget>[
            Row(
              children: [
                const Icon(
                  size: 35,
                  Icons.location_city,
                  color: Colors.white,
                ),
                Text(town,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ],
            ),
            Container(
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
          IconButton(
            onPressed: _toggle,
            icon: h
                ? const Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 151, 141, 241),
                    size: 50,
                  )
                : const Icon(
                    Icons.favorite_border_outlined,
                    color: Color.fromARGB(255, 151, 141, 241),
                    size: 50,
                  ),
          ),
        ]));
  }
}
