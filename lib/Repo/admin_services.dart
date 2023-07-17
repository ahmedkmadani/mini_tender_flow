

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/user_model.dart';
import '../config/firestore_constants.dart';

class AdminServices{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  fetchUsers() {
    List<UserModel> users=[];
    try {
      _firestore.collection(FirestoreConstants.userCollection).snapshots().listen((event) {

        for (int i = 0; i < event.docs.length; i++) {
          UserModel dataModel = UserModel.fromJson(event.docs[i].data());
          users.add(dataModel);
        }
        // Fluttertoast.showToast(msg: "Users Fetched Successfully");
      });
      return users;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed due to $e");
    }
  }

  ///     ====> Deletion Services <====

  deleteUser(String userId){
    _firestore.collection(FirestoreConstants.userCollection).doc(userId).delete();
    Fluttertoast.showToast(msg: "Deleted Successfully");
  }

  deleteUserRequest(String userId){
    _firestore.collection(FirestoreConstants.userRequestsCollection).doc(userId).delete();
    Fluttertoast.showToast(msg: "Deleted Successfully");
  }

  deleteTenderHead(String userId){
    _firestore.collection(FirestoreConstants.headOfTenderCollection).doc(userId).delete();
    Fluttertoast.showToast(msg: "Deleted Successfully");
  }

  deleteTopManager(String userId){
    _firestore.collection(FirestoreConstants.topManagementCollection).doc(userId).delete();
    Fluttertoast.showToast(msg: "Deleted Successfully");
  }

  ///   =====> Data Fetching Services <=====

  fetchUserRequests(){
    List<UserModel> users=[];
    try {
      _firestore.collection(FirestoreConstants.userRequestsCollection).snapshots().listen((event) {

        for (int i = 0; i < event.docs.length; i++) {
          UserModel dataModel = UserModel.fromJson(event.docs[i].data());
          users.add(dataModel);
        }
      });
      // Fluttertoast.showToast(msg: "User Requests Fetched Successfully");
      return users;

    } catch (e) {
      Fluttertoast.showToast(msg: "Failed due to $e");
    }
  }

  fetchTopManagers(){
    List<UserModel> users=[];
    try {
      _firestore.collection(FirestoreConstants.topManagementCollection).snapshots().listen((event) {

        for (int i = 0; i < event.docs.length; i++) {
          UserModel dataModel = UserModel.fromJson(event.docs[i].data());
          users.add(dataModel);
        }
      });
      // Fluttertoast.showToast(msg: "User Requests Fetched Successfully");
      return users;

    } catch (e) {
      Fluttertoast.showToast(msg: "Failed due to $e");
    }
  }

  fetchTenderHeads(){
    List<UserModel> users=[];
    try {
      _firestore.collection(FirestoreConstants.headOfTenderCollection).snapshots().listen((event) {

        for (int i = 0; i < event.docs.length; i++) {
          UserModel dataModel = UserModel.fromJson(event.docs[i].data());
          users.add(dataModel);
        }
      });
      // Fluttertoast.showToast(msg: "User Requests Fetched Successfully");
      return users;

    } catch (e) {
      Fluttertoast.showToast(msg: "Failed due to $e");
    }
  }

  ///   =====> Data Adding Services <=====

  acceptUser(UserModel user) async {
    try {
      await _firestore.collection(FirestoreConstants.userCollection)
          .doc(user.id)
          .set(user.toJson());
      await _firestore.collection(FirestoreConstants.userRequestsCollection).
          doc(user.id).delete();
      Fluttertoast.showToast(msg: 'User Request Accepted');

    } catch (e) {
      Fluttertoast.showToast(msg: "Failed due to $e");
    }
  }

  addTopManager(UserModel manager)async{

    try {
      var checkManager=await _firestore.collection(FirestoreConstants.topManagementCollection).where(
        'email',isEqualTo: manager.email
      ).get();

      if(checkManager.docs.isEmpty){
        await _firestore.collection(FirestoreConstants.topManagementCollection)
            .doc(manager.id)
            .set(manager.toJson());
        Fluttertoast.showToast(msg: 'Manager Added successfully');
      }else{
        Fluttertoast.showToast(msg: 'User is Already Top Manager');
      }


    } catch (e) {

      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }

  addTenderHead(UserModel tenderHead)async{

    try {
      var checkManager=await _firestore.collection(FirestoreConstants.headOfTenderCollection).where(
          'email',isEqualTo: tenderHead.email
      ).get();

      if(checkManager.docs.isEmpty){
        await _firestore.collection(FirestoreConstants.headOfTenderCollection)
            .doc(tenderHead.id)
            .set(tenderHead.toJson());
        Fluttertoast.showToast(msg: 'Tender Head Added successfully');
      }else{
        Fluttertoast.showToast(msg: 'User is Already Tender Head');
      }


    } catch (e) {

      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }



}