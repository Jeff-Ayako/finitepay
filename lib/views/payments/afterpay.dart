import 'package:finitepay/controllers/init_controllers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRealtimeExample extends StatelessWidget {
  final String documentId = maincontroller.merchantID.value;
  final String collectionPath = 'mpesaData';

  FirestoreRealtimeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Real-time Listener'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(documentId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(child: Text('Error or no data found'));
          }

          // Access the document data
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Center(
            child: Text(
              data.length.toString() == 7.toString()
                  ? 'Loading...'
                  : data['Body']['stkCallback']['ResultDesc'] ==
                          'The service request is processed successfully.'
                      ? 'SUCCESS'
                      : data['Body']['stkCallback']['ResultDesc'],
            ),
          );
        },
      ),
    );
  }
}
