import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/allergies/allergies_page.dart';
import 'package:frontend/screens/daily/daily_page.dart';
import 'package:frontend/screens/favorites/favorite_page.dart';
import 'package:frontend/screens/hellopage/hellopage.dart';
import 'package:frontend/screens/hourly/hourly_page.dart';
import 'package:frontend/screens/login/login_screen.dart';
import 'package:frontend/screens/search/search_page.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: Color.fromARGB(171, 128, 162, 255),
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
            value: 0,
            child: Text("Home",
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 40, 75),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ))),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 1,
          child: Text("Hourly",
              style: TextStyle(
                color: Color.fromARGB(255, 1, 40, 75),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 2,
          child: Text("Daily",
              style: TextStyle(
                color: Color.fromARGB(255, 1, 40, 75),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 3,
          child: Text("Search city",
              style: TextStyle(
                color: Color.fromARGB(255, 1, 40, 75),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 4,
          child: Text("Favorites",
              style: TextStyle(
                color: Color.fromARGB(255, 1, 40, 75),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 5,
          child: Text("Other Info",
              style: TextStyle(
                color: Color.fromARGB(255, 1, 40, 75),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
            value: 6,
            child: Row(children: const [
              SizedBox(
                width: 7,
              ),
              Text("Logout",
                  style: TextStyle(
                    color: Color.fromARGB(255, 1, 40, 75),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  )),
              Icon(
                Icons.logout_rounded,
                color: Color.fromARGB(255, 1, 40, 75),
              )
            ]))
      ],
      onSelected: (item) => SelectedItem(context, item),
    );
  }
}

// ignore: non_constant_identifier_names
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
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SearchPage()));
      break;
    case 4:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const FavoritesPage()));
      break;
    case 5:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const AllergiesPage()));
      break;
    case 6:
      FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
      break;
  }
}
