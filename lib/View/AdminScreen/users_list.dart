import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Model/user_model.dart';
import '../../Repo/admin_services.dart';
import '../../View Model/admin_view_model.dart';
import '../../common/text_fields.dart';
import '../../config/firestore_constants.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {

  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  TextEditingController search = TextEditingController();
  bool isLoading = true;
  List<UserModel> users=[];
  @override
  void initState() {
    Provider.of<AdminViewModel>(context,listen: false).updateUsers();
    Future.delayed(const Duration(seconds: 1),(){
      users=Provider.of<AdminViewModel>(context,listen: false).users;
      isLoading=false;
      setState(() {

      });
    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: const Text("Users"),
        centerTitle: true,
      ),
      body: isLoading?const Center(child: CircularProgressIndicator(),):
          users.isEmpty?const Center(child: Text("No User Available"),):
          SingleChildScrollView(

        child: Column(children: [
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CommonTextFieldWithTitle(
              '',
              'Search by Name',
              search,
                  (val) {
                setState(() {});
                return null;
              },
              onChanged: (val) {
                setState(() {});
              },
              suffixIcon: const Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 10,),

          ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index){
                if (users[index]
                    .name!
                    .toLowerCase()
                    .contains(search.text.toLowerCase())) {
                  return  GestureDetector(
                    // onTap: (){
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => UserDetails(
                    //           users  ,index
                    //       )));
                    //
                    // },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*.9,
                      // height: ,
                      child: Card(
                        color: Colors.white,
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(users[index].name.toString()),
                                  subtitle:Text(users[index].email.toString()) ,
                                  trailing: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                              title: const Text('Are you sure'),
                                              content: const Text('Are you sure to delete User'),
                                              actions: [
                                                // The "Yes" button
                                                TextButton(
                                                    onPressed: () {
                                                      AdminServices().deleteUser(users[index].id!);
                                                      Fluttertoast.showToast(msg: "Deleted Successfully");
                                                      Provider.of<AdminViewModel>(context,listen: false).updateUsers();
                                                      Future.delayed(const Duration(seconds: 1),(){
                                                        users=Provider.of<AdminViewModel>(context,listen: false).users;
                                                        isLoading=false;
                                                        setState(() {

                                                        });
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Yes')),
                                                TextButton(
                                                    onPressed: () {
                                                      // Close the dialog
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('No'))
                                              ],
                                            );
                                          });

                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),

                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext ctx) {
                                              return AlertDialog(
                                                title: const Text('Warning'),
                                                content: const Text('Are you sure to Make User Top Manager'),
                                                actions: [
                                                  // The "Yes" button
                                                  TextButton(
                                                      onPressed: () {
                                                        AdminServices().addTopManager(users[index]);
                                                        Provider.of<AdminViewModel>(context,listen: false).updateUsers();
                                                        Future.delayed(const Duration(seconds: 1),(){
                                                          users=Provider.of<AdminViewModel>(context,listen: false).users;
                                                          isLoading=false;
                                                          setState(() {

                                                          });
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        // Close the dialog
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('No'))
                                                ],
                                              );
                                            });

                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: MediaQuery.of(context).size.width*.4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          color: Colors.greenAccent
                                        ),
                                        child: const Text("Make Top Manager",
                                        style: TextStyle(color: Colors.black),),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext ctx) {
                                              return AlertDialog(
                                                title: const Text('Warning'),
                                                content: const Text('Are you sure to Make User Tender Head'),
                                                actions: [
                                                  // The "Yes" button
                                                  TextButton(
                                                      onPressed: () {
                                                        AdminServices().addTenderHead(users[index]);
                                                        Provider.of<AdminViewModel>(context,listen: false).updateUsers();
                                                        Future.delayed(const Duration(seconds: 1),(){
                                                          users=Provider.of<AdminViewModel>(context,listen: false).users;
                                                          isLoading=false;
                                                          setState(() {

                                                          });
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('Yes')),
                                                  TextButton(
                                                      onPressed: () {
                                                        // Close the dialog
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('No'))
                                                ],
                                              );
                                            });

                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: MediaQuery.of(context).size.width*.4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                            color: Colors.greenAccent
                                        ),
                                        child: const Text("Make Tender Head",
                                          style: TextStyle(color: Colors.black),),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ) ;
                } else {
                  return Container();
                }
              })
        ],),
      ),
    );
  }

}
