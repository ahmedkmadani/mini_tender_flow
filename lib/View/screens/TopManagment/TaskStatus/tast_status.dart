import 'package:flutter/material.dart';

import '../../../../common/widgets/rounded_container.dart';
import '../../../../config/AppColors.dart';
import '../../../../config/AppConstants.dart';
import '../TopMangmentTenderScreen/top_managment_tender_screen.dart';

class TaskStatusScreen extends StatelessWidget {
  const TaskStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tasks Status Screen',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Icon(
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
                      'You have following 13 pending  tasks to  complete as on 6-02-23'),
              const SizedBox(
                height: AppSize.DEFAULT_HEIGHT,
              ),
              Container(
                height: 500,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: AppColors.LIME_GREEN.withOpacity(0.9),
                      blurRadius: 0.5,
                      spreadRadius: 0.5)
                ], borderRadius: BorderRadius.circular(5), color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RoundedContainer(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5)
                            ],
                            fontColor: Colors.white,
                            color: Colors.indigoAccent.shade400,
                            margin: EdgeInsets.only(right: 3),
                            title: '1',
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             TopManagmentTenderScreen()));
                              },
                              child: RoundedContainer(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5)
                                  ],
                                  color: Colors.tealAccent,
                                  margin: EdgeInsets.only(right: 3),
                                  title: 'Tender 1 of .....'),
                            )),
                        Expanded(
                            flex: 3,
                            child: RoundedContainer(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5)
                                ],
                                color: Colors.deepOrangeAccent,
                                fontStyle: FontStyle.italic,
                                fontColor: Colors.white,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Pending')),
                        Expanded(
                            flex: 2,
                            child: RoundedContainer(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5)
                                ],
                                color: Colors.lightBlueAccent,
                                fontColor: Colors.white,
                                margin: EdgeInsets.only(right: 3),
                                title: 'MNEC')),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.DEFAULT_HEIGHT,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RoundedContainer(
                            color: Colors.indigoAccent.shade400,
                            margin: EdgeInsets.only(right: 3),
                            fontColor: Colors.white,
                            title: '2',
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: RoundedContainer(
                                color: Colors.tealAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Tender 2 of .....')),
                        Expanded(
                            flex: 3,
                            child: RoundedContainer(
                                color: Colors.deepOrangeAccent,
                                fontColor: Colors.white,
                                fontStyle: FontStyle.italic,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Pending')),
                        Expanded(
                            flex: 2,
                            child: RoundedContainer(
                                fontColor: Colors.white,
                                color: Colors.lightBlueAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'MNEC')),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.DEFAULT_HEIGHT,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RoundedContainer(
                            color: Colors.indigoAccent.shade400,
                            margin: EdgeInsets.only(right: 3),
                            fontColor: Colors.white,
                            title: '3',
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: RoundedContainer(
                                color: Colors.tealAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Tender 3 of .....')),
                        Expanded(
                            flex: 3,
                            child: RoundedContainer(
                                color: Colors.deepOrangeAccent,
                                fontColor: Colors.white,
                                fontStyle: FontStyle.italic,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Pending')),
                        Expanded(
                            flex: 2,
                            child: RoundedContainer(
                                fontColor: Colors.white,
                                color: Colors.lightBlueAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'EES')),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.DEFAULT_HEIGHT,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RoundedContainer(
                            color: Colors.indigoAccent.shade400,
                            margin: EdgeInsets.only(right: 3),
                            fontColor: Colors.white,
                            title: '4',
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: RoundedContainer(
                                color: Colors.tealAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Tender 4 of .....')),
                        Expanded(
                            flex: 3,
                            child: RoundedContainer(
                                color: Colors.deepOrangeAccent,
                                fontColor: Colors.white,
                                fontStyle: FontStyle.italic,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Pending')),
                        Expanded(
                            flex: 2,
                            child: RoundedContainer(
                                fontColor: Colors.white,
                                color: Colors.lightBlueAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'MNI')),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.DEFAULT_HEIGHT,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RoundedContainer(
                            color: Colors.indigoAccent.shade400,
                            margin: EdgeInsets.only(right: 3),
                            fontColor: Colors.white,
                            title: '5',
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: RoundedContainer(
                                color: Colors.tealAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Tender 5 of .....')),
                        Expanded(
                            flex: 3,
                            child: RoundedContainer(
                                color: Colors.deepOrangeAccent,
                                fontColor: Colors.white,
                                fontStyle: FontStyle.italic,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Pending')),
                        Expanded(
                            flex: 2,
                            child: RoundedContainer(
                                fontColor: Colors.white,
                                color: Colors.lightBlueAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'EES')),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.DEFAULT_HEIGHT,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RoundedContainer(
                            color: Colors.indigoAccent.shade400,
                            margin: EdgeInsets.only(right: 3),
                            fontColor: Colors.white,
                            title: '6',
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: RoundedContainer(
                                color: Colors.tealAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Tender 6 of .....')),
                        Expanded(
                            flex: 3,
                            child: RoundedContainer(
                                color: Colors.deepOrangeAccent,
                                fontColor: Colors.white,
                                fontStyle: FontStyle.italic,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Pending')),
                        Expanded(
                            flex: 2,
                            child: RoundedContainer(
                                fontColor: Colors.white,
                                color: Colors.lightBlueAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'MNI')),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.DEFAULT_HEIGHT,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RoundedContainer(
                            color: Colors.indigoAccent.shade400,
                            margin: EdgeInsets.only(right: 3),
                            fontColor: Colors.white,
                            title: '7',
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: RoundedContainer(
                                color: Colors.tealAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Tender 7 of .....')),
                        Expanded(
                            flex: 3,
                            child: RoundedContainer(
                                color: Colors.deepOrangeAccent,
                                fontColor: Colors.white,
                                fontStyle: FontStyle.italic,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Pending')),
                        Expanded(
                            flex: 2,
                            child: RoundedContainer(
                                fontColor: Colors.white,
                                color: Colors.lightBlueAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'MCC')),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.DEFAULT_HEIGHT,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RoundedContainer(
                            color: Colors.indigoAccent.shade400,
                            margin: EdgeInsets.only(right: 3),
                            fontColor: Colors.white,
                            title: '8',
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: RoundedContainer(
                                color: Colors.tealAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Tender 8 of .....')),
                        Expanded(
                            flex: 3,
                            child: RoundedContainer(
                                color: Colors.deepOrangeAccent,
                                fontColor: Colors.white,
                                fontStyle: FontStyle.italic,
                                margin: EdgeInsets.only(right: 3),
                                title: 'Pending')),
                        Expanded(
                            flex: 2,
                            child: RoundedContainer(
                                fontColor: Colors.white,
                                color: Colors.lightBlueAccent,
                                margin: EdgeInsets.only(right: 3),
                                title: 'MNEC')),
                      ],
                    ),
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
                    FittedBox(
                        child: RoundedContainer(
                            color: Colors.green,
                            fontColor: Colors.white,
                            padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                            title: 'Approved Tenders')),
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
