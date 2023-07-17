import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mni_tender_flow/Model/tender_model.dart';

import '../../../../common/widgets/rounded_container.dart';
import '../../../../config/AppColors.dart';
import '../../../../config/AppConstants.dart';
import '../../IntiatorScreen/intiator_screen.dart';
import '../../TopManagment/TopManagmentHomeScreen/top_managment_home_screen.dart';
class TenderScreen extends StatefulWidget {
  final String heroTag;
  TenderFormModel tender;
  String docId;

  TenderScreen({super.key, required this.heroTag,required this.tender,required this.docId});

  @override
  State<TenderScreen> createState() => _TenderScreenState();
}

class _TenderScreenState extends State<TenderScreen> {

  bool isLoadingSendBack=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tender Screen',
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
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 15),
            Hero(
              tag: widget.heroTag,
              child: RoundedContainer(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 0.5,
                        spreadRadius: 0.5)
                  ],
                  color: Colors.white,
                  margin: const EdgeInsets.only(right: 3),
                  title: widget.tender.name),
            ),
            const SizedBox(
              height: AppSize.DEFAULT_HEIGHT,
            ),
            Row(
              children: [
                Expanded(
                  child: RoundedContainer(
                      color: Colors.green,
                      fontColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(5, 2, 5.5, 2),
                      title: 'Review form'),
                ),
                const SizedBox(
                  width: 80,
                ),
                Expanded(
                  child: RoundedContainer(
                      color: Colors.red,
                      fontColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(5, 2, 5.5, 2),
                      title: 'Upload form'),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(top: 4, left: 4),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: AppColors.LIME_GREEN.withOpacity(0.9),
                    blurRadius: 0.5,
                    spreadRadius: 0.5)
              ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  TextField(
                    maxLines: 10,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: widget.tender.description,
                      contentPadding: EdgeInsets.zero,
                      hintStyle: TextStyle(
                          color: Colors.grey..shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSize.DEFAULT_HEIGHT,
            ),
            Container(
              padding: const EdgeInsets.only(top: 4, left: 4),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: AppColors.LIME_GREEN.withOpacity(0.9),
                    blurRadius: 0.5,
                    spreadRadius: 0.5)
              ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  TextField(
                    maxLines: 10,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Write comments and recommendation by HoT:',
                      contentPadding: EdgeInsets.zero,
                      hintStyle: TextStyle(
                          color: Colors.grey..shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.DEFAULT_HEIGHT),
            FittedBox(
              child: RoundedContainer(
                  width: 110,
                  fontColor: Colors.white,
                  color: Colors.purple,
                  padding: const EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                  title: 'Importance'),
            ),
            const SizedBox(height: AppSize.DEFAULT_HEIGHT),
            FittedBox(
              child: RoundedContainer(
                  width: 110,
                  color: Colors.amber,
                  fontColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                  title: 'Assigned to'),
            ),
            const SizedBox(height: AppSize.DEFAULT_HEIGHT),
            FittedBox(
              child: RoundedContainer(
                  width: 110,
                  fontColor: Colors.white,
                  color: Colors.red,
                  padding: const EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                  title: 'Serial/parallel'),
            ),
            const SizedBox(height: AppSize.DEFAULT_HEIGHT),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => TopManagmentHomeScreen()));
              },
              child: FittedBox(
                child: RoundedContainer(
                    width: 110,
                    color: Colors.green,
                    fontColor: Colors.white,
                    padding: const EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                    title: 'Send Request'),
              ),
            ),
            const SizedBox(height: AppSize.DEFAULT_HEIGHT),
            GestureDetector(
              onTap: () async{
                isLoadingSendBack=true;
                setState(() {

                });
                TenderFormModel tenderForMmodel = TenderFormModel(
                    name: widget.tender.name,
                    progressStatus: 'Completed',
                    description: widget.tender.description,
                    tenderType: widget.tender.tenderType,
                    assignedTo: 'Initiator',
                    commentByHoT: '',
                    approvalStatus: 'Finished',
                    tenderFileDownloadUrl: widget.tender.tenderFileDownloadUrl,
                    tenderFileName: widget.tender.tenderFileName
                );

                await FirebaseFirestore.instance
                    .collection('userform')
                    .doc(widget.docId)
                    .update(tenderForMmodel.toJson());
                Fluttertoast.showToast(msg: 'Sent Back Successfully');
                isLoadingSendBack=false;
                setState(() {

                });
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => IntiatorScreen()));
              },
              child: FittedBox(
                child: isLoadingSendBack?const Center(child: SizedBox(height:15,width:15,child: CircularProgressIndicator())):RoundedContainer(
                    fontColor: Colors.white,
                    color: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                    title: 'Send Back'),
              ),
            ),
            const SizedBox(height: AppSize.DEFAULT_HEIGHT),
            Container(
              padding: const EdgeInsets.only(top: 4, left: 4),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: AppColors.LIME_GREEN.withOpacity(0.9),
                    blurRadius: 0.5,
                    spreadRadius: 0.5)
              ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  TextField(
                    maxLines: 10,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Send back comments',
                      contentPadding: EdgeInsets.zero,
                      hintStyle: TextStyle(
                          color: Colors.grey..shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ]),
        ),
      ),
    );
  }
}
