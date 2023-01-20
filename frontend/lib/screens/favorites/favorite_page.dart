import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/backend/globals.dart' as globals;
import 'package:intl/intl.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Future<List> getDatas(String town) async {
    var lat;
    var long;
    var url1 =
        'http://api.openweathermap.org/geo/1.0/direct?q=$town&limit=5&appid=${globals.key}';
    final uri1 = Uri.parse(url1);
    final response1 = await http.get(uri1);

    if (response1.statusCode == 200) {
      _json = json.decode(response1.body);
    }
    var aux = _json[0];

    lat = aux['lat'];
    long = aux['lon'];

    var url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=${globals.key}&units=metric';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }

    var main = _json['main'];
    var dt = _json['dt'];
    final df = DateFormat('HH:mm');
    var ora = df.format(DateTime.fromMillisecondsSinceEpoch(dt * 1000));
    main = main['temp'].toInt().toString();
    temp = main;
    return [ora, main];
  }

  var _json;
  var ora;
  var temp;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
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
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Favorites",
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 151, 141, 241),
                                    )),
                                Icon(
                                  Icons.favorite,
                                  color: Color.fromARGB(255, 151, 141, 241),
                                  size: 50,
                                )
                              ]),
                          SizedBox(
                            height: height * 0.1,
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('favorites')
                                  .doc(user.uid)
                                  .collection('favorites')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    height: height * 0.9,
                                    child: ListView(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: snapshot.data!.docs.map((snap) {
                                        print(snap['city']);
                                        getDatas(snap['city']).then(
                                          (value) {
                                            ora = value[0];
                                            temp = value[1];
                                            print(temp);
                                          },
                                        );
                                        return FutureBuilder(
                                            future: getDatas(snap['city']),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else {
                                                return Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(snap['city'],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        151,
                                                                        141,
                                                                        241),
                                                              ))
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text("$ora",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        151,
                                                                        141,
                                                                        241),
                                                              ))
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(" $temp°",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        151,
                                                                        141,
                                                                        241),
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.03,
                                                  ),
                                                ]);
                                              }
                                            });
                                      }).toList(),
                                    ),
                                  );
                                }
                              }),
                          const Text("ViB | °C",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ]))
                  ]))));
  }
}
