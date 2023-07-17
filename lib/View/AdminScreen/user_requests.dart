import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mni_tender_flow/Repo/admin_services.dart';
import 'package:mni_tender_flow/View%20Model/admin_view_model.dart';
import 'package:provider/provider.dart';

import '../../Model/user_model.dart';
import '../../common/text_fields.dart';
class UserRequestList extends StatefulWidget {

  const UserRequestList({Key? key}) : super(key: key);

  @override
  State<UserRequestList> createState() => _UserRequestListState();
}

class _UserRequestListState extends State<UserRequestList> {
  List<UserModel> users = [];
  TextEditingController search = TextEditingController();
  bool isLoading = true;
  bool isLoadAccept= false;
  @override
  void initState() {
    Provider.of<AdminViewModel>(context,listen: false).updateUserRequests();
    Future.delayed(const Duration(seconds: 1),(){
      users=Provider.of<AdminViewModel>(context,listen: false).userRequest;
      isLoading=false;
      setState(() {

      });
    });
    super.initState();
  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Request"),
        centerTitle: true,
      ),
      body: isLoading?const Center(child: CircularProgressIndicator()):
      users.isEmpty?const Center(child: Text("No User Requests Available")):
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
                    onTap: (){
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => UserDetails(
                      //         users  ,index
                      //     )));

                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
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

                                                        FirebaseFirestore.instance
                                                            .collection("UserRequest")
                                                            .doc(users[index].id.toString())
                                                            .delete()
                                                            .then(
                                                              (doc) => print("Document deleted"),
                                                          onError: (e) =>
                                                              print("Error updating document $e"),
                                                        );
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      isLoading?const Center(child: CircularProgressIndicator()):
                                      GestureDetector(
                                        onTap:(){
                                          isLoading=true;
                                          setState(() {});
                                          AdminServices().acceptUser(users[index]);
                                          Provider.of<AdminViewModel>(context,listen: false).updateUserRequests();
                                          Future.delayed(const Duration(seconds: 1),(){
                                            users=Provider.of<AdminViewModel>(context,listen: false).userRequest;
                                          });
                                          isLoading=false;
                                          setState(() {

                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(10)),
                                          child: const Center(
                                              child: Text(
                                                "Accept",
                                                style: TextStyle(color: Colors.white),
                                              )),
                                        ),
                                      ),


                                    ],)

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
