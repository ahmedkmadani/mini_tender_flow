import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../Model/user_model.dart';
import '../../../../Repo/user_services.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../LoginScreen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  File? imageFile;
  final TextEditingController _passwordController = TextEditingController();

  String? status;
  String? statusId = Uuid().v1();
  //status chechked

  // uploading images to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref =
        _storage.ref().child('ProfilePics').child(_auth.currentUser!.uid);
    TaskSnapshot snapshot = await ref.putFile(image);

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 150, maxHeight: 150);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Fluttertoast.showToast(msg: 'Image selected successfuly');
    } else {
      Fluttertoast.showToast(msg: ' Image is not selected');
    }
  }

 bool isLoading = false;




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text("User Registration", style: TextStyle(fontSize: 18),),
                // GestureDetector(
                //   onTap: () {
                //     _getFromGallery();
                //   },
                //   child: Center(
                //       child: imageFile != null
                //           ? Container(
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //         ),
                //         child: ClipRRect(
                //           borderRadius:
                //           BorderRadius.circular(100),
                //           child: Image.file(
                //             imageFile!,
                //             fit: BoxFit.cover,
                //             width: 130,
                //             height: 130,
                //           ),
                //         ),
                //       )
                //           : Stack(
                //         clipBehavior: Clip.none,
                //         children: [
                //           CircleAvatar(
                //               backgroundColor:
                //               Theme.of(context).primaryColor,
                //               radius: 60),
                //           Positioned(
                //               right: 7,
                //               bottom: 1,
                //               child: Icon(
                //                 Icons.add_circle_outlined,
                //                 color: Colors.cyanAccent,
                //                 size: 40,
                //               )),
                //         ],
                //       )),
                // ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  validator: (val){
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Icons.person),
                  controller: _nameController,
                  labelText: 'Name',
                ),
                const SizedBox(height: 16.0),
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
                  validator: (val){
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  },
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                isLoading ?const Center(child: CircularProgressIndicator()):
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent),
                    onPressed: () async {


                      if (_formkey.currentState!.validate()) {
                        await UserServices().registerUser(_nameController.text,
                            _emailController.text,
                            _passwordController.text,
                            "");
                      }
                      // Perform sign-up logic here
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 1.0),
                    TextButton(
                      onPressed: () {
                        // Perform login navigation here
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                              return const LoginScreen();
                            }));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         // Perform Google sign-in logic here
                //       },
                //       child: Image.network(
                //         'https://freesvg.org/img/1534129544.png',
                //         height: 40.0,
                //       ),
                //     ),
                //     SizedBox(width: 16.0),
                //     GestureDetector(
                //       onTap: () {
                //         // Perform Facebook sign-in logic here
                //       },
                //       child: Image.network(
                //         'https://upload.wikimedia.org/wikipedia/en/thumb/0/04/Facebook_f_logo_%282021%29.svg/150px-Facebook_f_logo_%282021%29.svg.png',
                //         height: 40.0,
                //       ),
                //     ),
                //     SizedBox(width: 16.0),
                //     GestureDetector(
                //       onTap: () {
                //         // Perform Apple sign-in logic here
                //       },
                //       child: Image.network(
                //         'https://www.pngkit.com/png/full/12-120385_apple-logo-color-png-apple-iphone-logo-design.png',
                //         height: 40.0,
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
