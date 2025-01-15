import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:flutter/material.dart';
// import 'package:night_nurse/global/global.dart';

class NotificationsBtn extends StatelessWidget {
  const NotificationsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(
          Icons.notifications_outlined,
          size: 30,
        ),
        Positioned(
          right: 6,
          top: 2,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(fAuth.currentUser?.email ?? '')
                  .collection("notifications")
                  .where("checked", isEqualTo: "1")
                  .orderBy("date", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(),
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                      querySnapshot.docs;
                  if (listQueryDocumentSnapshot.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(6)),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        (listQueryDocumentSnapshot.length > 9)
                            ? "9+"
                            : listQueryDocumentSnapshot.length.toString(),
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              }),
        )
      ],
    );
  }
}
