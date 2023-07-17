

import 'package:flutter/material.dart';
import 'package:mni_tender_flow/View/AdminScreen/user_requests.dart';

import '../Model/user_model.dart';
import '../Repo/admin_services.dart';

class AdminViewModel with ChangeNotifier{
  List<UserModel> users=[];
  List<UserModel> userRequest=[];
  List<UserModel> topManagementList=[];
  List<UserModel> headOfTenderList=[];


  updateTopManagers(){
    topManagementList=AdminServices().fetchTopManagers();
  }

  updateTenderHeads(){
    headOfTenderList=AdminServices().fetchTenderHeads();
  }

  updateUsers(){
    users=AdminServices().fetchUsers();
    // notifyListeners();
  }

  updateUserRequests(){
    userRequest=AdminServices().fetchUserRequests();
  }


}