import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/components/text_field_container.dart';
import 'package:frontend/screens/components/background.dart';
import 'package:frontend/screens/components/menu.dart';
import 'package:frontend/screens/hellopage/hellopage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/backend/globals.dart' as globals;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

var _json;
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
  void search_city() async {
    city = cityController.text.trim();
    var url1 =
        'http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=5&appid=${globals.key}';
    final uri1 = Uri.parse(url1);
    final response1 = await http.get(uri1);

    if (response1.statusCode == 200) {
      _json = json.decode(response1.body);
    }

    var aux = _json[0];

    lat = aux['lat'];
    long = aux['lon'];
    print(lat);
    print(long);

    globals.lat = lat;
    globals.long = long;
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HelloPage()));
    setState(() {
      city = cityController.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (globals.lat == 0.0 || globals.long == 0.0) {
      lat = globalController.getLatitude().value;
      long = globalController.getLongitude().value;
    } else {
      lat = globals.lat;
      long = globals.long;
    }

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
                    FutureBuilder(
                      future: getData(lat, long),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    TextFieldContainer(
                        child: TextFormField(
                            controller: cityController,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 67, 147, 223)),
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
    var url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${globals.lat}&lon=${globals.long}&appid=${globals.key}&units=metric';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }

    return 1;
  }
}
