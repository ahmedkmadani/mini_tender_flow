import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mni_tender_flow/Model/user_model.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../screens/Auth/SignUpScreen/sign_up_screen.dart';
import '../screens/IntiatorScreen/intiator_screen.dart';
import 'admin_home.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  String _errorMessage = '';

  bool isLoading = false;
  bool isShow = false;
  userLogin() async {
    isLoading = true;
    setState(() {});
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    bool userNameExists;
    bool passwordExists;
    try {
      var authResult = await FirebaseFirestore.instance
          .collection("Admin")
          .where('email', isEqualTo: _emailController.text)
          .get();
      userNameExists = authResult.docs.isNotEmpty;
      if (userNameExists) {
        var authResult = await FirebaseFirestore.instance
            .collection("Admin")
            .where('password', isEqualTo: _passwordController.text.toLowerCase())
            .get();
        passwordExists = authResult.docs.isNotEmpty;
        if (passwordExists) {
          var authResult = await FirebaseFirestore.instance
              .collection("Admin")
              .where('email', isEqualTo: _emailController.text.toLowerCase()  )
              .get().then((value) {
            value.docs.forEach((result) {
              print("result = ${result.data()}");
              // StaticInfo.docId =result.data()['doc'];
            });
          });
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Successfully logged in');
          //NavigateToHome
          Navigator.push(context, MaterialPageRoute(builder: (_) {
                                    return AdminSide();
                                  }));
        } else {
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Incorrect email or password');
        }
      } else {
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Incorrect email or password');
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.supervised_user_circle,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // CircleAvatar(
                //   radius: 50,
                //   backgroundColor: Colors.cyanAccent,
                // ),

                CustomTextField(
                  validator: (val){
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  },
                  prefixIcon: Icon(Icons.email),
                  controller: _emailController,
                  labelText: 'Email',
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  obscureText: isShow,
                  validator: (val){
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  },
                  controller: _passwordController,
                  prefixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      child: const Icon(Icons.lock)),
                  labelText: 'Password',


                ),
                SizedBox(height: 16.0),
                isLoading? Center(child: CircularProgressIndicator()):
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent),
                    onPressed: () {
                      // Perform sign-up logic here
                      if (_formkey.currentState!.validate()) {
                        userLogin();
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       automaticallyImplyLeading: false,
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //     ),
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: EdgeInsets.all(16.0),
  //         child: Form(
  //           key: _formkey,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               const SizedBox(
  //                 height: 80,
  //               ),
  //               Container(
  //                 width: 90,
  //                 height: 90,
  //                 decoration: BoxDecoration(
  //                   color: Colors.cyanAccent,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 child: Icon(
  //                   Icons.admin_panel_settings,
  //                   size: 50,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 50,
  //               ),
  //               // CircleAvatar(
  //               //   radius: 50,
  //               //   backgroundColor: Colors.cyanAccent,
  //               // ),
  //
  //               CustomTextField(
  //                 prefixIcon: Icon(Icons.email),
  //                 controller: _emailController,
  //                 labelText: 'Email',
  //               ),
  //               SizedBox(height: 16.0),
  //               CustomTextField(
  //                 controller: _passwordController,
  //                 prefixIcon: Icon(Icons.lock),
  //                 labelText: 'Password',
  //                 obscureText: true,
  //               ),
  //               SizedBox(height: 16.0),
  //               Container(
  //                 width: double.maxFinite,
  //                 child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.cyanAccent),
  //                   onPressed: () {
  //                     // Perform sign-up logic here
  //                     if (_formkey.currentState!.validate()) {
  //                       Navigator.push(context, MaterialPageRoute(builder: (_) {
  //                         return TopManagmentHomeScreen();
  //                       }));
  //                     } else {
  //                       Fluttertoast.showToast(
  //                           msg: 'All field must be filled',
  //                           //backgroundColor: Colors.transparent,
  //                           textColor: Colors.black,
  //                           backgroundColor: Colors.cyanAccent);
  //                     }
  //                   },
  //                   child: Text(
  //                     'Admin Login',
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
