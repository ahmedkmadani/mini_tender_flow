import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/user_model.dart';
import '../../Repo/admin_services.dart';
import '../../View Model/admin_view_model.dart';
import '../../View Model/top_management_view_model.dart';
import '../../common/text_fields.dart';

class TopManagmentList extends StatefulWidget {

  const TopManagmentList({Key? key}) : super(key: key);

  @override
  State<TopManagmentList> createState() => _TopManagmentListState();
}

class _TopManagmentListState extends State<TopManagmentList> {

  TextEditingController search = TextEditingController();
  bool isLoading = true;
  List<UserModel> users=[];

  @override
  void initState() {
    Provider.of<AdminViewModel>(context,listen: false).updateTopManagers();
    Future.delayed(const Duration(seconds: 1),(){
      users=Provider.of<AdminViewModel>(context,listen: false).topManagementList;
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
        title: const Text("Top Management"),
        centerTitle: true,
      ),
      body: isLoading?const Center(child: CircularProgressIndicator(),):users.isEmpty?
          const Center(child: Text("No Data Found"),):SingleChildScrollView(

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
                    .email!
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
                      width: double.infinity,
                      child: Card(
                          elevation: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(users[index].name.toString()),
                                subtitle:Text(users[index].email.toString()) ,
                                trailing: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: const Text('Are you sure'),
                                            content: const Text('Are you sure to Top Manager'),
                                            actions: [
                                              // The "Yes" button
                                              TextButton(
                                                  onPressed: () {

                                                    AdminServices().deleteTopManager(users[index].id!);
                                                    Provider.of<AdminViewModel>(context,listen: false).updateTopManagers();
                                                    Future.delayed(const Duration(seconds: 1),(){
                                                      users=Provider.of<AdminViewModel>(context,listen: false).topManagementList;
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

                              )
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
