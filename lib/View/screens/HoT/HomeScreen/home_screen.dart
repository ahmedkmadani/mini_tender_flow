import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../Model/tender_model.dart';
import '../../../../common/widgets/rounded_container.dart';
import '../../../../config/AppColors.dart';
import '../../../../config/AppConstants.dart';
import '../../IntiatorScreen/intiator_screen.dart';
import '../../TopManagment/TopManagmentHomeScreen/top_managment_home_screen.dart';
import '../TenderScreen/tender_screen.dart';

class HomeScreenHot extends StatefulWidget {
  @override
  State<HomeScreenHot> createState() => _HomeScreenHotState();
}

class _HomeScreenHotState extends State<HomeScreenHot> {
  var firestore = FirebaseFirestore.instance.collection('userform');

  String? status;

  @override
  Widget build(BuildContext context) {
    List<TenderFormModel> reviewList=[];
    List<TenderFormModel> completedList=[];
    List<TenderFormModel> pendingList=[];



    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home Screen',
            style: TextStyle(color: Colors.black),
          ),
          actions: const [
            Icon(
              Icons.more_vert,
              size: 28,
            ),
            SizedBox(
              width: 7,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              const SizedBox(height: 10),
              // CHECK THIS IS NECCESSARY
              StreamBuilder<QuerySnapshot>(
                  stream: firestore.snapshots(),
                  builder: (context, snapshot)
                  {

                    if(snapshot.hasData){
                      pendingList.clear();
                      reviewList.clear();
                      completedList.clear();
                      for(int i=0;i<snapshot.data!.docs.length;i++){
                        if(snapshot.data!.docs[i][TenderFormFields.progressStatus]=='Pending'){
                          TenderFormModel tender=TenderFormModel.fromJson(snapshot.data!.docs[i]);
                          pendingList.add(tender);
                        }else if(snapshot.data!.docs[i][TenderFormFields.progressStatus]=='Completed' &&
                            snapshot.data!.docs[i][TenderFormFields.assignedTo]=='HoT'
                        ){
                          TenderFormModel tender=TenderFormModel.fromJson(snapshot.data!.docs[i]);
                          completedList.add(tender);
                        }else if(snapshot.data!.docs[i][TenderFormFields.progressStatus]=='Review' &&
                            snapshot.data!.docs[i][TenderFormFields.assignedTo]=='HoT'
                        ){
                          TenderFormModel tender=TenderFormModel.fromJson(snapshot.data!.docs[i]);
                          reviewList.add(tender);
                      }
                    }
                    }


                      return snapshot.hasData? Column(
                        children: [
                          RoundedContainer(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 3),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                    spreadRadius: 0.5)
                              ],
                              color: Colors.white,
                              width: double.maxFinite,
                              title:
                                  'You have following ${pendingList.length} tasks to be Approved'),
                          const SizedBox(
                            height: AppSize.DEFAULT_HEIGHT,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*.15,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 3),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColors.LIME_GREEN.withOpacity(0.9),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5)
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: ListView.builder(

                                itemCount: pendingList.length,
                                itemBuilder: (context,index) {
                                    return
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: RoundedContainer(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                      Colors.grey.withOpacity(0.3),
                                                      blurRadius: 0.5,
                                                      spreadRadius: 0.5)
                                                ],
                                                fontColor: Colors.white,
                                                color: Colors.indigoAccent.shade400,
                                                margin: const EdgeInsets.only(right: 3),
                                                title: "${index+1}",
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context)=>
                                                                TenderScreen(heroTag: 'x',tender: pendingList[index],docId: snapshot.data!.docs[index].id)));
                                                  },
                                                  child: RoundedContainer(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(0.3),
                                                            blurRadius: 0.5,
                                                            spreadRadius: 0.5)
                                                      ],
                                                      color: Colors.tealAccent,
                                                      margin: const EdgeInsets.only(right: 3),
                                                      title: pendingList[index].name),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: RoundedContainer(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.5)
                                                    ],
                                                    color: Colors.deepOrangeAccent,
                                                    fontStyle: FontStyle.italic,
                                                    fontColor: Colors.white,
                                                    margin: const EdgeInsets.only(right: 3),
                                                    title: pendingList[index].progressStatus)),
                                            Expanded(
                                                flex: 2,
                                                child: RoundedContainer(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.5)
                                                    ],
                                                    color: Colors.lightBlueAccent,
                                                    fontColor: Colors.white,
                                                    margin: const EdgeInsets.only(right: 3),
                                                    title: pendingList[index].tenderType)),
                                          ],
                                        ),
                                      );


                              }
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.DEFAULT_HEIGHT,
                          ),
                          RoundedContainer(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                    spreadRadius: 0.5)
                              ],
                              color: Colors.white,
                              width: double.maxFinite,
                              title: 'Following ${reviewList.length} tasks are to be reviewed'),
                          const SizedBox(
                            height: AppSize.DEFAULT_HEIGHT,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*.15,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 3),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                      AppColors.LIME_GREEN.withOpacity(0.9),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5)
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: ListView.builder(

                                itemCount: reviewList.length,
                                itemBuilder: (context,index) {
                                    return
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: RoundedContainer(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                      Colors.grey.withOpacity(0.3),
                                                      blurRadius: 0.5,
                                                      spreadRadius: 0.5)
                                                ],
                                                fontColor: Colors.white,
                                                color: Colors.indigoAccent.shade400,
                                                margin: const EdgeInsets.only(right: 3),
                                                title: "${index+1}",
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context)=>
                                                                TenderScreen(heroTag: 'x',tender: reviewList[index],docId: snapshot.data!.docs[index].id)));
                                                  },
                                                  child: RoundedContainer(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(0.3),
                                                            blurRadius: 0.5,
                                                            spreadRadius: 0.5)
                                                      ],
                                                      color: Colors.tealAccent,
                                                      margin: const EdgeInsets.only(right: 3),
                                                      title: reviewList[index].name),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: RoundedContainer(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.5)
                                                    ],
                                                    color: Colors.deepOrangeAccent,
                                                    fontStyle: FontStyle.italic,
                                                    fontColor: Colors.white,
                                                    margin: const EdgeInsets.only(right: 3),
                                                    title: reviewList[index].progressStatus)),
                                            Expanded(
                                                flex: 2,
                                                child: RoundedContainer(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.5)
                                                    ],
                                                    color: Colors.lightBlueAccent,
                                                    fontColor: Colors.white,
                                                    margin: const EdgeInsets.only(right: 3),
                                                    title: reviewList[index].tenderType)),
                                          ],
                                        ),
                                      );


                                }
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          RoundedContainer(
                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0.5)
                              ],
                              color: Colors.white,
                              width: double.maxFinite,
                              title:
                              'Following ${completedList.length} tasks are completed'),
                          const SizedBox(
                            height: AppSize.DEFAULT_HEIGHT,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*.15,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 3),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                      AppColors.LIME_GREEN.withOpacity(0.9),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5)
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: ListView.builder(

                                itemCount: completedList.length,
                                itemBuilder: (context,index) {
                                    return
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: RoundedContainer(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                      Colors.grey.withOpacity(0.3),
                                                      blurRadius: 0.5,
                                                      spreadRadius: 0.5)
                                                ],
                                                fontColor: Colors.white,
                                                color: Colors.indigoAccent.shade400,
                                                margin: const EdgeInsets.only(right: 3),
                                                title: "${index+1}",
                                              ),
                                            ),
                                            Expanded(
                                                flex: 7,
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context)=>
                                                                TenderScreen(heroTag: 'x',tender: completedList[index],docId: snapshot.data!.docs[index].id,)));
                                                  },
                                                  child: RoundedContainer(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(0.3),
                                                            blurRadius: 0.5,
                                                            spreadRadius: 0.5)
                                                      ],
                                                      color: Colors.tealAccent,
                                                      margin: const EdgeInsets.only(right: 3),
                                                      title: completedList[index].name),
                                                )),
                                            Expanded(
                                                flex: 3,
                                                child: RoundedContainer(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.5)
                                                    ],
                                                    color: Colors.deepOrangeAccent,
                                                    fontStyle: FontStyle.italic,
                                                    fontColor: Colors.white,
                                                    margin: const EdgeInsets.only(right: 3),
                                                    title: completedList[index].progressStatus)),
                                            Expanded(
                                                flex: 2,
                                                child: RoundedContainer(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.5)
                                                    ],
                                                    color: Colors.lightBlueAccent,
                                                    fontColor: Colors.white,
                                                    margin: const EdgeInsets.only(right: 3),
                                                    title: completedList[index].tenderType)),
                                          ],
                                        ),
                                      );


                                }
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RoundedContainer(
                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0.5)
                              ],
                              color: Colors.white,
                              width: double.maxFinite,
                              title:
                              'Following ${completedList.length} tasks to be Send Back'),
                          const SizedBox(
                            height: AppSize.DEFAULT_HEIGHT,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*.15,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 3),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                      AppColors.LIME_GREEN.withOpacity(0.9),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5)
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: ListView.builder(

                                itemCount: completedList.length,
                                itemBuilder: (context,index) {
                                  return
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: RoundedContainer(
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                    Colors.grey.withOpacity(0.3),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.5)
                                              ],
                                              fontColor: Colors.white,
                                              color: Colors.indigoAccent.shade400,
                                              margin: const EdgeInsets.only(right: 3),
                                              title: "${index+1}",
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: InkWell(
                                                onTap: (){
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context)=>
                                                              TenderScreen(heroTag: 'x',tender: completedList[index],docId: snapshot.data!.docs[index].id,)));
                                                },
                                                child: RoundedContainer(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.5)
                                                    ],
                                                    color: Colors.tealAccent,
                                                    margin: const EdgeInsets.only(right: 3),
                                                    title: completedList[index].name),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: RoundedContainer(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        blurRadius: 0.5,
                                                        spreadRadius: 0.5)
                                                  ],
                                                  color: Colors.deepOrangeAccent,
                                                  fontStyle: FontStyle.italic,
                                                  fontColor: Colors.white,
                                                  margin: const EdgeInsets.only(right: 3),
                                                  title: completedList[index].progressStatus)),
                                          Expanded(
                                              flex: 2,
                                              child: RoundedContainer(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        blurRadius: 0.5,
                                                        spreadRadius: 0.5)
                                                  ],
                                                  color: Colors.lightBlueAccent,
                                                  fontColor: Colors.white,
                                                  margin: const EdgeInsets.only(right: 3),
                                                  title: completedList[index].tenderType)),
                                        ],
                                      ),
                                    );


                                }
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: AppColors.LIME_GREEN.withOpacity(0.9),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5)
                            ], borderRadius: BorderRadius.circular(5), color: Colors.white),
                            child: Column(
                              children: [

                                InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const IntiatorScreen()));
                                    },
                                    child: RoundedContainer(title: 'Click to Initiate New application form')),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.DEFAULT_HEIGHT,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.only(top: 5, left: 12),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.LIME_GREEN.withOpacity(0.9),
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5)
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 2),

                                InkWell(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>const TopManagmentHomeScreen()));
                                  },
                                  child: FittedBox(
                                      child: RoundedContainer(
                                          fontColor: Colors.white,
                                          color: Colors.blueGrey,
                                          padding: const EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                                          title: 'Historical Data')),
                                ),
                                const SizedBox(height: AppSize.DEFAULT_HEIGHT),
                                FittedBox(
                                    child: RoundedContainer(
                                        color: Colors.green,
                                        fontColor: Colors.white,
                                        padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                                        title: 'Approved')),
                                const SizedBox(height: AppSize.DEFAULT_HEIGHT),
                                FittedBox(
                                    child: RoundedContainer(
                                        fontColor: Colors.white,
                                        color: Colors.red,
                                        padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                                        title: 'Not Approved')),
                                const SizedBox(
                                  height: 90,
                                )
                              ],
                            ),
                          )


                        ],
                      ):
                      const Center(
                        child: CircularProgressIndicator(),
                      );

                  }),


            ]),
          ),
        ));
  }
}
