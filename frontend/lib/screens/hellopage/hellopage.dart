import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:frontend/widgets/header_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HelloPage extends StatefulWidget {
  const HelloPage({Key? key}) : super(key: key);
  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  final Map<String, AssetImage> images = {
    "clear": AssetImage(
        "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/clear.jpg?alt=media&token=7aed2273-c7b7-409a-a53d-c26c5ce148a3"),
    "cloudy": AssetImage(
        "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/clouds.jpg?alt=media&token=8bb38610-8dc5-4a56-827b-c514222b3ff8"),
    "rain": AssetImage(
        "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/rain.jpg?alt=media&token=018f6aa7-0226-4dda-9fd4-fd6842c52180")
  };

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  var _json;
  var _json_air;
  var desc;
  var main;
  var wind;
  var clouds;
  var aqi;
  final key = "7511aa5b119a0923ca0934b36e04ab4b";

  @override
  Widget build(BuildContext context) {
    var lat = globalController.getLatitude().value;
    var long = globalController.getLongitude().value;

    getData(lat, long);

    //final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: const BackButton(color: Colors.white),
            actions: const [
              Menu(),
            ]),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image:
                  //if(){} - if in care verificam cum e vremea ca sa afisam poza de fundal buna
                  NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/clear.jpg?alt=media&token=7aed2273-c7b7-409a-a53d-c26c5ce148a3"),
            )),
            child: SafeArea(
                child: Obx(() => globalController.checkLoading().isTrue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(scrollDirection: Axis.vertical, children: [
                        const SizedBox(height: 20),
                        const HeaderWidget(),
                        FutureBuilder(
                            future: getData(lat, long),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Center(
                                    child:
                                        Text.rich(TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '${'\n'}${'\n'}       ${main['temp'].toInt()}°${'\n'}${'\n'}${'\n'}${'\n'}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 80.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Baloo2')),
                                  TextSpan(
                                    text:
                                        '${'\n'}${'\n'}${'\n'}${'\n'}Air quality:              ${aqi}${'\n'}Wind:                       ${wind['speed'].toInt()}km/h${'\n'}Humidity:                ${main['humidity']}%${'\n'}Clouds:                    ${clouds['all']}%${'\n'}Real feel:                 ${main['feels_like'].toInt()}°',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Baloo2'),
                                  ),
                                  const TextSpan(
                                    text:
                                        '${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}                     ViB | °C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Baloo2'),
                                  )
                                ])));
                              }
                            })
                      ])))));
  }

  Future getData(double lat, double long) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$key&units=metric';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }
    desc = _json['weather'];
    main = _json['main'];
    wind = _json['wind'];
    clouds = _json['clouds'];

    var url_air =
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$long&appid=$key';
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
