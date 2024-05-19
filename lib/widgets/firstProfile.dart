import 'package:flutter/material.dart';
import 'package:textingslap/img/myPhotos.dart';

class FirstProfile extends StatefulWidget {
  const FirstProfile({super.key, required this.name});
  final String name;

  @override
  State<FirstProfile> createState() => _FirstProfileState();
}

class _FirstProfileState extends State<FirstProfile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(38),
            child: Image.asset(
              photo1,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 146,
                  ),
                  Text(
                    "4:30 PM",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Hello what are you doing?",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
