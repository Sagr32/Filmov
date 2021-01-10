import 'package:filmov/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              Share.share(
                  "you can download my app from here \n https://play.google.com/store/apps/details?id=com.sagrkai.filmov");
            },
            leading: Text(
              "Share app",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kMainColor,
              ),
            ),
            trailing: Icon(
              Icons.share,
              color: kMainColor,
            ),
          ),
        ],
      ),
    );
  }
}
