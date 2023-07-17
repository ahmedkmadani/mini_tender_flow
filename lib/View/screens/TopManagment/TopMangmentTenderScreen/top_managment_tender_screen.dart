import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mni_tender_flow/Model/tender_model.dart';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../common/widgets/rounded_container.dart';
import '../../../../config/AppColors.dart';
import '../../../../config/AppConstants.dart';
import '../../../AdminScreen/admin_request_screen.dart';
import '../../HoT/HomeScreen/home_screen.dart';
import '../TaskStatus/tast_status.dart';

class TopManagmentTenderScreen extends StatefulWidget {
  TenderFormModel tender;
  String  docId;
  TopManagmentTenderScreen({
   required this.tender,
    required this.docId
  });

  @override
  State<TopManagmentTenderScreen> createState() => _TopManagmentTenderScreenState();
}

class _TopManagmentTenderScreenState extends State<TopManagmentTenderScreen> {

  bool isLoadingSendBack=false;
  bool isLoadingApproval=false;
  bool isLoadingDecline=false;
  bool isDownloading=false;
  FirebaseStorage firebase_storage=FirebaseStorage.instance;

  Future<void> downloadFile() async {
    var ref=firebase_storage.ref().child('tender_files/${widget.tender.tenderFileName}');

    print(ref);
    final Directory appDocDir = Directory('/storage/emulated/0/Download/TenderFlow');
    if(await appDocDir.exists()){
      final String appDocPath = appDocDir.path;
      final File tempFile = File(appDocPath + '/' + 'TenderDoc ${widget.tender.tenderFileName}');
      try {
        await ref.writeToFile(tempFile);
        await tempFile.create();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Download Successfull")));

      } catch (e){
        print(e);
      }
    }else{
      Directory newDirectory=await appDocDir.create(recursive: true);
      String newDirPath=newDirectory.path;
      final String appDocPath = appDocDir.path;

      final File tempFile = File(newDirPath + '/' + 'TenderDoc ${widget.tender.tenderFileName}');
      try {
        await ref.writeToFile(tempFile);
        await tempFile.create();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Downloaded Successfully")));

      } catch (e){
        print(e);
      }

    }

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Top management Tender Screen',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminRequestScreen()));
            },
            child: const Icon(
              Icons.add,
              size: 28,
            ),
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminRequestScreen()));
                  },
                  child: const Icon(
                    Icons.add,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            RoundedContainer(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 0.5,
                      spreadRadius: 0.5)
                ],
                color: Colors.white,
                margin: EdgeInsets.only(right: 3),
                title: widget.tender.name),
            const SizedBox(
              height: AppSize.DEFAULT_HEIGHT,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              content:SfPdfViewer.network(
                                  widget.tender.tenderFileDownloadUrl,
                                  enableDoubleTapZooming: false)
                            );
                          });
                    },
                    child: RoundedContainer(
                        color: Colors.green,
                        fontColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(5, 2, 5.5, 2),
                        title: 'View Attachment'),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: InkWell(
                    onTap: ()async{
                      isDownloading=true;
                      setState(() {

                      });
                      await downloadFile();
                      isDownloading=false;
                      setState(() {

                      });
                    },
                    child: isDownloading?const Center(child: SizedBox(height:15,width:15,child: CircularProgressIndicator())):RoundedContainer(
                        color: Colors.red,
                        fontColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(5, 2, 5.5, 2),
                        title: 'Download Attachment'),
                  ),
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
                      hintText: 'Description:\n${widget.tender.description}',
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
                      hintText: 'Comments by HoT:\n${widget.tender.commentByHoT}',
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
                    assignedTo: 'HoT',
                    commentByHoT: '',
                    approvalStatus: 'Approved',
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
                //     MaterialPageRoute(builder: (context) => HomeScreenHot()));
              },
              child: FittedBox(
                child: isLoadingSendBack?const Center(child: CircularProgressIndicator()):RoundedContainer(
                    fontColor: Colors.white,
                    color: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                    title: 'Send Back'),
              ),
            ),
            const SizedBox(height: AppSize.DEFAULT_HEIGHT),
            GestureDetector(
              onTap: () async{
                isLoadingApproval=true;
                setState(() {

                });
                TenderFormModel tenderForMmodel = TenderFormModel(
                    name: widget.tender.name,
                    progressStatus: 'Review',
                    description: widget.tender.description,
                    tenderType: widget.tender.tenderType,
                    assignedTo: 'HoT',
                    commentByHoT: '',
                    approvalStatus: 'Approved',
                  tenderFileDownloadUrl: widget.tender.tenderFileDownloadUrl,
                  tenderFileName: widget.tender.tenderFileName
                );

                await FirebaseFirestore.instance
                    .collection('userform')
                    .doc(widget.docId)
                    .update(tenderForMmodel.toJson());
                Fluttertoast.showToast(msg: 'Approved Successfully');
                isLoadingApproval=false;
                setState(() {

                });
                // Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const TaskStatusScreen()));
              },
              child: FittedBox(
                child: isLoadingApproval?const Center(child: CircularProgressIndicator()):RoundedContainer(
                    width: 110,
                    fontColor: Colors.white,
                    color: Colors.green,
                    padding: const EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                    title: 'Approved to Buy '),
              ),
            ),
            const SizedBox(height: AppSize.DEFAULT_HEIGHT),
            InkWell(
              onTap: () async{
                isLoadingDecline=true;
                setState(() {

                });
                TenderFormModel tenderForMmodel = TenderFormModel(
                    name: widget.tender.name,
                    progressStatus: 'Suspended',
                    description: widget.tender.description,
                    tenderType: widget.tender.tenderType,
                    assignedTo: 'HoT',
                    commentByHoT: '',
                    approvalStatus: 'Declined',
                    tenderFileDownloadUrl: widget.tender.tenderFileDownloadUrl,
                    tenderFileName: widget.tender.tenderFileName
                );

                await FirebaseFirestore.instance
                    .collection('userform')
                    .doc(widget.docId)
                    .update(tenderForMmodel.toJson());
                Fluttertoast.showToast(msg: 'Declined Successfully');
                isLoadingDecline=false;
                setState(() {

                });
                // Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const TaskStatusScreen()));
              },
              child: FittedBox(
                child: isLoadingDecline?const Center(child: CircularProgressIndicator()):RoundedContainer(
                    width: 130,
                    color: Colors.red,
                    fontColor: Colors.white,
                    padding: const EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                    title: 'Not Approved to Buy'),
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
                      hintText:
                          'Comments/Justification for not Approving or Sending back',
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
