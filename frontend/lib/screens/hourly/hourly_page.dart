import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:frontend/widgets/town.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/backend/globals.dart' as globals;

class HourlyPage extends StatefulWidget {
  const HourlyPage({Key? key}) : super(key: key);
  @override
  State<HourlyPage> createState() => _HourlyPageState();
}

class _HourlyPageState extends State<HourlyPage> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  var _json;
  var main;
  var clouds;
  var img;
  var lat;
  var long;

  var ora1 = "";
  var ora2 = "";
  var ora3 = "";
  var ora4 = "";
  var ora5 = "";
  var ora6 = "";
  var ora7 = "";
  var ora8 = "";
  var ora9 = "";
  var ora10 = "";
  var ora11 = "";
  var ora12 = "";

  var temp1;
  var temp2;
  var temp3;
  var temp4;
  var temp5;
  var temp6;
  var temp7;
  var temp8;
  var temp9;
  var temp10;
  var temp11;
  var temp12;

  @override
  Widget build(BuildContext context) {
    if (globals.lat == 0.0 || globals.long == 0.0) {
      lat = globalController.getLatitude().value;
      long = globalController.getLongitude().value;
    } else {
      lat = globals.lat;
      long = globals.long;
    }
    getData(lat, long);
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
                  "$ora1:00                           ${temp1.toInt()}°",
                  "$ora2:00                           ${temp2.toInt()}°",
                  "$ora3:00                           ${temp3.toInt()}°",
                  "$ora4:00                           ${temp4.toInt()}°",
                  "$ora5:00                           ${temp5.toInt()}°",
                  "$ora6:00                           ${temp6.toInt()}°",
                  "$ora7:00                           ${temp7.toInt()}°",
                  "$ora8:00                           ${temp8.toInt()}°",
                  "$ora9:00                           ${temp9.toInt()}°",
                  "$ora10:00                           ${temp10.toInt()}°",
                  "$ora11:00                           ${temp11.toInt()}°",
                  "$ora12:00                           ${temp12.toInt()}°",
                ];
                String getNewLineString() {
                  StringBuffer sb = StringBuffer();
                  for (String line in readContent) {
                    sb.write("$line\n");
                  }
                  return sb.toString();
                }

                if (clouds <= 25) {
                  img =
                      "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/clear.jpg?alt=media&token=7aed2273-c7b7-409a-a53d-c26c5ce148a3";
                } else if (clouds <= 50) {
                  img =
                      "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/clouds50%25.png?alt=media&token=a5ea5c7a-799d-4b43-b0c2-e541ab5230d4";
                } else if (clouds <= 85) {
                  img =
                      "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/clods85%25.jpg?alt=media&token=dd907469-dfce-4de4-8579-4e60d2442d0a";
                } else if (clouds > 85) {
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
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const TownWidget(),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text("${main.toInt()}°",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 50.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    FutureBuilder(
                                        future: getData(lat, long),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else {
                                            return Center(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                  Text(
                                                    getNewLineString(),
                                                    maxLines: 12,
                                                    style: const TextStyle(
                                                        fontSize: 30.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    height: 50,
                                                  ),
                                                  const Text("ViB | °C",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 25.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                                ]));
                                          }
                                        })
                                  ]))));
              }
            }));
  }

  Future getData(double lat, double long) async {
    var url =
        'https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=$lat&lon=$long&appid=${globals.key}&units=metric';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }

    var aux = _json['list'];
    var aaa = aux[0];
    var bbb = aaa['main'];
    var aux1 = aaa['clouds'];
    clouds = aux1['all'];

    main = bbb['temp'];

    var o = aaa['dt_txt'];
    List h = o.split(" ");
    List oh = h[1].split(":");
    ora1 = oh[0];
    bbb = aaa['main'];
    temp1 = bbb['temp'];

    var next_h = aux[2];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora2 = oh[0];
    bbb = next_h['main'];
    temp2 = bbb['temp'];

    next_h = aux[4];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora3 = oh[0];
    bbb = next_h['main'];
    temp3 = bbb['temp'];

    next_h = aux[6];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora4 = oh[0];
    bbb = next_h['main'];
    temp4 = bbb['temp'];

    next_h = aux[8];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora5 = oh[0];
    bbb = next_h['main'];
    temp5 = bbb['temp'];

    next_h = aux[10];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora6 = oh[0];
    bbb = next_h['main'];
    temp6 = bbb['temp'];

    next_h = aux[12];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora7 = oh[0];
    bbb = next_h['main'];
    temp7 = bbb['temp'];

    next_h = aux[14];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora8 = oh[0];
    bbb = next_h['main'];
    temp8 = bbb['temp'];

    next_h = aux[16];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora9 = oh[0];
    bbb = next_h['main'];
    temp9 = bbb['temp'];

    next_h = aux[18];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora10 = oh[0];
    bbb = next_h['main'];
    temp10 = bbb['temp'];

    next_h = aux[20];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora11 = oh[0];
    bbb = next_h['main'];
    temp11 = bbb['temp'];

    next_h = aux[22];
    o = next_h['dt_txt'];
    h = o.split(" ");
    oh = h[1].split(":");
    ora12 = oh[0];
    bbb = next_h['main'];
    temp12 = bbb['temp'];

    return 1;
  }
}
