import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/allergies/allergies_page.dart';
import 'package:frontend/screens/hellopage/hellopage.dart';
import 'package:frontend/screens/hourly/hourly_page.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/widgets/header_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  final key = "7511aa5b119a0923ca0934b36e04ab4b";

  @override
  Widget build(BuildContext context) {
    var lat = globalController.getLatitude().value;
    var long = globalController.getLongitude().value;

    getData(lat, long);

    //final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.white),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text("Home"),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Hourly"),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("Daily"),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text("Favorites"),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text("Other Info"),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                    value: 5,
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 7,
                        ),
                        Text("Logout"),
                        Icon(
                          Icons.logout_rounded,
                          color: Colors.black,
                        ),
                      ],
                    )),
              ],
              onSelected: (item) => SelectedItem(context, item),
            )
          ],
        ),
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

  SelectedItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HelloPage()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HourlyPage()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const DailyPage()));
        break;
      case 3:
        print("merge 3!");
        break;
      case 4:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AllergiesPage()));
        break;
      case 5:
        FirebaseAuth.instance.signOut();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
        break;
    }
  }

  Future getData(double lat, double long) async {
    var url =
        'https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$long&cnt=7&appid=$key&units=metric';

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _json = json.decode(response.body);
    }

    return 1;
  }
}
