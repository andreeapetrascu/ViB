import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:frontend/widgets/town.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/backend/globals.dart' as globals;

class AllergiesPage extends StatefulWidget {
  const AllergiesPage({Key? key}) : super(key: key);
  @override
  State<AllergiesPage> createState() => _AllergiesPageState();
}

var _json;
const key = "7511aa5b119a0923ca0934b36e04ab4b";
var text = "";
double line = 0;

class _AllergiesPageState extends State<AllergiesPage> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    var lat = globalController.getLatitude().value;
    var long = globalController.getLongitude().value;
    Color color;
    getData(lat, long);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            title: const TownWidget(),
            leading: const BackButton(color: Colors.white),
            actions: const [
              Menu(),
            ]),
        body: SafeArea(
            child: Obx(() => globalController.checkLoading().isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(scrollDirection: Axis.vertical, children: [
                    const SizedBox(height: 20),
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
                                child: Stack(children: [
                              Positioned(
                                  child: Material(
                                      color: Colors.transparent,
                                      child: Column(children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            "Allergies",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 121, 172, 214),
                                              fontSize: 30.0,
                                            ),
                                          ),
                                        ),
                                        for (int i = 0; i < 4; i++)
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Container(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  height: 180,
                                                  width: width * 0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          const Color.fromARGB(
                                                              141, 75, 76, 138),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                              158,
                                                              111,
                                                              97,
                                                              143),
                                                          blurRadius: 10,
                                                          spreadRadius: 3,
                                                          offset: Offset(2, 2),
                                                        )
                                                      ]),
                                                  child: Column(children: [
                                                    LayoutBuilder(builder:
                                                        (context, constraints) {
                                                      //if (true) line = 0.1;
                                                      if (i == 0) {
                                                        if (true) {
                                                          line = 0.6;
                                                          color = Colors.red;
                                                        }
                                                        return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                  children: const [
                                                                    Icon(
                                                                      size: 35,
                                                                      Icons
                                                                          .nature_people,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          121,
                                                                          172,
                                                                          214),
                                                                    ),
                                                                    Text(
                                                                        "Tree Polen",
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              121,
                                                                              172,
                                                                              214),
                                                                          fontSize:
                                                                              30.0,
                                                                        ))
                                                                  ]),
                                                              Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    left: 0,
                                                                    top: 30,
                                                                    bottom: 30,
                                                                  ),
                                                                  child: Container(
                                                                      height:
                                                                          5.0,
                                                                      width: width *
                                                                          line,
                                                                      color:
                                                                          color)),
                                                              const Text("Low",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            121,
                                                                            172,
                                                                            214),
                                                                    fontSize:
                                                                        30.0,
                                                                  ))
                                                            ]);
                                                      } else if (i == 1) {
                                                        return Row(
                                                            children: const [
                                                              Icon(
                                                                size: 35,
                                                                Icons.grass,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        121,
                                                                        172,
                                                                        214),
                                                              ),
                                                              Text("Ragweed",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            121,
                                                                            172,
                                                                            214),
                                                                    fontSize:
                                                                        30.0,
                                                                  ))
                                                            ]);
                                                      } else if (i == 2) {
                                                        return Row(
                                                            children: const [
                                                              Icon(
                                                                size: 35,
                                                                Icons.air,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        121,
                                                                        172,
                                                                        214),
                                                              ),
                                                              Text(
                                                                  "Dust & Dander",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            121,
                                                                            172,
                                                                            214),
                                                                    fontSize:
                                                                        30.0,
                                                                  ))
                                                            ]);
                                                      } else if (i == 3) {
                                                        return Row(
                                                            children: const [
                                                              Icon(
                                                                size: 35,
                                                                Icons
                                                                    .bug_report,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        121,
                                                                        172,
                                                                        214),
                                                              ),
                                                              Text(
                                                                  "Mosquito Activity",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            121,
                                                                            172,
                                                                            214),
                                                                    fontSize:
                                                                        30.0,
                                                                  ))
                                                            ]);
                                                      }
                                                      return const Text("Error",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    121,
                                                                    172,
                                                                    214),
                                                            fontSize: 30.0,
                                                          ));
                                                    })
                                                  ]))),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          alignment: Alignment.centerLeft,
                                          child: const Text(
                                            "Outdoor Activities",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 121, 172, 214),
                                              fontSize: 30.0,
                                            ),
                                          ),
                                        ),
                                        for (int i = 0; i < 4; i++)
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              height: 180,
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                    141, 75, 76, 138),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                        158, 111, 97, 143),
                                                    blurRadius: 10,
                                                    spreadRadius: 3,
                                                    offset: Offset(2, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Column(children: [
                                                LayoutBuilder(builder:
                                                    (context, constraints) {
                                                  if (i == 0) {
                                                    return Row(children: const [
                                                      Icon(
                                                        size: 35,
                                                        Icons.directions_run,
                                                        color: Color.fromARGB(
                                                            255, 121, 172, 214),
                                                      ),
                                                      Text("Running",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    121,
                                                                    172,
                                                                    214),
                                                            fontSize: 30.0,
                                                          ))
                                                    ]);
                                                  } else if (i == 1) {
                                                    return Row(children: const [
                                                      Icon(
                                                        size: 35,
                                                        Icons.directions_bike,
                                                        color: Color.fromARGB(
                                                            255, 121, 172, 214),
                                                      ),
                                                      Text("Biking & Cycling",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    121,
                                                                    172,
                                                                    214),
                                                            fontSize: 30.0,
                                                          ))
                                                    ]);
                                                  } else if (i == 2) {
                                                    return Row(children: const [
                                                      Icon(
                                                        size: 35,
                                                        Icons.pool,
                                                        color: Color.fromARGB(
                                                            255, 121, 172, 214),
                                                      ),
                                                      Text("Beach & Pool",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    121,
                                                                    172,
                                                                    214),
                                                            fontSize: 30.0,
                                                          ))
                                                    ]);
                                                  } else if (i == 3) {
                                                    return Row(children: const [
                                                      Icon(
                                                        size: 35,
                                                        Icons.downhill_skiing,
                                                        color: Color.fromARGB(
                                                            255, 121, 172, 214),
                                                      ),
                                                      Text("Ski Weather",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    121,
                                                                    172,
                                                                    214),
                                                            fontSize: 30.0,
                                                          ))
                                                    ]);
                                                  }
                                                  return const Text("");
                                                })
                                              ]),
                                            ),
                                          ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10, top: 10),
                                            alignment: Alignment.center,
                                            child: const Text("ViB | °C",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 121, 172, 214),
                                                  fontSize: 25.0,
                                                )))
                                      ])))
                            ]));
                          }
                        })
                  ]))));
  }

  Future getData(double lat, double long) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$key&units=metric';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }

    return 1;
  }
}
