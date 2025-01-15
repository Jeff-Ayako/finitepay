// // ignore_for_file: unused_local_variable, invalid_use_of_protected_member, must_be_immutable

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:night_nurse/components/chat_widget.dart';
// import 'package:night_nurse/components/pop_up_btn.dart';
// // import 'package:night_nurse/constants/controllers.dart';
// import 'package:night_nurse/controllers/mode_controller.dart';
// import 'package:night_nurse/controllers/nurse_services.dart';
// import 'package:night_nurse/global/global.dart';
// import 'package:night_nurse/models/allclassesconstr.dart';
// // import 'package:night_nurse/models/allclassesconstr.dart';
// import 'package:night_nurse/views/chats/individual_chat_page.dart';

// class HomeChatPage extends StatelessWidget {
//    HomeChatPage({super.key, 
  
//   required this.userDetails
  
//   });

//   UserDetails userDetails;

//   @override
//   Widget build(BuildContext context) {
//     // final UserDetails userDetails = Get.arguments['userDetails'];
//     final ModeThemes modeThemes = Get.find<ModeThemes>();
//     double width = MediaQuery.of(context).size.width;

//     final Stream<QuerySnapshot> chatStream = FirebaseFirestore.instance
//         .collection('users')
//         .doc(fAuth.currentUser?.email ?? '')
//         .collection('chats')
//         .orderBy('Time')
//         .limit(20)
//         .snapshots();

//     NurseServices nurseServices = Get.put(
//       NurseServices(),
//     );

//     // NurseServices nurseServices = Get.find<NurseServices>();

//     return Row(
//       children: [
//         Expanded(
//           child: Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 'Chats',
//                 style: TextStyle(color: Theme.of(context).iconTheme.color),
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.camera_alt_outlined,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => modeThemes.toggleMode(),
//                   icon: const Icon(
//                     Icons.light_mode_outlined,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.search,
//                   ),
//                 ),
//                 const PopUpBtn(),
//                 // IconButton(
//                 //   onPressed: () {},
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
//               child: Scrollbar(
//                   child: StreamBuilder<QuerySnapshot>(
//                 stream: chatStream,
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasError) {
//                     return const Center(
//                       child: Text('Something went wrong'),
//                     );
//                   }

//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: Text("Loading"),
//                     );
//                   }

//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 100.0),
//                     child: snapshot.data!.docs.isEmpty
//                         ? const Center(
//                             child: Text("You don't have Messages Yet"),
//                           )
//                         : ListView(
//                             // reverse: true,
//                             physics: const BouncingScrollPhysics(),
//                             children: snapshot.data!.docs.reversed
//                                 .map((DocumentSnapshot document) {
//                               Map<String, dynamic> data =
//                                   document.data()! as Map<String, dynamic>;
//                               return InkWell(
//                                 onTap: () {
//                                   print(fAuth.currentUser?.email ?? '');

//                                   print(data['SenderId']);

//                                   // print(fAuth.currentUser?.email ?? '');

//                                   // print(fAuth.currentUser?.email ?? '');

//                                   nurseServices.openChat.value.receiverEmail =
//                                       data['SenderId'] == fAuth.currentUser!.uid
//                                           ? data['ReceiverEmail']
//                                           : data['SenderEmail'];
//                                   nurseServices.openChat.value.receiverName =
//                                       data['SenderId'] == fAuth.currentUser!.uid
//                                           ? data['ReceiverName']
//                                           : data['SenderName'];
//                                   nurseServices
//                                           .openChat.value.receiverProfileImg =
//                                       data['SenderId'] == fAuth.currentUser!.uid
//                                           ? data['ReceiverImage']
//                                           : data['SenderImage'];
//                                   nurseServices.openChat.value.receiveruid =
//                                       data['SenderId'] == fAuth.currentUser!.uid
//                                           ? data['ReceiverId']
//                                           : data['SenderId'];

//                                   nurseServices.openChat.refresh();
//                                   GetPlatform.isMobile == false
//                                       ? null
//                                       : Get.to(
//                                           () => IndividualChatPage(
//                                             // userDetails: userDetails,
//                                             receiverEmail: data['SenderId'] ==
//                                                     fAuth.currentUser!.uid
//                                                 ? data['ReceiverEmail']
//                                                 : data['SenderEmail'],

//                                             receiveruid: data['SenderId'] ==
//                                                     fAuth.currentUser!.uid
//                                                 ? data['ReceiverId']
//                                                 : data['SenderId'],

//                                             receiverName: data['SenderId'] ==
//                                                     fAuth.currentUser!.uid
//                                                 ? data['ReceiverName']
//                                                 : data['SenderName'],

//                                             receiverProfileImg:
//                                                 data['SenderId'] ==
//                                                         fAuth.currentUser!.uid
//                                                     ? data['ReceiverImage']
//                                                     : data['SenderImage'],
//                                           ),
//                                         );
//                                 },
//                                 child: ChatWidget(
//                                   txt: data['Message'],
//                                   msg: data['Message'],
//                                   time: data['Time'],
//                                   personName:
//                                       data['SenderId'] == fAuth.currentUser!.uid
//                                           ? data['ReceiverName']
//                                           : data['SenderName'],
//                                   profileImg:
//                                       data['SenderId'] == fAuth.currentUser!.uid
//                                           ? data['ReceiverImage']
//                                           : data['SenderImage'],
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                   );
//                 },
//               )),
//             ),
//           ),
//         ),
//         GetPlatform.isMobile || width < 800
//             ? Container()
//             : Expanded(
//                 flex: 2,
//                 child: Obx(
//                   () => Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: IndividualChatPage(
//                       receiverEmail: nurseServices.openChat.value.receiverEmail,
//                       receiveruid: nurseServices.openChat.value.receiveruid,
//                       receiverName: nurseServices.openChat.value.receiverName,
//                       receiverProfileImg:
//                           nurseServices.openChat.value.receiverProfileImg,
//                       // userDetails: UserDetails(),
//                     ),
//                   ),
//                 ),
//               )
//       ],
//     );
//   }
// }