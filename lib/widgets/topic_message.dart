import 'package:flutter/material.dart';

class TopicMessageSnackBar extends SnackBar {
  TopicMessageSnackBar({
    super.key,
    required Color color,
    required String data,
    required EdgeInsets margin,
    required Color iconColor,
  }) : super(
         content: Stack(
           alignment: Alignment.center,
           children: [
             Padding(
               padding: const EdgeInsets.only(left: 6.0),
               child: Align(
                 alignment: Alignment.centerLeft,
                 child: Icon(Icons.circle_notifications, color: iconColor),
               ),
             ),
             Center(
               child: Padding(
                 padding: const EdgeInsets.only(left: 38.0),
                 child: Text(
                   data,
                   textAlign: TextAlign.center,
                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                 ),
               ),
             ),
           ],
         ),
         margin: margin,
         duration: const Duration(seconds: 4),
         behavior: SnackBarBehavior.floating,
         backgroundColor: color,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
       );
}
