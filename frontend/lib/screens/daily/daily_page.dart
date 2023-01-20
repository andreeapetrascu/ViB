import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:frontend/widgets/town.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/backend/globals.dart' as globals;
import 'package:intl/intl.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);
  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  var _json;
  var _json_air;
  var lat;
  var long;
  var day1;
  var day2;
  var day3;
  var day4;
  var day5;
  var day6;
  var day7;

  var temp1;
  var temp2;
  var temp3;
  var temp4;
  var temp5;
  var temp6;
  var temp7;

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

    getData(lat, long);

    //final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
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
                  "$day1                 ${temp1.toInt()}°",
                  "$day2                 ${temp2.toInt()}°",
                  "$day3                 ${temp3.toInt()}°",
                  "$day4                 ${temp4.toInt()}°",
                  "$day5                 ${temp5.toInt()}°",
                  "$day6                 ${temp6.toInt()}°",
                  "$day7                 ${temp7.toInt()}°"
                ];
                String getNewLineString() {
                  StringBuffer sb = StringBuffer();
                  for (String line in readContent) {
                    sb.write("$line\n");
                  }
                  return sb.toString();
                }

                return SafeArea(
                    child: Obx(() => globalController.checkLoading().isTrue
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView(scrollDirection: Axis.vertical, children: [
                            SizedBox(height: height * 0.07),
                            const TownWidget(),
                            SizedBox(height: height * 0.15),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            day1,
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${temp1.toInt()}°',
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            day2,
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${temp2.toInt()}°',
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            day3,
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${temp3.toInt()}°',
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            day4,
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${temp4.toInt()}°',
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            day5,
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${temp5.toInt()}°',
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            day6,
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${temp6.toInt()}°',
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            day7,
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${temp7.toInt()}°',
                                            style: const TextStyle(
                                                fontSize: 35.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.2),
                            const Text("ViB | °C",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ])));
              }
            }));
  }

  Future getData(double lat, double long) async {
    var url =
        'https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$long&cnt=7&appid=${globals.key}&units=metric';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }
    var aux = _json['list'];
    var aaa = aux[0];
    day1 = aaa['dt'];
    var temp = aaa['temp'];
    temp1 = temp['day'];
    final df = DateFormat('yyyy-MM-dd');
    day1 = df.format(DateTime.fromMillisecondsSinceEpoch(day1 * 1000));
    DateTime dt_bun = DateTime.parse(day1);
    day1 = DateFormat('EEEE').format(dt_bun);

    aaa = aux[1];
    day2 = aaa['dt'];
    temp = aaa['temp'];
    temp2 = temp['day'];
    day2 = df.format(DateTime.fromMillisecondsSinceEpoch(day2 * 1000));
    dt_bun = DateTime.parse(day2);
    day2 = DateFormat('EEEE').format(dt_bun);

    aaa = aux[2];
    day3 = aaa['dt'];
    temp = aaa['temp'];
    temp3 = temp['day'];
    day3 = df.format(DateTime.fromMillisecondsSinceEpoch(day3 * 1000));
    dt_bun = DateTime.parse(day3);
    day3 = DateFormat('EEEE').format(dt_bun);

    aaa = aux[3];
    day4 = aaa['dt'];
    temp = aaa['temp'];
    temp4 = temp['day'];
    day4 = df.format(DateTime.fromMillisecondsSinceEpoch(day4 * 1000));
    dt_bun = DateTime.parse(day4);
    day4 = DateFormat('EEEE').format(dt_bun);

    aaa = aux[4];
    day5 = aaa['dt'];
    temp = aaa['temp'];
    temp5 = temp['day'];
    day5 = df.format(DateTime.fromMillisecondsSinceEpoch(day5 * 1000));
    dt_bun = DateTime.parse(day5);
    day5 = DateFormat('EEEE').format(dt_bun);

    aaa = aux[5];
    day6 = aaa['dt'];
    temp = aaa['temp'];
    temp6 = temp['day'];
    day6 = df.format(DateTime.fromMillisecondsSinceEpoch(day6 * 1000));
    dt_bun = DateTime.parse(day6);
    day6 = DateFormat('EEEE').format(dt_bun);

    aaa = aux[6];
    day7 = aaa['dt'];
    temp = aaa['temp'];
    temp7 = temp['day'];
    day7 = df.format(DateTime.fromMillisecondsSinceEpoch(day7 * 1000));
    dt_bun = DateTime.parse(day7);
    day7 = DateFormat('EEEE').format(dt_bun);
    return 1;
  }
}
