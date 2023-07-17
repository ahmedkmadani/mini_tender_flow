import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../Model/tender_model.dart';
import '../../../../common/widgets/rounded_container.dart';
import '../../../../config/AppColors.dart';
import '../../../../config/AppConstants.dart';
import '../../../AdminScreen/adhot_screen.dart';
import '../TaskStatus/tast_status.dart';
import '../TopMangmentTenderScreen/top_managment_tender_screen.dart';

class TopManagmentHomeScreen extends StatefulWidget {
  const TopManagmentHomeScreen({Key? key}) : super(key: key);

  @override
  State<TopManagmentHomeScreen> createState() => _TopManagmentHomeScreenState();
}

class _TopManagmentHomeScreenState extends State<TopManagmentHomeScreen> {
  var firestore = FirebaseFirestore.instance.collection('userform');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Top managment Tasks Screen',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddHot()));
            },
            child: Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.person_add,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          const Icon(
            Icons.more_vert,
            size: 28,
          ),
          const SizedBox(
            width: 7,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // RoundedContainer(
              //     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
              //     boxShadow: [
              //       BoxShadow(
              //           color: Colors.grey.withOpacity(0.1),
              //           blurRadius: 2,
              //           offset: Offset(0, 2),
              //           spreadRadius: 0.5)
              //     ],
              //     color: Colors.white,
              //     width: double.maxFinite,
              //     title:
              //         'You have following 13 pending  tasks to  complete as on 6-02-23'),
              const SizedBox(
                height: AppSize.DEFAULT_HEIGHT,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .where(TenderFormFields.progressStatus, isEqualTo: 'Pending')
                      .snapshots(),
                  builder: (context, snapshot)
                  {

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
                            'You have following ${snapshot.data!.docs.length} tasks to be Approved'),
                        const SizedBox(
                          height: AppSize.DEFAULT_HEIGHT,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*.6,
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

                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context,index) {
                                TenderFormModel tender=TenderFormModel.fromJson(snapshot.data!.docs[index]);

                                return  Padding(
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
                                          onTap:(){
                                            Navigator.push(context,
                                                MaterialPageRoute(builder:
                                                    (context)=>TopManagmentTenderScreen(tender: tender,docId: snapshot.data!.docs[index].id,)));
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
                                                title: tender.name),
                                        ),
                                      ),
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
                                              title: tender.progressStatus)),
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
                                              title: tender.tenderType)),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ),
                      ],
                    ):
                    const Center(
                      child: CircularProgressIndicator(),
                    );

                  }),
              // Container(
              //   height: 500,
              //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              //   decoration: BoxDecoration(boxShadow: [
              //     BoxShadow(
              //         color: AppColors.LIME_GREEN.withOpacity(0.9),
              //         blurRadius: 0.5,
              //         spreadRadius: 0.5)
              //   ], borderRadius: BorderRadius.circular(5), color: Colors.white),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               boxShadow: [
              //                 BoxShadow(
              //                     color: Colors.grey.withOpacity(0.3),
              //                     blurRadius: 0.5,
              //                     spreadRadius: 0.5)
              //               ],
              //               fontColor: Colors.white,
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               title: '1',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   boxShadow: [
              //                     BoxShadow(
              //                         color: Colors.grey.withOpacity(0.3),
              //                         blurRadius: 0.5,
              //                         spreadRadius: 0.5)
              //                   ],
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 1 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   boxShadow: [
              //                     BoxShadow(
              //                         color: Colors.grey.withOpacity(0.3),
              //                         blurRadius: 0.5,
              //                         spreadRadius: 0.5)
              //                   ],
              //                   color: Colors.deepOrangeAccent,
              //                   fontStyle: FontStyle.italic,
              //                   fontColor: Colors.white,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   boxShadow: [
              //                     BoxShadow(
              //                         color: Colors.grey.withOpacity(0.3),
              //                         blurRadius: 0.5,
              //                         spreadRadius: 0.5)
              //                   ],
              //                   color: Colors.lightBlueAccent,
              //                   fontColor: Colors.white,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MNEC')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '2',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 2 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MNEC')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '3',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 3 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'EES')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '4',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 4 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MNI')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '5',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 5 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'EES')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '6',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 6 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MNI')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '7',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 7 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MCC')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '8',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 8 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MNEC')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '9',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 9 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'EES')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '10',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 10 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MCC')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '11',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 11 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MNEC')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '12',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 12 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MNI')),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: AppSize.DEFAULT_HEIGHT,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Expanded(
              //             child: RoundedContainer(
              //               color: Colors.indigoAccent.shade400,
              //               margin: EdgeInsets.only(right: 3),
              //               fontColor: Colors.white,
              //               title: '13',
              //             ),
              //           ),
              //           Expanded(
              //               flex: 7,
              //               child: RoundedContainer(
              //                   color: Colors.tealAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Tender 13 of .....')),
              //           Expanded(
              //               flex: 3,
              //               child: RoundedContainer(
              //                   color: Colors.deepOrangeAccent,
              //                   fontColor: Colors.white,
              //                   fontStyle: FontStyle.italic,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'Pending')),
              //           Expanded(
              //               flex: 2,
              //               child: RoundedContainer(
              //                   fontColor: Colors.white,
              //                   color: Colors.lightBlueAccent,
              //                   margin: EdgeInsets.only(right: 3),
              //                   title: 'MNEC')),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
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
                  borderRadius: BorderRadius.only(
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
                    FittedBox(
                        child: RoundedContainer(
                            fontColor: Colors.white,
                            color: Colors.blueGrey,
                            padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                            title: 'Historical Data')),
                    const SizedBox(height: AppSize.DEFAULT_HEIGHT),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskStatusScreen()));
                      },
                      child: FittedBox(
                          child: RoundedContainer(
                              color: Colors.green,
                              fontColor: Colors.white,
                              padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                              title: 'Approved Tenders')),
                    ),
                    const SizedBox(height: AppSize.DEFAULT_HEIGHT),
                    FittedBox(
                        child: RoundedContainer(
                            fontColor: Colors.white,
                            color: Colors.red,
                            padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                            title: 'Not Approved Tenders')),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
