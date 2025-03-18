import 'package:flutter/material.dart';
import 'package:traveling_app/screens/filter_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  ListTile buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'elMessiri',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => tapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: Text(
              'دليلك السياحي',
              style: TextStyle(
                fontFamily: 'elMessiri',
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildListTile('الرحلات', Icons.card_travel, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('الفلترة', Icons.filter_list, () {
            Navigator.of(
              context,
            ).pushReplacementNamed(FilterScreen.screenRoute);
          }),
        ],
      ),
    );
  }
}
