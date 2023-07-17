import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mni_tender_flow/Model/user_model.dart';
import '../../../Repo/head_of_tender_services.dart';
import '../../../common/widgets/custom_textfield.dart';
import 'HomeScreen/home_screen.dart';

class HotLogin extends StatefulWidget {
  @override
  State<HotLogin> createState() => _HotLoginState();
}

class _HotLoginState extends State<HotLogin> {
  final TextEditingController _emailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

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
                  validator: (val) {
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
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  },
                  controller: _passwordController,
                  prefixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      child: const Icon(Icons.lock)),
                  labelText: 'Password',
                ),
                const SizedBox(height: 16.0),
                isLoading
                    ? Center(child: const CircularProgressIndicator())
                    : Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent),
                          onPressed: () async {
                            // Perform sign-up logic here
                            if (_formkey.currentState!.validate()) {
                              bool status = await HeadOfTenderServices()
                                  .userLogin(_emailController.text,
                                      _passwordController.text);
                              print(status);
                              if (status == true) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreenHot()),
                                    (route) => false);
                              }
                            }
                          },
                          child: const Text(
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
}
