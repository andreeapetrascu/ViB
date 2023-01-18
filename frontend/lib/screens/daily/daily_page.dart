import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:frontend/widgets/header_widget.dart';
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
  var dt;

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

    //final user = FirebaseAuth.instance.currentUser!;
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
                                return const Center(
                                    child:
                                        Text.rich(TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '${'\n'}${'\n'}      ${'\n'}${'\n'}${'\n'}${'\n'}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 80.0,
                                          fontFamily: 'Baloo2')),
                                  TextSpan(
                                    text: '${'\n'}${'\n'}${'\n'}${'\n'}°',
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
                                  )
                                ])));
                              }
                            })
                      ])))));
  }

  Future getData(double lat, double long) async {
    var url =
        'https://api.openweathermap.org/data/2.5/forecast/daily?lat=${globals.lat}&lon=${globals.long}&cnt=7&appid=${globals.key}&units=metric';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }
    var aux = _json['list'];
    var aaa = aux[0];
    dt = aaa['dt'];
    final df = new DateFormat('dd-MM-yyyy hh:mm a');
    print(dt);
    print(df.format(new DateTime.fromMillisecondsSinceEpoch(dt * 1000)));

    return 1;
  }
}
