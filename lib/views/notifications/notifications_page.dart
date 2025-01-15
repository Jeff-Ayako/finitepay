
// import 'package:avatar_glow/avatar_glow.dart';
import 'package:finitepay/global/global_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:night_nurse/constants/controllers.dart';
// import 'package:night_nurse/controllers/initialize_controllers.dart';
// import 'package:night_nurse/global/global.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late DocumentReference notifRef;
  final auth = FirebaseAuth.instance;

  String timeAgo(uploadTime) {
    final now = DateTime.now();
    final Duration difference = now.difference(uploadTime);

    if (difference.inDays >= 365) {
      return '${difference.inDays ~/ 365} ${difference.inDays ~/ 365 == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("TEST!!"),
          content: const Text("Checking 1 2 3!"),
          actions: [
            MaterialButton(
              child: const Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    notifRef = FirebaseFirestore.instance
        .collection('users')
        .doc(fAuth.currentUser!.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Scaffold(
          // appBar: AppBar(
          //   title: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Obx(
          //         () => const CircleAvatar(
          //           radius: 20,
          //           child: Icon(
          //             Icons.person,
          //             size: 15,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              ListView(
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Notifications",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 200,
                              child: StreamBuilder(
                                  stream: notifRef
                                      .collection("notifications")
                                      .orderBy("date", descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      QuerySnapshot querySnapshot =
                                          snapshot.data!;
                                      List<QueryDocumentSnapshot>
                                          listQueryDocumentSnapshot =
                                          querySnapshot.docs;
                                      if (listQueryDocumentSnapshot
                                          .isNotEmpty) {
                                        return ListView.builder(
                                          itemCount:
                                              listQueryDocumentSnapshot.length,
                                          itemBuilder: (context, index) {
                                            final notif =
                                                listQueryDocumentSnapshot[
                                                    index];
                                            return ExpansionTile(
                                              onExpansionChanged: (value) {
                                                if (value &&
                                                    (notif['checked'] == "1")) {
                                                  Map<String, String> upDate = {
                                                    'checked': "0",
                                                  };
                                                  notifRef
                                                      .collection(
                                                          "notifications")
                                                      .doc(notif.id)
                                                      .update(upDate);
                                                }
                                              },
                                              leading: Stack(
                                                children: [
                                                  Icon(
                                                    Icons.notifications,
                                                    color: (notif['checked'] ==
                                                            "1")
                                                        ? const Color.fromARGB(
                                                            255, 141, 4, 88)
                                                        : null,
                                                    size: 30,
                                                  ),
                                                  Positioned(
                                                      right: 0,
                                                      top: 2,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        decoration: BoxDecoration(
                                                            color: (notif[
                                                                        'checked'] ==
                                                                    "1")
                                                                ? const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    141,
                                                                    4,
                                                                    88)
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                        constraints:
                                                            const BoxConstraints(
                                                          minWidth: 14,
                                                          minHeight: 14,
                                                        ),
                                                        child: Text(
                                                          (notif['checked'] ==
                                                                  "1")
                                                              ? "NEW"
                                                              : "",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              title: Text(
                                                notif['title'],
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                    fontWeight:
                                                        (notif['checked'] ==
                                                                "1")
                                                            ? FontWeight.bold
                                                            : null),
                                              ),
                                              subtitle: Text(
                                                timeAgo(
                                                    notif['datenow'].toDate()),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color,
                                                    fontWeight:
                                                        (notif['checked'] ==
                                                                "1")
                                                            ? FontWeight.bold
                                                            : null),
                                              ),
                                              children: [
                                                SizedBox(
                                                  height: (notif['type'] ==
                                                          "Notification")
                                                      ? 400
                                                      : 200,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child: ListView(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 8.0,
                                                                  left: 8),
                                                          child: Text(
                                                            notif['title'],
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 8.0,
                                                                  left: 8,
                                                                  right: 8,
                                                                  bottom: 8),
                                                          child: Text(
                                                            notif['body'],
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        if (notif['title'] ==
                                                            "Welcome to Night Nurse")
                                                          SizedBox(
                                                            height: 200,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Center(
                                                                child: Image.asset(
                                                                    color: const Color(
                                                                        0xFF5A31F4),
                                                                    "assets/fwhitelogo.png")),
                                                          ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 4.0,
                                                                  left: 8),
                                                          child: Text(
                                                            timeAgo(
                                                                notif['datenow']
                                                                    .toDate()),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        return const Center(
                                            child: Text(
                                          "You don't have any Notification currently",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 20),
                                        ));
                                      }
                                    } else {
                                      return const Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          Text(
                                            'No Internet connection,',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ));
                                    }
                                  }),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0, top: 20.0),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: IconButton(
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //       icon: const Icon(Icons.arrow_back_ios),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
