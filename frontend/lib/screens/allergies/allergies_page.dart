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
var ragweed;
var tree;
var run;
var cycling;
var dust;
var mosq;
var pool;
var ski;

class _AllergiesPageState extends State<AllergiesPage> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    var lat;
    var long;
    final double height = MediaQuery.of(context).size.height;
    if (globals.lat == 0.0 || globals.long == 0.0) {
      lat = globalController.getLatitude().value;
      long = globalController.getLongitude().value;
    } else {
      lat = globals.lat;
      long = globals.long;
    }
    final double width = MediaQuery.of(context).size.width;

    Color color = Colors.transparent;
    //getData(lat, long);

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
                        //future: getData(lat, long),
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
                                      margin: const EdgeInsets.only(left: 20),
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
                                                    )
                                                  ]),
                                              child: Column(children: [
                                                LayoutBuilder(builder:
                                                    (context, constraints) {
                                                  if (i == 0) {
                                                    if (tree == "Low") {
                                                      line = 0.12;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 16, 95, 22);
                                                    } else if (tree == "Good") {
                                                      line = 0.24;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 37, 235, 63);
                                                    } else if (tree ==
                                                        "Moderate") {
                                                      line = 0.36;
                                                      color =
                                                          const Color.fromARGB(
                                                              255,
                                                              225,
                                                              236,
                                                              78);
                                                    } else if (tree == "High") {
                                                      line = 0.48;
                                                      color =
                                                          const Color.fromARGB(
                                                              255,
                                                              236,
                                                              158,
                                                              42);
                                                    } else if (tree ==
                                                        "Unhealthy") {
                                                      line = 0.60;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 224, 52, 40);
                                                    } else if (tree ==
                                                        "Hazardous") {
                                                      line = 0.72;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 134, 12, 3);
                                                    }
                                                    return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(children: const [
                                                            Icon(
                                                              size: 35,
                                                              Icons
                                                                  .nature_people,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      121,
                                                                      172,
                                                                      214),
                                                            ),
                                                            Text("Tree Polen",
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
                                                                  height: 5.0,
                                                                  width: width *
                                                                      line,
                                                                  color:
                                                                      color)),
                                                          Text(tree,
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        121,
                                                                        172,
                                                                        214),
                                                                fontSize: 30.0,
                                                              ))
                                                        ]);
                                                  } else if (i == 1) {
                                                    if (ragweed == "Low") {
                                                      line = 0.12;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 16, 95, 22);
                                                    } else if (ragweed ==
                                                        "Good") {
                                                      line = 0.24;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 37, 235, 63);
                                                    } else if (ragweed ==
                                                        "Moderate") {
                                                      line = 0.36;
                                                      color =
                                                          const Color.fromARGB(
                                                              255,
                                                              225,
                                                              236,
                                                              78);
                                                    } else if (ragweed ==
                                                        "High") {
                                                      line = 0.48;
                                                      color =
                                                          const Color.fromARGB(
                                                              255,
                                                              236,
                                                              158,
                                                              42);
                                                    } else if (ragweed ==
                                                        "Unhealthy") {
                                                      line = 0.60;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 224, 52, 40);
                                                    } else if (ragweed ==
                                                        "Hazardous") {
                                                      line = 0.72;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 134, 12, 3);
                                                    }
                                                    return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(children: const [
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
                                                                  height: 5.0,
                                                                  width: width *
                                                                      line,
                                                                  color:
                                                                      color)),
                                                          Text(ragweed,
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        121,
                                                                        172,
                                                                        214),
                                                                fontSize: 30.0,
                                                              ))
                                                        ]);
                                                  } else if (i == 2) {
                                                    if (dust == "Low") {
                                                      line = 0.15;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 16, 95, 22);
                                                    } else if (dust ==
                                                        "Moderate") {
                                                      line = 0.3;
                                                      color =
                                                          const Color.fromARGB(
                                                              255,
                                                              231,
                                                              235,
                                                              37);
                                                    } else if (dust == "High") {
                                                      line = 0.45;
                                                      color =
                                                          const Color.fromARGB(
                                                              255,
                                                              236,
                                                              136,
                                                              78);
                                                    } else if (dust ==
                                                        "Very High") {
                                                      line = 0.60;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 236, 55, 42);
                                                    } else if (dust ==
                                                        "Extreme") {
                                                      line = 0.75;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 134, 12, 3);
                                                    }
                                                    return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(children: const [
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
                                                                  height: 5.0,
                                                                  width: width *
                                                                      line,
                                                                  color:
                                                                      color)),
                                                          Text(dust,
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        121,
                                                                        172,
                                                                        214),
                                                                fontSize: 30.0,
                                                              ))
                                                        ]);
                                                  } else if (i == 3) {
                                                    if (mosq == "Low") {
                                                      line = 0.15;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 16, 95, 22);
                                                    } else if (mosq ==
                                                        "Moderate") {
                                                      line = 0.3;
                                                      color =
                                                          const Color.fromARGB(
                                                              255,
                                                              231,
                                                              235,
                                                              37);
                                                    } else if (mosq == "High") {
                                                      line = 0.45;
                                                      color =
                                                          const Color.fromARGB(
                                                              255,
                                                              236,
                                                              136,
                                                              78);
                                                    } else if (mosq ==
                                                        "Very High") {
                                                      line = 0.60;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 236, 55, 42);
                                                    } else if (mosq ==
                                                        "Extreme") {
                                                      line = 0.75;
                                                      color =
                                                          const Color.fromARGB(
                                                              255, 134, 12, 3);
                                                    }
                                                    return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(children: const [
                                                            Icon(
                                                              size: 35,
                                                              Icons.bug_report,
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
                                                                  height: 5.0,
                                                                  width: width *
                                                                      line,
                                                                  color:
                                                                      color)),
                                                          Text(mosq,
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        121,
                                                                        172,
                                                                        214),
                                                                fontSize: 30.0,
                                                              ))
                                                        ]);
                                                  }
                                                  return const Text("Error",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 121, 172, 214),
                                                        fontSize: 30.0,
                                                      ));
                                                })
                                              ]))),
                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
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
                                          padding: const EdgeInsets.all(15.0),
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
                                                if (run == "Excellent") {
                                                  line = 0.75;
                                                  color = const Color.fromARGB(
                                                      255, 16, 95, 22);
                                                } else if (run == "Very Good") {
                                                  line = 0.60;
                                                  color = const Color.fromARGB(
                                                      255, 55, 236, 79);
                                                } else if (run == "Good") {
                                                  line = 0.45;
                                                  color = const Color.fromARGB(
                                                      255, 236, 233, 78);
                                                } else if (run == "Fair") {
                                                  line = 0.30;
                                                  color = const Color.fromARGB(
                                                      255, 236, 152, 42);
                                                } else if (run == "Poor") {
                                                  line = 0.15;
                                                  color = const Color.fromARGB(
                                                      255, 224, 38, 25);
                                                }
                                                return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(children: const [
                                                        Icon(
                                                          size: 35,
                                                          Icons.directions_run,
                                                          color: Color.fromARGB(
                                                              255,
                                                              121,
                                                              172,
                                                              214),
                                                        ),
                                                        Text("Running",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      121,
                                                                      172,
                                                                      214),
                                                              fontSize: 30.0,
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
                                                              height: 5.0,
                                                              width:
                                                                  width * line,
                                                              color: color)),
                                                      Text(run,
                                                          style:
                                                              const TextStyle(
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
                                                if (cycling == "Excellent") {
                                                  line = 0.75;
                                                  color = const Color.fromARGB(
                                                      255, 16, 95, 22);
                                                } else if (cycling ==
                                                    "Very Good") {
                                                  line = 0.60;
                                                  color = const Color.fromARGB(
                                                      255, 55, 236, 79);
                                                } else if (cycling == "Good") {
                                                  line = 0.45;
                                                  color = const Color.fromARGB(
                                                      255, 236, 233, 78);
                                                } else if (cycling == "Fair") {
                                                  line = 0.30;
                                                  color = const Color.fromARGB(
                                                      255, 236, 152, 42);
                                                } else if (cycling == "Poor") {
                                                  line = 0.15;
                                                  color = const Color.fromARGB(
                                                      255, 224, 38, 25);
                                                }
                                                return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(children: const [
                                                        Icon(
                                                          size: 35,
                                                          Icons.directions_bike,
                                                          color: Color.fromARGB(
                                                              255,
                                                              121,
                                                              172,
                                                              214),
                                                        ),
                                                        Text("Biking & Cycling",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      121,
                                                                      172,
                                                                      214),
                                                              fontSize: 30.0,
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
                                                              height: 5.0,
                                                              width:
                                                                  width * line,
                                                              color: color)),
                                                      Text(cycling,
                                                          style:
                                                              const TextStyle(
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
                                                if (pool == "Excellent") {
                                                  line = 0.75;
                                                  color = const Color.fromARGB(
                                                      255, 16, 95, 22);
                                                } else if (pool ==
                                                    "Very Good") {
                                                  line = 0.60;
                                                  color = const Color.fromARGB(
                                                      255, 55, 236, 79);
                                                } else if (pool == "Good") {
                                                  line = 0.45;
                                                  color = const Color.fromARGB(
                                                      255, 236, 233, 78);
                                                } else if (pool == "Fair") {
                                                  line = 0.30;
                                                  color = const Color.fromARGB(
                                                      255, 236, 152, 42);
                                                } else if (pool == "Poor") {
                                                  line = 0.15;
                                                  color = const Color.fromARGB(
                                                      255, 224, 38, 25);
                                                }
                                                return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(children: const [
                                                        Icon(
                                                          size: 35,
                                                          Icons.pool,
                                                          color: Color.fromARGB(
                                                              255,
                                                              121,
                                                              172,
                                                              214),
                                                        ),
                                                        Text("Beach & Pool",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      121,
                                                                      172,
                                                                      214),
                                                              fontSize: 30.0,
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
                                                              height: 5.0,
                                                              width:
                                                                  width * line,
                                                              color: color)),
                                                      Text(pool,
                                                          style:
                                                              const TextStyle(
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
                                                if (ski == "Excellent") {
                                                  line = 0.75;
                                                  color = const Color.fromARGB(
                                                      255, 16, 95, 22);
                                                } else if (ski == "Very Good") {
                                                  line = 0.60;
                                                  color = const Color.fromARGB(
                                                      255, 55, 236, 79);
                                                } else if (ski == "Good") {
                                                  line = 0.45;
                                                  color = const Color.fromARGB(
                                                      255, 236, 233, 78);
                                                } else if (ski == "Fair") {
                                                  line = 0.30;
                                                  color = const Color.fromARGB(
                                                      255, 236, 152, 42);
                                                } else if (ski == "Poor") {
                                                  line = 0.15;
                                                  color = const Color.fromARGB(
                                                      255, 224, 38, 25);
                                                }
                                                return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(children: const [
                                                        Icon(
                                                          size: 35,
                                                          Icons.downhill_skiing,
                                                          color: Color.fromARGB(
                                                              255,
                                                              121,
                                                              172,
                                                              214),
                                                        ),
                                                        Text("Ski Weather",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      121,
                                                                      172,
                                                                      214),
                                                              fontSize: 30.0,
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
                                                              height: 5.0,
                                                              width:
                                                                  width * line,
                                                              color: color)),
                                                      Text(ski,
                                                          style:
                                                              const TextStyle(
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
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=${globals.key}&units=metric';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }
    var id = _json["id"];

    var url1 =
        'http://dataservice.accuweather.com/forecasts/v1/daily/1day/$id?apikey=${globals.key1}&details=true&metric=true';
    final uri1 = Uri.parse(url1);
    final response1 = await http.get(uri1);

    if (response1.statusCode == 200) {
      _json = json.decode(response1.body);
    }

    var aux = _json['DailyForecasts'];
    var air = aux[0];
    aux = air['AirAndPollen'];
    air = aux[3];
    ragweed = air['Category'];
    air = aux[4];
    tree = air['Category'];

    var url2 =
        'http://dataservice.accuweather.com/indices/v1/daily/1day/$id?apikey=${globals.key1}&details=true';
    final uri2 = Uri.parse(url2);
    final response2 = await http.get(uri2);

    if (response2.statusCode == 200) {
      _json = json.decode(response2.body);
    }

    aux = _json[2];
    run = aux['Category'];
    aux = _json[5];
    cycling = aux["Category"];
    aux = _json[11];
    pool = aux['Category'];
    aux = _json[16];
    ski = aux['Category'];
    aux = _json[18];
    mosq = aux['Category'];
    aux = _json[19];
    dust = aux['Category'];

    return 1;
  }
}
