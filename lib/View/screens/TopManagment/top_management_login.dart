import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mni_tender_flow/Repo/head_of_tender_services.dart';

import '../../../Repo/top_management_services.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../HoT/HomeScreen/home_screen.dart';
import 'TopManagmentHomeScreen/top_managment_home_screen.dart';


class TopManagmentLoginScreen extends StatefulWidget {
  @override
  State<TopManagmentLoginScreen> createState() => _TopManagmentLoginScreenState();
}

class _TopManagmentLoginScreenState extends State<TopManagmentLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  String _errorMessage = '';

  bool isLoading = false;
  bool isShow = false;

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
          padding: const EdgeInsets.all(16.0),
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
                  decoration: const BoxDecoration(
                    color: Colors.cyanAccent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
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
                  prefixIcon: const Icon(Icons.email),
                  controller: _emailController,
                  labelText: 'Email',
                ),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
                isLoading? const Center(child: CircularProgressIndicator()):
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent),
                    onPressed: ()async {
                      // Perform sign-up logic here
                      if (_formkey.currentState!.validate()) {
                        isLoading=true;
                        setState(() {

                        });
                        bool status=await TopManagementServices().userLogin(_emailController.text, _passwordController.text);
                        if(status==true){
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=>
                                  TopManagmentHomeScreen()), (route) => false);
                          isLoading=false;
                          setState(() {

                          });
                        }else{
                          isLoading=false;
                          setState(() {

                          });
                        }
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
