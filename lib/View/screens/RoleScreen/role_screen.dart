import 'package:flutter/material.dart';

import '../../../config/AppColors.dart';
import '../../AdminScreen/admin_login_screen.dart';
import '../Auth/SignUpScreen/sign_up_screen.dart';
import '../HoT/hot_login.dart';
import '../TopManagment/top_management_login.dart';

class RoleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIME_GREEN,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 0, color: Colors.white)),
              tileColor: Colors.white,
              leading: const Icon(Icons.person), // Replace with desired icon
              title: const Text('Admin'),
              onTap: () {
                // Handle admin login
                // You can navigate to another screen or perform login logic here
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminLoginScreen()));
              },
            ),
            const SizedBox(
              height: 14,
            ),
            ListTile(
              tileColor: Colors.white,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 0, color: Colors.white)),

              leading: const Icon(
                  Icons.account_circle_rounded), // Replace with desired icon
              title: const Text('User'),
              onTap: () {
                // Handle user login
                // You can navigate to another screen or perform login logic here
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            ),
            const SizedBox(
              height: 14,
            ),
            ListTile(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 0, color: Colors.white)),

              tileColor: Colors.white,

              leading: const Icon(Icons.perm_contact_calendar_sharp), // Replace with desired icon
              title: const Text('Top management'),
              onTap: () {
                // Handle hot login
                // You can navigate to another screen or perform login logic here

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => TopManagmentLoginScreen()));
              },
            ),
            const SizedBox(
              height: 14,
            ),
            ListTile(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 0, color: Colors.white)),

              tileColor: Colors.white,

              leading: const Icon(Icons.send_time_extension_rounded), // Replace with desired icon
              title: const Text('Head of tender'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HotLogin()));
                // Handle hot login
                // You can navigate to another screen or perform login logic here
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => HotLogin()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
