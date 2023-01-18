import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:frontend/backend/globals.dart' as globals;

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  var lat;
  var long;
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

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
      city = place.locality!;
    });
  }

  bool heart = false;

  void _toggle() {
    setState(() {
      heart = !heart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 50, right: 20),
            ),
            const Icon(
              size: 35,
              Icons.location_city,
              color: Colors.white,
            ),
            Text(city,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 70),
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
        icon: heart
            ? const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 106, 1, 155),
                size: 50,
              )
            : const Icon(
                Icons.favorite_border_outlined,
                color: Color.fromARGB(255, 106, 1, 155),
                size: 50,
              ),
      ),
    ]);
  }
}
