import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:frontend/backend/globals.dart' as globals;

class TownWidget extends StatefulWidget {
  const TownWidget({Key? key}) : super(key: key);

  @override
  State<TownWidget> createState() => _TownWidgetState();
}

class _TownWidgetState extends State<TownWidget> {
  var lat;
  var long;
  String city = "";
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          size: 35,
          Icons.location_city,
          color: Colors.white,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Text(city,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
