

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/managment_model.dart';
import '../Model/user_model.dart';
import '../config/firestore_constants.dart';

class TopManagementServices{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  fetchTopManagement() {
    List<ManagementModel> managementList=[];
    try {
      _firestore.collection(FirestoreConstants.topManagementCollection).snapshots().listen((event) {

        for (int i = 0; i < event.docs.length; i++) {
          ManagementModel management = ManagementModel.fromJson(event.docs[i].data());
          managementList.add(management);
        }
        Fluttertoast.showToast(msg: "Top Management Fetched Successfully");
      });
      return managementList;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed due to $e");
    }
  }

  userLogin(String email,String password) async {

    bool userNameExists;
    bool passwordExists;
    try {
      FirebaseAuth instance=FirebaseAuth.instance;
      // UserCredential  result =await  instance.signInWithEmailAndPassword(email: email, password: password);

        var authResult = await _firestore.collection(FirestoreConstants.topManagementCollection)
            .where('email'.toLowerCase(), isEqualTo: email.toLowerCase())
            .get();
        userNameExists = authResult.docs.isNotEmpty;
        if (userNameExists) {
          var authResult = await FirebaseFirestore.instance
              .collection(FirestoreConstants.topManagementCollection)
              .where('password', isEqualTo: password)
              .get();
          passwordExists = authResult.docs.isNotEmpty;
          if (passwordExists) {
            return  true;
          } else {
            Fluttertoast.showToast(msg: 'Incorrect email or password');
            return false;
          }
        } else {
          Fluttertoast.showToast(msg: 'User Not Exists');
          return false;
        }


    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed due to $e');
      return false;
    }
  }

}