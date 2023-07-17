import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mni_tender_flow/Model/hot_model.dart';
import '../../../Model/user_model.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../screens/TopManagment/TopManagmentHomeScreen/top_managment_home_screen.dart';

class AddHot extends StatefulWidget {
  @override
  State<AddHot> createState() => _AddHotState();
}

class _AddHotState extends State<AddHot> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  File? imageFile;
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  // uploading images to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref =
        _storage.ref().child('ProfilePicsHot').child(_auth.currentUser!.uid);
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

  Future<void> _signUp() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _uploadToStorage(imageFile!);
      String? downloadUrl = await _uploadToStorage(imageFile!);
      HotModel _userModel = HotModel(
          imageSrc: downloadUrl, email: email, password: password, name: '');

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TopManagmentHomeScreen()));
      Fluttertoast.showToast(
          msg: "Account created  Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.cyanAccent,
          textColor: Colors.black,
          fontSize: 16.0);
      // User successfully signed up
      await _firestore
          .collection('Hot')
          .doc(_auth.currentUser!.uid)
          .set(_userModel.toJson());
      User? user = userCredential.user;
      print('User signed up: ${user?.email}');

      // Clear form fields and error message
      _emailController.clear();
      _passwordController.clear();
      setState(() {
        _errorMessage = '';
      });
    } catch (e) {
      // Error occurred during sign up
      print('Sign up error: $e');
      setState(() {
        _errorMessage = 'Sign up failed. Please try again.';
      });
      Fluttertoast.showToast(
          msg: _errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Center(
                      child: imageFile != null
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                  width: 130,
                                  height: 130,
                                ),
                              ),
                            )
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: 60),
                                Positioned(
                                    right: 7,
                                    bottom: 1,
                                    child: Icon(
                                      Icons.add_circle_outlined,
                                      color: Colors.cyanAccent,
                                      size: 40,
                                    )),
                              ],
                            )),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Name',
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  prefixIcon: Icon(Icons.email),
                  controller: _emailController,
                  labelText: 'Email',
                ),
                SizedBox(height: 16.0),
                CustomTextField(
                  controller: _passwordController,
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent),
                    onPressed: () {
                      if (_formkey.currentState!.validate() &&
                          imageFile != null) {
                        _signUp();
                      } else {
                        Fluttertoast.showToast(
                          gravity: ToastGravity.BOTTOM,
                          msg: 'Please fill all fields and also image',
                          //backgroundColor: Colors.transparent,
                          textColor: Colors.white,
                        );
                      }
                      // Perform sign-up logic here
                    },
                    child: Text(
                      'Add Hot',
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
