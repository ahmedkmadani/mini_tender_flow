
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/user_model.dart';
import '../config/firestore_constants.dart';

class UserServices{
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  signUp(String userName,
      String email,
      String password,
      String id)async{
    var result=await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    if(result.user!=null){
      bool register=registerUser(userName, email, password, result.user!.uid);
      if(register==true){
        return true;
      }else{
        return false;
      }
    }
  }

  registerUser(
      String userName,
      String email,
      String password,
      String id
      ) async {


    String id=DateTime.now().toString();
    UserModel dataModel = UserModel(
      name: userName,
      email: email,
      password: password,
      id: id,
    );
    try {
      // String userId=DateTime.now().microsecondsSinceEpoch.toString();
      var userData=await _firestore.collection(FirestoreConstants.userRequestsCollection).where('email'.toLowerCase(),isEqualTo: email.toLowerCase()).get();
      if(userData.docs.isNotEmpty){
        Fluttertoast.showToast(msg: 'User Email Already Exists');
      }else{
        await _firestore.collection(FirestoreConstants.userRequestsCollection).doc(id)
            .set(dataModel.toJson());
        Fluttertoast.showToast(msg: 'Request Submitted for Approval');
      }

    } catch (e) {

      Fluttertoast.showToast(msg: 'Failed due to $e');
    }
  }


  userLogin(
      String email,
      String password
      ) async {

    // var result=await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    // if(result.user!.uid.isNotEmpty){
    //   return true;
    // }
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    bool userNameExists;
    bool passwordExists;
    try {
      var authResult = await _firestore.collection(FirestoreConstants.userCollection)
          .where('email'.toLowerCase(), isEqualTo: email.toLowerCase())
          .get();
      userNameExists = authResult.docs.isNotEmpty;
      if (userNameExists) {
        var authResult = await _firestore.collection(FirestoreConstants.userCollection).where('password',
            isEqualTo: password).get();
        passwordExists = authResult.docs.isNotEmpty;
        if (passwordExists) {
          return true;
        } else {
         return false;
        }
      } else {
        Fluttertoast.showToast(msg: 'Incorrect email or password');
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed due to $e');
      return false;
    }
  }


}