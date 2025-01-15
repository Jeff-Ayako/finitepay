// // ignore_for_file: must_be_immutable, unnecessary_string_interpolations, prefer_const_constructors

// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finitepay/components/chats_widget/chat_attach.dart';
// import 'package:finitepay/controllers/init_controllers.dart';
// import 'package:finitepay/global/global_variables.dart';
// import 'package:finitepay/views/chats/inputs.dart';
// import 'package:finitepay/views/chats/own_msg.dart';
// import 'package:finitepay/views/chats/pop_up_btn.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// // import 'package:night_nurse/chats_widget/chat_attach.dart';
// // import 'package:night_nurse/components/inputs.dart';
// // import 'package:night_nurse/components/own_msg.dart';
// // import 'package:night_nurse/components/pop_up_btn.dart';
// // import 'package:night_nurse/constants/controllers.dart';
// // import 'package:night_nurse/controllers/initialize_controllers.dart';
// // import 'package:night_nurse/global/global.dart';
// import 'package:url_launcher/url_launcher.dart';

// class IndividualChatPage extends StatelessWidget {
//   IndividualChatPage({
//     super.key,
//     required this.receiverEmail,
//     required this.receiverName,
//     required this.receiverProfileImg,
//     required this.receiveruid,

//     //  this.userDetails
//   });

//   // UserDetails? userDetails;

//   String receiveruid;
//   String receiverProfileImg;
//   String receiverName;
//   String receiverEmail;

