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
      //The IntrinsicHeight widget will ensure that all children of the Row
      // have the same height as the tallest child.
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(12)),
            child: Column(
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
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB( getProportionateScreenWidth(12), getProportionateScreenHeight(12), 0, getProportionateScreenHeight(12)),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black26,  // Choose your border color here
                    width: 1.0,         // Choose your border width here
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.notification.title!,
                    style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                    softWrap: true,
                    maxLines: 1, // Limit to 2 lines
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4,),
                  widget.notification.body!.isEmpty? const SizedBox() :
                  Text(
                      widget.notification.body!,
                      style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black54),
                      softWrap: true,
                      maxLines: 2, // Limit to 2 lines
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.repeat,size: 16,color: Colors.red, ),
                      const SizedBox(width: 2,),
                      Expanded(
                        child: Text(
                          payload["description"],
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black45),
                          softWrap: true,
                          maxLines: 2, // Limit to 2 lines
                          overflow: TextOverflow.ellipsis,

                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
