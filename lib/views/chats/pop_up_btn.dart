import 'package:flutter/material.dart';

class PopUpBtn extends StatelessWidget {
  const PopUpBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        // Navigator.push(
        //   context,
        //   (MaterialPageRoute(
        //     builder: (context) => StatusPages(),
        //   ))
        // );

        // if (value == 'WallPaper') {
        //   isMap = false;
        //   backWallpaper();
        // } else if (value == 'Locations') {
        //   // isMap = false;

        //   maptypetoggle();
        // }

        // print(value); //if any value is clicked then it will display the value onto the the console
      },
      //here i was building the pop up menu icon to display the following items when clicked
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
            value: 'View Contact',
            child: Text('View Contact'),
          ),
          const PopupMenuItem(
              value: 'Media Links and Docs',
              child: Text('Media Links and Docs')),
          const PopupMenuItem(
              value: 'Linked device', child: Text('Linked device')),
          // const PopupMenuItem(
          //     value: 'WhatsApp Web', child: Text('WhatsApp Web')),
          const PopupMenuItem(value: 'Search', child: Text('Search')),
          const PopupMenuItem(
              value: 'Mute Notifications', child: Text('Mute Notifications')),
          const PopupMenuItem(value: 'WallPaper', child: Text('WallPaper')),
          const PopupMenuItem(value: 'Locations', child: Text('Locations')),
          const PopupMenuItem(value: 'More', child: Text('More')),
        ];
      },
    );
  }
}
