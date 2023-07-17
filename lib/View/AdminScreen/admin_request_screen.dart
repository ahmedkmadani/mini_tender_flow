import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminRequestScreen extends StatefulWidget {
  @override
  _AdminRequestScreenState createState() => _AdminRequestScreenState();
}

class _AdminRequestScreenState extends State<AdminRequestScreen> {
  CollectionReference _requestsCollection =
      FirebaseFirestore.instance.collection('accountRequests');
  String? status;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   _requestsCollection.get().then((value) {
  //     for (var doc in value.docs) {
  //      status= doc['status'];
  //       debugPrint();
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _requestsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final requests = snapshot.data!.docs;
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 18),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];

                final requestId = request['id'];
                final statusId = request['statusId'];
                final userName = request['name'];
                final userEmail = request['email'];

                return Container(
                  margin: EdgeInsets.only(top: 14),
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.cyanAccent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(userName),
                        subtitle: Text(userEmail),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () async {
                              // _updateRequestStatus(requestId, true);
                              // await FirebaseFirestore.instance
                              //     .collection('status')
                              //     .doc(statusId)
                              //     .update({'status': 'approved'});
                              var collection = await FirebaseFirestore.instance
                                  .collection('accountRequests')
                                  .doc(requestId)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('accountRequests')
                                  .doc(statusId)
                                  .update({'status': 'approved'});
                            },
                            child: Text('Approve'),
                          ),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent),
                            onPressed: () async {
                              // _updateRequestStatus(requestId, false);

                              var collection = await FirebaseFirestore.instance
                                  .collection('accountRequests')
                                  .doc(requestId)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('accountRequests')
                                  .doc(statusId)
                                  .update({'status': 'rejected'});
                              // var collection = await FirebaseFirestore.instance
                              //     .collection('accountRequests')
                              //     .get();
                              // for (var doc in collection.docs) {
                              //   await doc.reference.delete();
                              // }
                            },
                            child: Text('Reject'),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
