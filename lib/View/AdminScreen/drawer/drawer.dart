import 'package:flutter/material.dart';
import '../../screens/RoleScreen/role_screen.dart';
import '../head_tenderlist.dart';
import '../topmanagment_list.dart';
import 'custom_ties.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  // SharedPreferences? preferences;
  // @override
  // void initState() {
  //   SharedPreferences.getInstance().then((value) {
  //     preferences = value;
  //     setState(() {});
  //   });
  //   super.initState();
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF292b2e),
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              accountName: Text(
                "Admin",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                '',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          CustomTile1(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: 'Top Management',
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 18,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TopManagmentList()));
            },
          ),
          CustomTile1(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: 'Head of Tender',
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 18,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  HeadTenderList()));
            },
          ),

          CustomTile1(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: "Logout",
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 18,
            ),
            onTap: () {
              logoutDialog();
            },
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  logoutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Log Out"),
            content: const Text("Are you sure to Logout?"),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) =>  RoleScreen()),
                          (route) => false);
                },
                child: const Text("Log Out"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
            ],
          );
        });
  }
}
