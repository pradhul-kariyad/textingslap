// ignore_for_file: unused_import

import 'package:textingslap/img/myPhotos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 13,
          right: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Color.fromARGB(255, 211, 200, 200)),
                  // color: Color.fromARGB(255, 12, 148, 146),
                  borderRadius: BorderRadius.circular(19)),
              child: Row(
                children: [
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(Icons.arrow_forward_ios_sharp)),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    // child: CircleAvatar(radius: 23,backgroundImage: AssetImage(photo1),),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10, right: 10),
                  //   child: Icon(
                  //     Icons.person,
                  //     size: 26,
                  //   ),
                  // ),
                  Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
            ),
            // Divider()
          ],
        ),
      ),
    );
  }
}
