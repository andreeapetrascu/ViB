import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/components/home_screen.dart';
import 'package:geolocator/geolocator.dart';

class HelloPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 234, 234, 234),
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello!"),
              SizedBox(height: 40),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  icon: Icon(Icons.arrow_back, size: 32),
                  label: Text('sign out', style: TextStyle(fontSize: 24)))
            ],
          )),
    );
  }
}
