import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../size_config.dart';
import '../util.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key,required this.notification}): super(key: key);

  final PendingNotificationRequest notification;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> payload = jsonDecode(widget.notification.payload!);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15),),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration:  BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1.0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      //The IntrinsicHeight widget will ensure that all children of the Row 
      // have the same height as the tallest child.
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(formatTime(payload["formattedDate"]).split(' ')[0],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                ),
                Text(formatTime(payload["formattedDate"]).split(' ')[1],
                  textAlign: TextAlign.center,
                  style: const TextStyle( color: Colors.black54),
                ),
              ],
            ),
            Container(
              width: 1, // Width of the vertical line
              color: Colors.black26, 
              margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),// Color of the vertical line
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.notification.title!, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),),
                  const SizedBox(height: 4,),
                  Row(
                    children: [
                      const Icon(Icons.repeat,size: 16,color: Colors.black45, ),
                      const SizedBox(width: 2,),
                      Text(payload["description"], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black45),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}