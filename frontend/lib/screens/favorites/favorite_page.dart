import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:frontend/widgets/header_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  var _json;

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
                                      text: '',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 80.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Baloo2')),
                                  TextSpan(
                                    text: '',
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

    return 1;
  }
}
