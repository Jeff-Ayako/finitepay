// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:finitepay/global/global_variables.dart';
import 'package:flutter/material.dart';
// import 'package:night_nurse/global/global.dart';
// import 'package:intl/intl.dart';

class OwenMessageCard extends StatefulWidget {
  OwenMessageCard(
      {super.key,
      required this.inputmessage,
      required this.time,
      this.imgLink,
      required this.senderId});
  final String inputmessage;

  String senderId;

  String? imgLink;

  var time;

  @override
  State<OwenMessageCard> createState() => _OwenMessageCardState();
}

class _OwenMessageCardState extends State<OwenMessageCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.senderId == fAuth.currentUser?.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            widget.imgLink.toString() == '' || widget.imgLink == null
                ? Container()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.imgLink.toString(),
                    ),
                  ),
            Card(
              elevation: 1,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              color: widget.senderId == fAuth.currentUser?.uid
                  ? const Color(0xffdcf8c6)
                  : Colors.white,
              // color:  Colors.white,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 60,
                      top: 10,
                      bottom: 20,
                    ),
                    child: Text(
                      widget.inputmessage,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 10,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            widget.time,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        widget.senderId == fAuth.currentUser?.uid
                            ? const Icon(
                                Icons.done_all,
                                size: 20,
                                color: Colors.blue,
                              )
                            : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
