import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:frontend/widgets/header_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/backend/globals.dart' as globals;

class HelloPage extends StatefulWidget {
  const HelloPage({Key? key}) : super(key: key);
  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    getFavorite();
    super.initState();
  }

  @override
  var lat;
  var long;
  var _json;
  var _json_air;
  var desc;
  var main;
  var wind;
  var clouds;
  var aqi;
  var img;
  var city;
  late bool heart = false;

  getFavorite() async {
    await FirebaseFirestore.instance
        .collection('favorites')
        .doc(user.uid)
        .collection('favorites')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (city == doc['city']) {
                  heart = true;
                  return;
                }
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    if (globals.lat == 0.0 || globals.long == 0.0) {
      lat = globalController.getLatitude().value;
      long = globalController.getLongitude().value;
    } else {
      lat = globals.lat;
      long = globals.long;
    }
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            leading: const BackButton(color: Colors.white),
            actions: const [
              Menu(),
            ]),
        body: FutureBuilder(
            future: getData(lat, long),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var readContent = [
                  "Air quality:          $aqi",
                  "Wind:                   ${wind['speed'].toInt()}km/h",
                  "Humidity:            ${main['humidity']}%",
                  "Clouds:                ${clouds['all']}%",
                  "Real feel:             ${main['feels_like'].toInt()}°",
                ];
                String getNewLineString() {
                  StringBuffer sb = StringBuffer();
                  for (String line in readContent) {
                    sb.write("$line\n");
                  }
                  return sb.toString();
                }

                if (clouds['all'] <= 25) {
                  img =
                      "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/clear.jpg?alt=media&token=7aed2273-c7b7-409a-a53d-c26c5ce148a3";
                } else if (clouds['all'] <= 50) {
                  img =
                      "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/clouds50%25.png?alt=media&token=a5ea5c7a-799d-4b43-b0c2-e541ab5230d4";
                } else if (clouds['all'] <= 85) {
                  img =
                      "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/clods85%25.jpg?alt=media&token=dd907469-dfce-4de4-8579-4e60d2442d0a";
                } else if (clouds['all'] > 85) {
                  img =
                      "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/rain.jpg?alt=media&token=018f6aa7-0226-4dda-9fd4-fd6842c52180";
                }
                return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(img),
                    )),
                    child: SafeArea(
                        child: Obx(() => globalController.checkLoading().isTrue
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView(
                                scrollDirection: Axis.vertical,
                                children: [
                                    SizedBox(height: height * 0.05),
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          HeaderWidget(
                                            heart: heart,
                                          ),
                                        ]),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    Text("${main['temp'].toInt()}°",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 60.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: height * 0.16,
                                    ),
                                    Center(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                          Text(
                                            getNewLineString(),
                                            maxLines: 5,
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: height * 0.17,
                                          ),
                                          const Text("ViB | °C",
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ]))
                                  ]))));
              }
            }));
  }

  Future getData(double lat, double long) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=${globals.key}&units=metric';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }
    desc = _json['weather'];
    main = _json['main'];
    wind = _json['wind'];
    clouds = _json['clouds'];
    city = _json['name'];
    getFavorite();

    var url_air =
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$long&appid=${globals.key}';
    final uri_air = Uri.parse(url_air);
    final response_air = await http.get(uri_air);

    if (response_air.statusCode == 200) {
      _json_air = json.decode(response_air.body);
    }
    var aaa = _json_air['list'];
    var ccc = aaa[0];
    var bbb = ccc['main'];

    switch (bbb['aqi']) {
      case 1:
        aqi = "Good";
        break;
      case 2:
        aqi = "Fair";
        break;
      case 3:
        aqi = "Moderate";
        break;
      case 4:
        aqi = "Poor";
        break;
      case 5:
        aqi = "Very Poor";
        break;
    }
    return 1;
  }
}
