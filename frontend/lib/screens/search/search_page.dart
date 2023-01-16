import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/components/text_field_container.dart';
import 'package:frontend/screens/components/background.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

var _json;
const key = "7511aa5b119a0923ca0934b36e04ab4b";
var text = "";
var city = "";
var lat;
var long;
double line = 0;

class _SearchPageState extends State<SearchPage> {
  final formKey = GlobalKey<FormState>();
  final cityController = TextEditingController();
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  bool confirmationVisible = false;
  // ignore: non_constant_identifier_names
  void search_city() {
    setState(() {
      city = cityController.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final double width = MediaQuery.of(context).size.width;
    //var lat = globalController.getLatitude().value;
    //var long = globalController.getLongitude().value;

    getData(lat, long);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            leading: const BackButton(color: Colors.white),
            actions: const [
              Menu(),
            ]),
        body: Background(
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Search a location",
                        style: TextStyle(
                          color: Color.fromARGB(255, 58, 106, 146),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        )),
                    const Padding(padding: EdgeInsets.only(bottom: 15.0)),
                    TextFieldContainer(
                        child: TextFormField(
                            controller: cityController,
                            decoration: InputDecoration(
                                hintText: "Search...",
                                hintStyle: const TextStyle(fontSize: 25),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                    onPressed: search_city,
                                    icon: const Icon(Icons.search))))),
                  ],
                ))));
  }

  Future getData(double lat, double long) async {
    var url1 =
        'http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=5&appid=$key';
    final uri1 = Uri.parse(url1);
    final response1 = await http.get(uri1);

    if (response1.statusCode == 200) {
      _json = json.decode(response1.body);
    }

    lat = _json['lat'];
    long = _json['long'];

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
