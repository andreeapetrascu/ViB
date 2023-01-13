import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/hourly/hourly_page.dart';
import 'package:frontend/screens/login/login_screen.dart';
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
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Home"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Hourly"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 2,
                child: Text("Daily"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 3,
                child: Text("Favorites"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 4,
                child: Text("Other Info"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                  value: 5,
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 7,
                      ),
                      Text("Logout"),
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.black,
                      ),
                    ],
                  )),
            ],
            onSelected: (item) => SelectedItem(context, item),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/Cer.jpg?alt=media&token=ef761dec-8e2c-4108-9cd9-8fd2b2e4fe56"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Obx(
            () => globalController.checkLoading().isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(height: 20),
                      const HeaderWidget(),
                      FutureBuilder(
                        future: getData(lat, long),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Center(
                              child: Text.rich(
                                TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${'\n'}${'\n'}      ${main['temp'].toInt()}°${'\n'}${'\n'}${'\n'}${'\n'}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 80.0,
                                            fontFamily: 'Baloo2')),
                                    TextSpan(
                                      text:
                                          '${'\n'}${'\n'}${'\n'}${'\n'}Air quality:              ${aqi}${'\n'}Wind:                       ${wind['speed'].toInt()}km/h${'\n'}Humidity:                ${main['humidity']}%${'\n'}Clouds:                    ${clouds['all']}%${'\n'}Real feel:                 ${main['feels_like'].toInt()}°',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.0,
                                          fontFamily: 'Baloo2'),
                                    ),
                                    TextSpan(
                                      text:
                                          '${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}${'\n'}                     ViB | °C',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontFamily: 'Baloo2'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          ;
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  SelectedItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HelloPage()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HourlyPage()));
        break;
      case 2:
        print("merge 2!");
        break;
      case 3:
        print("merge 3!");
        break;
      case 4:
        print("merge 4!");
        break;
      case 5:
        FirebaseAuth.instance.signOut();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
        break;
    }
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
