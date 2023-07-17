import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mni_tender_flow/Model/tender_model.dart';
// import 'package:open_file/open_file.dart';

import '../../../common/widgets/rounded_container.dart';
import '../../../config/AppColors.dart';
import '../../../config/AppConstants.dart';
import '../HoT/HomeScreen/home_screen.dart';

class IntiatorScreen extends StatefulWidget {
  const IntiatorScreen();

  @override
  State<IntiatorScreen> createState() => _IntiatorScreenState();
}

class _IntiatorScreenState extends State<IntiatorScreen> {


  var firestore = FirebaseFirestore.instance.collection('userform');

  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Initiator Screen',
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
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 7),
          padding: const EdgeInsets.all(12),
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: AppColors.LIME_GREEN.withOpacity(0.9),
                    blurRadius: 0.5,
                    spreadRadius: 0.5)
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: firestore.where(TenderFormFields.progressStatus, isEqualTo: 'Completed'
                  ).where(TenderFormFields.assignedTo,isEqualTo: 'Initiator').snapshots(),
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
                            'Following ${snapshot.data!.docs.length} tasks are sent back'),
                        const SizedBox(
                          height: AppSize.DEFAULT_HEIGHT,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*.4,
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
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder:
                                            //         (context)=>TopManagmentTenderScreen(tender: tender,docId: snapshot.data!.docs[index].id,)));
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
              const SizedBox(height: AppSize.DEFAULT_HEIGHT),
              FittedBox(
                child: InkWell(
                  onTap: () {
                    _openDialog(context);
                  },
                  child: RoundedContainer(
                      width: 110,
                      fontColor: Colors.white,
                      color: Colors.greenAccent,
                      padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                      title: 'Upload Form'),
                ),
              ),
              const SizedBox(height: AppSize.DEFAULT_HEIGHT),
              FittedBox(
                child: RoundedContainer(
                    width: 110,
                    fontColor: Colors.white,
                    color: Colors.redAccent,
                    padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                    title: 'Review Form'),
              ),
              const SizedBox(height: AppSize.DEFAULT_HEIGHT),
              FittedBox(
                child: RoundedContainer(
                    width: 110,
                    fontColor: Colors.white,
                    color: Colors.purple,
                    padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreenHot()));
                },
                child: FittedBox(
                  child: RoundedContainer(
                      width: 110,
                      color: Colors.green,
                      fontColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(2, 2, 5.5, 2),
                      title: 'Send Request'),
                ),
              ),
              const SizedBox(height: AppSize.DEFAULT_HEIGHT),
              Container(
                padding: EdgeInsets.only(top: 4, left: 4),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.amber.withOpacity(0.9),
                          blurRadius: 0.5,
                          spreadRadius: 0.5)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    TextField(
                      maxLines: 7,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: 'Comments:',
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
            ],
          ),
        ),
      ),
    );
  }
}

void _openDialog(BuildContext context) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tenderTypeController = TextEditingController();

  FirebaseStorage firebaseStorage=FirebaseStorage.instance;

  String? tenderFilePath;
  String? tenderFileName;

  FilePickerResult? tenderFile;
  void _openFile(PlatformFile file) {
    // OpenFile.open(file.path);
  }
  _pickFile() async {

    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    tenderFile = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (tenderFile == null) return null;

    // we get the file from result object
    final file = tenderFile!.files.first;


    tenderFilePath=file.path;
    tenderFileName=file.name;

    _openFile(file);
    return file.path;
  }

  bool isLoading=false;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submit a Tender'),
          content: StatefulBuilder(
            builder: (context,StateSetter setState) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _tenderTypeController,
                        decoration: const InputDecoration(labelText: 'Tender Type'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a tender type';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5,),
                      InkWell(
                        onTap: (){
                          // pickImage(context);
                          _pickFile();
                        },
                        child: Container(
                          height: 30,
                          width: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Text("Select File"),
                        ),
                      ),

                      SizedBox(
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: !isLoading,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            ElevatedButton(
                              onPressed: ()async {
                                if(_tenderTypeController.text.isEmpty ||
                                    _nameController.text.isEmpty ||
                                    _descriptionController.text.isEmpty
                                ){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All fields are required")));
                                }else if(tenderFileName==null){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Document is required")));
                                }else if(!tenderFileName!.contains('pdf')){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Document Should Be PDF")));

                                }else{
                                  isLoading=true;
                                  setState((){});
                                  final root=firebaseStorage.ref();
                                  ///File directory
                                  // While the file names are the same, the references point to different files

                                  final  fileRef=root.child("$tenderFileName");
                                  final fileFulRef=root.child("tender_files/$tenderFileName");
                                  File file=File(tenderFilePath!);
                                  assert(tenderFileName == fileFulRef.name);
                                  assert(tenderFilePath != fileFulRef.fullPath);
                                  await fileFulRef.putFile(file);

                                  final downloadUrl=await fileFulRef.getDownloadURL();
                                  TenderFormModel tenderForMmodel = TenderFormModel(
                                      name: _nameController.text,
                                      progressStatus: 'Pending',
                                      description: _descriptionController.text,
                                      tenderType: _tenderTypeController.text,
                                      assignedTo: 'XYZ',
                                      commentByHoT: '',
                                      approvalStatus: '',
                                      tenderFileDownloadUrl: downloadUrl,
                                    tenderFileName: tenderFileName!
                                  );
                                  String docId=DateTime.now().toString();
                                  FirebaseFirestore.instance
                                      .collection('userform')
                                      .doc(docId)
                                      .set(tenderForMmodel.toJson());
                                  Fluttertoast.showToast(msg: 'Submitted');
                                  isLoading=true;
                                  setState((){});
                                  Navigator.pop(context);
                                }

                              },
                              child: isLoading?const Center(child: SizedBox(height:20,width:20,child: CircularProgressIndicator(color: Colors.blue,))):const Text('Submit'),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              );
            }
          ),
        );
      });
}
