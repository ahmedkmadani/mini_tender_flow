

import 'package:flutter/material.dart';

import '../Model/managment_model.dart';
import '../Model/user_model.dart';
import '../Repo/admin_services.dart';
import '../Repo/top_management_services.dart';

class TopManagementViewModel with ChangeNotifier{
  List<ManagementModel> managementList=[];

  updateUsers(){
    managementList=TopManagementServices().fetchTopManagement();
    notifyListeners();
  }

}