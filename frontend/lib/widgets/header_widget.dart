import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());
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
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 50, right: 20),
            ),
            const Icon(
              size: 35,
              Icons.location_city,
              color: Colors.black,
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
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topCenter,
          child: Text(
            date,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
