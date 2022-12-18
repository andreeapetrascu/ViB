import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/widgets/header_widget.dart';
import 'package:get/get.dart';
import '../home/components/home_screen.dart';
import 'package:geolocator/geolocator.dart';

class HelloPage extends StatefulWidget {
  const HelloPage({Key? key}) : super(key: key);
  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  final GlobalController globalCoontroller =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.white),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Home"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Hourly"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 2,
                child: Text("Daily"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 3,
                child: Text("Favorites"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 4,
                child: Text("Other Info"),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                  value: 5,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 7,
                      ),
                      Text("Logout"),
                      Icon(Icons.logout_rounded),
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
          child: Obx(() => globalCoontroller.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(height: 20),
                    const HeaderWidget(),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50)),
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        icon: Icon(Icons.arrow_back, size: 32),
                        label: Text('sign out', style: TextStyle(fontSize: 24)))
                  ],
                )),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("Hello!"),
          //     SizedBox(height: 40),
        ),
      ),
    );
  }

  SelectedItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HelloPage()));
        break;
      case 1:
        print("merge 1!");
        break;
      case 2:
        print("merge 2!");
        break;
      case 3:
        print("merge 3!");
        break;
      case 4:
        print("merge 4!");
        break;
      case 5:
        print("User Logged out");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
        break;
    }
  }
}
