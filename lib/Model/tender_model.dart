import 'package:cloud_firestore/cloud_firestore.dart';

class TenderFormFields{
  static const String tenderName ='tender name';
  static const String description ='tender description';
  static const String tenderType ='tender type';
  static const String progressStatus ='progressStatus';
  static const String assignedTo ='assignedTo';
  static const String commentByHoT='commentByHoT';
  static const String  approvalStatus='approvalStatus';
  static const String tenderFileDownloadUrl='tenderFileDownloadUrl';
  static const String tenderFileName='tenderFileName';

}

class TenderFormModel {
  String name;
  String description;
  String tenderType;
  String progressStatus;
  String assignedTo;
  String commentByHoT;
  String  approvalStatus;
  String tenderFileDownloadUrl;
  String tenderFileName;

  TenderFormModel(
      {required this.name,
      required this.progressStatus,
      required this.description,
      required this.tenderType,
      required this.assignedTo,
        required this.commentByHoT,
        required this.approvalStatus,
        required this.tenderFileDownloadUrl,
        required  this.tenderFileName
      });

  Map<String, dynamic> toJson() {
    return {
      TenderFormFields.tenderName: name,
      TenderFormFields.description: description,
      TenderFormFields.tenderType: tenderType,
      TenderFormFields.progressStatus: progressStatus,
      TenderFormFields.assignedTo:assignedTo,
      TenderFormFields.commentByHoT:commentByHoT,
      TenderFormFields.approvalStatus:approvalStatus,
      TenderFormFields.tenderFileDownloadUrl:tenderFileDownloadUrl,
      TenderFormFields.tenderFileName:tenderFileName
    };
  }

  factory TenderFormModel.fromJson(DocumentSnapshot  json) {
    return TenderFormModel(
      name: json[TenderFormFields.tenderName],
      description: json[TenderFormFields.description],
      tenderType: json[TenderFormFields.tenderType],
        progressStatus:json[TenderFormFields.progressStatus],
      assignedTo:json[TenderFormFields.assignedTo],
      commentByHoT: json[TenderFormFields.commentByHoT],
      approvalStatus: json[TenderFormFields.approvalStatus],
      tenderFileDownloadUrl: json[TenderFormFields.tenderFileDownloadUrl],
      tenderFileName: json[TenderFormFields.tenderFileName]
    );
  }
}
