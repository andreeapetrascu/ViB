import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/global_controller.dart';
import 'package:frontend/widgets/heade_widget.dart';
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
        backgroundColor: const Color.fromARGB(0, 234, 234, 234),
        leading: const BackButton(color: Colors.white),
      ),
      body: SafeArea(
        child: Obx(() => globalCoontroller.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  HeaderWidget(),
                ],
              )),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text("Hello!"),
        //     SizedBox(height: 40),
        //     ElevatedButton.icon(
        //         style: ElevatedButton.styleFrom(
        //             minimumSize: Size.fromHeight(50)),
        //         onPressed: () => FirebaseAuth.instance.signOut(),
        //         icon: Icon(Icons.arrow_back, size: 32),
        //         label: Text('sign out', style: TextStyle(fontSize: 24)))
        //   ],
        // )
      ),
    );
  }
}
