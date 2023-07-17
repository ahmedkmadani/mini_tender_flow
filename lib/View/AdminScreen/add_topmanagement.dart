import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../common/text_fields.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../Model/managment_model.dart';


class AddTopManagment extends StatefulWidget {
  @override
  State<AddTopManagment> createState() => _AddTopManagmentState();
}

class _AddTopManagmentState extends State<AddTopManagment> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool showPass = true;
  String _errorMessage = '';

  FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _passwordController = TextEditingController();
  bool isLoading =false;
  AddTopManagment() async {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("add top management"),
        automaticallyImplyLeading: true,
        //  backgroundColor: Colors.white,
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
                  height: 120,
                ),
                // CircleAvatar(
                //   radius: 50,
                //   backgroundColor: Colors.cyanAccent,
                // ),
                CommonTextFieldWithTitle(
                    'User Name', 'Enter User Name',   _nameController, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),

                // CustomTextField(
                //   prefixIcon: Icon(Icons.email),
                //   controller: _emailController,
                //   labelText: 'Email',
                // ),
                SizedBox(height: 16.0),
                CommonTextFieldWithTitle(
                    'User email', 'Enter User email',   _emailController, (val) {
                  if (val!.isEmpty) {
                    return 'This is required field';
                  }
                }),
                SizedBox(height: 16.0),
                CommonTextFieldWithTitle('Password', 'Enter Password', _passwordController,
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: const Icon(Icons.remove_red_eye)),
                    obscure: showPass,
                        (val) {
                      if (val!.isEmpty) {
                        return 'This is required field';
                      }
                    }),
                // CustomTextField(
                //   controller: _passwordController,
                //   prefixIcon: Icon(Icons.lock),
                //   labelText: 'Password',
                //   obscureText: true,
                // ),
                SizedBox(height: 20.0),
                isLoading?Center(child: CircularProgressIndicator()):
                Container(
                  height: 45,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue),
                    onPressed: () {
                      // Perform sign-up logic here
                      if (_formkey.currentState!.validate()) {
                        AddTopManagment();

                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
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
