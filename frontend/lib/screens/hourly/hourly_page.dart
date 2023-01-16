import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:frontend/widgets/town.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  final key = "7511aa5b119a0923ca0934b36e04ab4b";

  @override
  Widget build(BuildContext context) {
    var lat = globalController.getLatitude().value;
    var long = globalController.getLongitude().value;
    getData(lat, long);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: const BackButton(color: Colors.white),
            actions: const [
              Menu(),
            ]),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/vib-database.appspot.com/o/Cer.jpg?alt=media&token=ef761dec-8e2c-4108-9cd9-8fd2b2e4fe56"),
                    fit: BoxFit.cover)),
            child: SafeArea(
                child: Obx(() => globalController.checkLoading().isTrue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView(scrollDirection: Axis.vertical, children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const TownWidget(),
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
                                        '${'\n'}${'\n'}        ${main.toInt()}°${'\n'}${'\n'}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 60.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Baloo2'),
                                  ),
                                  TextSpan(
                                    text:
                                        '${'\n'}${'\n'}$ora1:00                              ${temp1.toInt()}°${'\n'}$ora2:00                              ${temp2.toInt()}°${'\n'}$ora3:00                              ${temp3.toInt()}°${'\n'}$ora4:00                              ${temp4.toInt()}°${'\n'}$ora5:00                              ${temp5.toInt()}°${'\n'}$ora6:00                              ${temp6.toInt()}°${'\n'}$ora7:00                              ${temp7.toInt()}°${'\n'}$ora8:00                              ${temp8.toInt()}°${'\n'}$ora9:00                              ${temp9.toInt()}°${'\n'}$ora10:00                              ${temp10.toInt()}°${'\n'}$ora11:00                              ${temp11.toInt()}°${'\n'}$ora12:00                              ${temp12.toInt()}°${'\n'}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 29.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Baloo2'),
                                  ),
                                  const TextSpan(
                                    text: '${'\n'}                    ViB | °C',
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
        'https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=$lat&lon=$long&appid=$key&units=metric';
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
