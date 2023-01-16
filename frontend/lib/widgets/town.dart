import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class TownWidget extends StatefulWidget {
  const TownWidget({Key? key}) : super(key: key);

  @override
  State<TownWidget> createState() => _TownWidgetState();
}

class _TownWidgetState extends State<TownWidget> {
  String city = "";
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
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
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Text(city,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );
  }
}
