import 'package:flutter/material.dart';
import 'package:mysqlcrudislemleri/components/sol_menu_ogesi.dart';
import 'package:mysqlcrudislemleri/components/sol_menu_baslik.dart';
import 'package:mysqlcrudislemleri/screens/employees_screen.dart';
import 'package:mysqlcrudislemleri/screens/ogrenciler_screen.dart';
import 'package:mysqlcrudislemleri/screens/okul_screen.dart';
import 'package:mysqlcrudislemleri/maxslectures/maxslectures.dart';

class SolMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          CreateHeader(),
          CreateDrawerItem(
            icon: Icons.contacts,
            text: 'Personeller',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmployeesScreen(title: "Personeller"),
              ),
            ),
          ),
          CreateDrawerItem(
            icon: Icons.event,
            text: 'Öğrenciler',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OgrenciScreen(title: "Öğrenciler"),
              ),
            ),
          ),
          CreateDrawerItem(
            icon: Icons.note,
            text: 'Okullar',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OkulScreen(title: "Okullar"),
              ),
            ),
          ),
          Divider(),
          CreateDrawerItem(
            icon: Icons.collections_bookmark,
            text: 'Max\'s Lectures',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MaxsLectures(
                  title: "Max's Lectures",
                ),
              ),
            ),
          ),
          CreateDrawerItem(icon: Icons.face, text: 'Authors', onTap: () {}),
          CreateDrawerItem(
              icon: Icons.account_box,
              text: 'Flutter Documentation',
              onTap: () {}),
          CreateDrawerItem(
              icon: Icons.stars, text: 'Useful Links', onTap: () {}),
          Divider(),
          CreateDrawerItem(
              icon: Icons.bug_report, text: 'Report an issue', onTap: () {}),
          ListTile(
            title: Text('Version: 0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