//   @override
//   Widget build(BuildContext context) {
//     List<String> ids = [receiveruid, fAuth.currentUser?.uid ?? ''];
//     ids.sort();
//     String chatroomId = ids.join('_');
//     final Stream<QuerySnapshot> chatStream = FirebaseFirestore.instance
//         .collection('chats')
//         .doc(chatroomId)
//         .collection('Messages')
//         // .where('SenderId', isEqualTo: receiveruid)
//         // .where('ReceiverId', isEqualTo: fAuth.currentUser?.uid ?? '')
//         // .where('SenderId', isEqualTo: fAuth.currentUser?.uid ?? '')
//         // .where('ReceiverId', isEqualTo: receiveruid)
//         .orderBy('createdAt', descending: false)
//         .limit(20)
//         .snapshots();
//     TextEditingController controller = TextEditingController();
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (constraints.maxWidth <= 500) {
//           return Scaffold(
//             // backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               title: Row(
//                 children: [
//                   CircleAvatar(
//                     child: ClipOval(
//                       child: Image.memory(
//                         base64Decode(
//                           receiverProfileImg,
//                         ),
//                         width: Get.width,
//                         height: Get.height,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Text(
//                       '$receiverName',
//                       style: TextStyle(overflow: TextOverflow.ellipsis),
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.video_call_outlined,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     final url = Uri.parse(
//                         'tel: ${allController.numbertoCall.value.toString()}');
//                     if (await canLaunchUrl(url)) {
//                       await launchUrl(url);
//                     } else {
//                       throw 'could not launch $url';
//                     }
//                   },
//                   icon: const Icon(
//                     Icons.call,
//                   ),
//                 ),
//                 PopUpBtn()
//                 // IconButton(
//                 //   onPressed: () => ,
//                 //   icon: const Icon(
//                 //     Icons.more_vert,
//                 //   ),
//                 // ),
//               ],
//             ),
//             body: Container(
//               margin: const EdgeInsets.only(top: 40),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(20),
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   // Align(
//                   //   alignment: Alignment.center,
//                   //   child: Image.asset(
//                   //     'assets/bg.jpg',
//                   //     width: Get.width,
//                   //     height: Get.height,
//                   //     fit: BoxFit.cover,
//                   //   ),
//                   // ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Scrollbar(
//                         child: StreamBuilder<QuerySnapshot>(
//                       stream: chatStream,
//                       builder: (BuildContext context,
//                           AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (snapshot.hasError) {
//                           return Text('Something went wrong');
//                         }

//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Text("Loading");
//                         }

//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 100.0),
//                           child: snapshot.data!.docs.isEmpty
//                               ? Center(
//                                   child: Text("You don't have Messages Yet"),
//                                 )
//                               : ListView(
//                                   reverse: true,
//                                   physics: BouncingScrollPhysics(),
//                                   children: snapshot.data!.docs.reversed
//                                       .map((DocumentSnapshot document) {
//                                     Map<String, dynamic> data = document.data()!
//                                         as Map<String, dynamic>;
//                                     return OwenMessageCard(
//                                       imgLink: data['FileLink'],
//                                       senderId: data['SenderId'],
//                                       inputmessage: data['Message'],
//                                       time: data['Time'],
//                                     );
//                                   }).toList(),
//                                 ),
//                         );
//                       },
//                     )),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Obx(
//                       () => Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child: maincontroller.fileLink.toString() == ''
//                                 ? Container()
//                                 : Image.network(
//                                     maincontroller.fileLink.toString(),
//                                   ),
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Inputs(
//                                   controller: controller,
//                                   hint: 'Type your Message',
//                                   Icon: GestureDetector(
//                                     onTap: () => showModalBottomSheet(
//                                       backgroundColor: Colors.transparent,
//                                       context: context,
//                                       builder: (builder) => bottomSheet(),
//                                     ),
//                                     child: Icon(
//                                       Icons.attach_file,
//                                       color: Theme.of(context).iconTheme.color,
//                                     ),
//                                   ),
//                                   // IconButton(
//                                   //   onPressed: () {},
//                                   //   icon:
//                                   // ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 2,
//                               ),
//                               FloatingActionButton(
//                                 backgroundColor: Theme.of(context).cardColor,
//                                 onPressed: () {
//                                   if (controller.text.isEmpty) {
//                                     Get.snackbar('Cannot be Empty',
//                                         'Kindly Type Something');
//                                   } else {
//                                     FirebaseFirestore.instance
//                                         .collection('users')
//                                         .doc(fAuth.currentUser?.email ?? '')
//                                         .collection('chats')
//                                         .doc(receiveruid)
//                                         .set({
//                                       //     'ReceiverName':receiverName,
//                                       //     'ReceiverImg':userDetails?.profileImage??'',
//                                       //     'ReceiverUid':userDetails?.uid??'',
//                                       // 'Time': DateFormat('KK:mm a').format(
//                                       //   DateTime.now(),
//                                       // ),
//                                       'SenderId': fAuth.currentUser?.uid ?? '',
//                                       'FileType': allController.filetype.value
//                                           .toString(),
//                                       'FileLink':
//                                           maincontroller.fileLink.toString(),
//                                       'isRead': false,
//                                       'ReceiverId': receiveruid,
//                                       'Message': controller.text.toString(),
//                                       'createdAt': DateTime.now(),
//                                       'SenderName': allController
//                                           .userDetails.value.fullname,
//                                       'ReceiverName': receiverName,
//                                       'ReceiverEmail': receiverEmail,
//                                       'SenderEmail':
//                                           fAuth.currentUser?.email ?? '',
//                                       'SenderImage': allController
//                                           .userDetails.value.profileImage,
//                                       'ReceiverImage': receiverProfileImg,
//                                       'Time': DateFormat('KK:mm a').format(
//                                         DateTime.now(),
//                                       ),
//                                     }).then((value) {
//                                       maincontroller.fileLink.value = '';
//                                     });

//                                     FirebaseFirestore.instance
//                                         .collection('users')
//                                         .doc(receiverEmail)
//                                         .collection('chats')
//                                         .doc(fAuth.currentUser?.uid ?? '')
//                                         .set({
//                                       'SenderId': fAuth.currentUser?.uid ?? '',
//                                       'SenderEmail':
//                                           fAuth.currentUser?.email ?? '',
//                                       'FileType': allController.filetype.value
//                                           .toString(),
//                                       'FileLink':
//                                           maincontroller.fileLink.toString(),
//                                       'isRead': false,
//                                       'ReceiverId': receiveruid,
//                                       'Message': controller.text.toString(),
//                                       'ReceiverEmail': receiverEmail,
//                                       'createdAt': DateTime.now(),
//                                       'SenderName': allController
//                                           .userDetails.value.fullname,
//                                       'ReceiverName': receiverName,
//                                       'SenderImage': allController
//                                           .userDetails.value.profileImage,
//                                       'ReceiverImage': receiverProfileImg,
//                                       'Time': DateFormat('KK:mm a').format(
//                                         DateTime.now(),
//                                       ),
//                                     }).then((value) {
//                                       maincontroller.fileLink.value = '';
//                                     });

//                                     FirebaseFirestore.instance
//                                         .collection('chats')
//                                         .doc(chatroomId)
//                                         .collection('Messages')
//                                         .doc()
//                                         .set({
//                                       'SenderId': fAuth.currentUser?.uid ?? '',
//                                       'FileType': allController.filetype.value
//                                           .toString(),
//                                       'FileLink':
//                                           maincontroller.fileLink.toString(),
//                                       'isRead': false,
//                                       'ReceiverId': receiveruid,
//                                       'Message': controller.text.toString(),
//                                       'createdAt': DateTime.now(),
//                                       'SenderImage': allController
//                                           .userDetails.value.profileImage,
//                                       'ReceiverImage': receiverProfileImg,
//                                       'Time': DateFormat('KK:mm a').format(
//                                         DateTime.now(),
//                                       ),
//                                     }).then((value) {
//                                       maincontroller.fileLink.value = '';
//                                     });
//                                     controller.clear();
//                                   }
//                                 },
//                                 child: Icon(
//                                   Icons.send,
//                                   color: Theme.of(context).iconTheme.color,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else if (constraints.maxWidth < 1100) {
//           return Scaffold(
//             // backgroundColor: Colors.transparent,
//             appBar: AppBar(
//               title: Row(
//                 children: [
//                   CircleAvatar(
//                     child: ClipOval(
//                       child: Image.memory(
//                         base64Decode(
//                           receiverProfileImg,
//                         ),
//                         width: Get.width,
//                         height: Get.height,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Text(
//                       '$receiverName',
//                       style: TextStyle(overflow: TextOverflow.ellipsis),
//                     ),
//                   ),
//                 ],
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.video_call_outlined,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.call,
//                   ),
//                 ),
//                 PopUpBtn()
//                 // IconButton(
//                 //   onPressed: () => ,
//                 //   icon: const Icon(
//                 //     Icons.more_vert,
//                 //   ),
//                 // ),
//               ],
//             ),
//             body: Container(
//               margin: const EdgeInsets.only(top: 40),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(20),
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   // Align(
//                   //   alignment: Alignment.center,
//                   //   child: Image.asset(
//                   //     'assets/bg.jpg',
//                   //     width: Get.width,
//                   //     height: Get.height,
//                   //     fit: BoxFit.cover,
//                   //   ),
//                   // ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Scrollbar(
//                         child: StreamBuilder<QuerySnapshot>(
//                       stream: chatStream,
//                       builder: (BuildContext context,
//                           AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (snapshot.hasError) {
//                           return Text('Something went wrong');
//                         }

//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Text("Loading");
//                         }

//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 100.0),
//                           child: snapshot.data!.docs.isEmpty
//                               ? Center(
//                                   child: Text("You don't have Messages Yet"),
//                                 )
//                               : ListView(
//                                   reverse: true,
//                                   physics: BouncingScrollPhysics(),
//                                   children: snapshot.data!.docs.reversed
//                                       .map((DocumentSnapshot document) {
//                                     Map<String, dynamic> data = document.data()!
//                                         as Map<String, dynamic>;
//                                     return OwenMessageCard(
//                                       imgLink: data['FileLink'],
//                                       senderId: data['SenderId'],
//                                       inputmessage: data['Message'],
//                                       time: data['Time'],
//                                     );
//                                   }).toList(),
//                                 ),
//                         );
//                       },
//                     )),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Obx(
//                       () => Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child: maincontroller.fileLink.toString() == ''
//                                 ? Container()
//                                 : Image.network(
//                                     maincontroller.fileLink.toString(),
//                                   ),
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Inputs(
//                                   controller: controller,
//                                   hint: 'Type your Message',
//                                   Icon: GestureDetector(
//                                     onTap: () => showModalBottomSheet(
//                                       backgroundColor: Colors.transparent,
//                                       context: context,
//                                       builder: (builder) => bottomSheet(),
//                                     ),
//                                     child: Icon(
//                                       Icons.attach_file,
//                                       color: Theme.of(context).iconTheme.color,
//                                     ),
//                                   ),
//                                   // IconButton(
//                                   //   onPressed: () {},
//                                   //   icon:
//                                   // ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 2,
//                               ),
//                               FloatingActionButton(
//                                 backgroundColor: Theme.of(context).cardColor,
//                                 onPressed: () {
//                                   if (controller.text.isEmpty) {
//                                     Get.snackbar('Cannot be Empty',
//                                         'Kindly Type Something');
//                                   } else {
//                                     FirebaseFirestore.instance
//                                         .collection('users')
//                                         .doc(fAuth.currentUser?.email ?? '')
//                                         .collection('chats')
//                                         .doc(receiveruid)
//                                         .set({
//                                       //     'ReceiverName':receiverName,
//                                       //     'ReceiverImg':userDetails?.profileImage??'',
//                                       //     'ReceiverUid':userDetails?.uid??'',
//                                       // 'Time': DateFormat('KK:mm a').format(
//                                       //   DateTime.now(),
//                                       // ),
//                                       'SenderId': fAuth.currentUser?.uid ?? '',
//                                       'FileType': allController.filetype.value
//                                           .toString(),
//                                       'FileLink':
//                                           maincontroller.fileLink.toString(),
//                                       'isRead': false,
//                                       'ReceiverId': receiveruid,
//                                       'Message': controller.text.toString(),
//                                       'createdAt': DateTime.now(),
//                                       'SenderName': allController
//                                           .userDetails.value.fullname,
//                                       'ReceiverName': receiverName,
//                                       'ReceiverEmail': receiverEmail,
//                                       'SenderEmail':
//                                           fAuth.currentUser?.email ?? '',
//                                       'SenderImage': allController
//                                           .userDetails.value.profileImage,
//                                       'ReceiverImage': receiverProfileImg,
//                                       'Time': DateFormat('KK:mm a').format(
//                                         DateTime.now(),
//                                       ),
//                                     }).then((value) {
//                                       maincontroller.fileLink.value = '';
//                                     });

//                                     FirebaseFirestore.instance
//                                         .collection('users')
//                                         .doc(receiverEmail)
//                                         .collection('chats')
//                                         .doc(fAuth.currentUser?.uid ?? '')
//                                         .set({
//                                       'SenderId': fAuth.currentUser?.uid ?? '',
//                                       'SenderEmail':
//                                           fAuth.currentUser?.email ?? '',
//                                       'FileType': allController.filetype.value
//                                           .toString(),
//                                       'FileLink':
//                                           maincontroller.fileLink.toString(),
//                                       'isRead': false,
//                                       'ReceiverId': receiveruid,
//                                       'Message': controller.text.toString(),
//                                       'ReceiverEmail': receiverEmail,
//                                       'createdAt': DateTime.now(),
//                                       'SenderName': allController
//                                           .userDetails.value.fullname,
//                                       'ReceiverName': receiverName,
//                                       'SenderImage': allController
//                                           .userDetails.value.profileImage,
//                                       'ReceiverImage': receiverProfileImg,
//                                       'Time': DateFormat('KK:mm a').format(
//                                         DateTime.now(),
//                                       ),
//                                     }).then((value) {
//                                       maincontroller.fileLink.value = '';
//                                     });

//                                     FirebaseFirestore.instance
//                                         .collection('chats')
//                                         .doc(chatroomId)
//                                         .collection('Messages')
//                                         .doc()
//                                         .set({
//                                       'SenderId': fAuth.currentUser?.uid ?? '',
//                                       'FileType': allController.filetype.value
//                                           .toString(),
//                                       'FileLink':
//                                           maincontroller.fileLink.toString(),
//                                       'isRead': false,
//                                       'ReceiverId': receiveruid,
//                                       'Message': controller.text.toString(),
//                                       'createdAt': DateTime.now(),
//                                       'SenderImage': allController
//                                           .userDetails.value.profileImage,
//                                       'ReceiverImage': receiverProfileImg,
//                                       'Time': DateFormat('KK:mm a').format(
//                                         DateTime.now(),
//                                       ),
//                                     }).then((value) {
//                                       maincontroller.fileLink.value = '';
//                                     });
//                                     controller.clear();
//                                   }
//                                 },
//                                 child: const Icon(Icons.send),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else {
//           return Scaffold(
//             body: Padding(
//               padding: EdgeInsets.symmetric(horizontal: Get.width / 4),
//               child: Scaffold(
//                 // backgroundColor: Colors.transparent,
//                 appBar: AppBar(
//                   title: Row(
//                     children: [
//                       CircleAvatar(
//                         child: ClipOval(
//                           child: Image.memory(
//                             base64Decode(
//                               receiverProfileImg,
//                             ),
//                             width: Get.width,
//                             height: Get.height,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Text(
//                           '$receiverName',
//                           style: TextStyle(overflow: TextOverflow.ellipsis),
//                         ),
//                       ),
//                     ],
//                   ),
//                   actions: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.video_call_outlined,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.call,
//                       ),
//                     ),
//                     PopUpBtn()
//                     // IconButton(
//                     //   onPressed: () => ,
//                     //   icon: const Icon(
//                     //     Icons.more_vert,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 body: Container(
//                   margin: const EdgeInsets.only(top: 40),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).cardColor,
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(20),
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       // Align(
//                       //   alignment: Alignment.center,
//                       //   child: Image.asset(
//                       //     'assets/bg.jpg',
//                       //     width: Get.width,
//                       //     height: Get.height,
//                       //     fit: BoxFit.cover,
//                       //   ),
//                       // ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Scrollbar(
//                             child: StreamBuilder<QuerySnapshot>(
//                           stream: chatStream,
//                           builder: (BuildContext context,
//                               AsyncSnapshot<QuerySnapshot> snapshot) {
//                             if (snapshot.hasError) {
//                               return Text('Something went wrong');
//                             }

//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Text("Loading");
//                             }

//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 100.0),
//                               child: snapshot.data!.docs.isEmpty
//                                   ? Center(
//                                       child:
//                                           Text("You don't have Messages Yet"),
//                                     )
//                                   : ListView(
//                                       reverse: true,
//                                       physics: BouncingScrollPhysics(),
//                                       children: snapshot.data!.docs.reversed
//                                           .map((DocumentSnapshot document) {
//                                         Map<String, dynamic> data = document
//                                             .data()! as Map<String, dynamic>;
//                                         return OwenMessageCard(
//                                           imgLink: data['FileLink'],
//                                           senderId: data['SenderId'],
//                                           inputmessage: data['Message'],
//                                           time: data['Time'],
//                                         );
//                                       }).toList(),
//                                     ),
//                             );
//                           },
//                         )),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Obx(
//                           () => Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Expanded(
//                                 child: maincontroller.fileLink.toString() == ''
//                                     ? Container()
//                                     : Image.network(
//                                         maincontroller.fileLink.toString(),
//                                       ),
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Inputs(
//                                       controller: controller,
//                                       hint: 'Type your Message',
//                                       Icon: GestureDetector(
//                                         onTap: () => showModalBottomSheet(
//                                           backgroundColor: Colors.transparent,
//                                           context: context,
//                                           builder: (builder) => bottomSheet(),
//                                         ),
//                                         child: Icon(
//                                           Icons.attach_file,
//                                           color:
//                                               Theme.of(context).iconTheme.color,
//                                         ),
//                                       ),
//                                       // IconButton(
//                                       //   onPressed: () {},
//                                       //   icon:
//                                       // ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 2,
//                                   ),
//                                   FloatingActionButton(
//                                     backgroundColor:
//                                         Theme.of(context).cardColor,
//                                     onPressed: () {
//                                       if (controller.text.isEmpty) {
//                                         Get.snackbar('Cannot be Empty',
//                                             'Kindly Type Something');
//                                       } else {
//                                         FirebaseFirestore.instance
//                                             .collection('users')
//                                             .doc(fAuth.currentUser?.email ?? '')
//                                             .collection('chats')
//                                             .doc(receiveruid)
//                                             .set({
//                                           //     'ReceiverName':receiverName,
//                                           //     'ReceiverImg':userDetails?.profileImage??'',
//                                           //     'ReceiverUid':userDetails?.uid??'',
//                                           // 'Time': DateFormat('KK:mm a').format(
//                                           //   DateTime.now(),
//                                           // ),
//                                           'SenderId':
//                                               fAuth.currentUser?.uid ?? '',
//                                           'FileType': allController
//                                               .filetype.value
//                                               .toString(),
//                                           'FileLink': maincontroller.fileLink
//                                               .toString(),
//                                           'isRead': false,
//                                           'ReceiverId': receiveruid,
//                                           'Message': controller.text.toString(),
//                                           'createdAt': DateTime.now(),
//                                           'SenderName': allController
//                                               .userDetails.value.fullname,
//                                           'ReceiverName': receiverName,
//                                           'ReceiverEmail': receiverEmail,
//                                           'SenderEmail':
//                                               fAuth.currentUser?.email ?? '',
//                                           'SenderImage': allController
//                                               .userDetails.value.profileImage,
//                                           'ReceiverImage': receiverProfileImg,
//                                           'Time': DateFormat('KK:mm a').format(
//                                             DateTime.now(),
//                                           ),
//                                         }).then((value) {
//                                           maincontroller.fileLink.value = '';
//                                         });

//                                         FirebaseFirestore.instance
//                                             .collection('users')
//                                             .doc(receiverEmail)
//                                             .collection('chats')
//                                             .doc(fAuth.currentUser?.uid ?? '')
//                                             .set({
//                                           'SenderId':
//                                               fAuth.currentUser?.uid ?? '',
//                                           'SenderEmail':
//                                               fAuth.currentUser?.email ?? '',
//                                           'FileType': allController
//                                               .filetype.value
//                                               .toString(),
//                                           'FileLink': maincontroller.fileLink
//                                               .toString(),
//                                           'isRead': false,
//                                           'ReceiverId': receiveruid,
//                                           'Message': controller.text.toString(),
//                                           'ReceiverEmail': receiverEmail,
//                                           'createdAt': DateTime.now(),
//                                           'SenderName': allController
//                                               .userDetails.value.fullname,
//                                           'ReceiverName': receiverName,
//                                           'SenderImage': allController
//                                               .userDetails.value.profileImage,
//                                           'ReceiverImage': receiverProfileImg,
//                                           'Time': DateFormat('KK:mm a').format(
//                                             DateTime.now(),
//                                           ),
//                                         }).then((value) {
//                                           maincontroller.fileLink.value = '';
//                                         });

//                                         FirebaseFirestore.instance
//                                             .collection('chats')
//                                             .doc(chatroomId)
//                                             .collection('Messages')
//                                             .doc()
//                                             .set({
//                                           'SenderId':
//                                               fAuth.currentUser?.uid ?? '',
//                                           'FileType': maincontroller.filetype.value
//                                               .toString(),
//                                           'FileLink': maincontroller.fileLink
//                                               .toString(),
//                                           'isRead': false,
//                                           'ReceiverId': receiveruid,
//                                           'Message': controller.text.toString(),
//                                           'createdAt': DateTime.now(),
//                                           'SenderImage': allController
//                                               .userDetails.value.profileImage,
//                                           'ReceiverImage': receiverProfileImg,
//                                           'Time': DateFormat('KK:mm a').format(
//                                             DateTime.now(),
//                                           ),
//                                         }).then((value) {
//                                           maincontroller.fileLink.value = '';
//                                         });
//                                         controller.clear();
//                                       }
//                                     },
//                                     child: const Icon(Icons.send),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
