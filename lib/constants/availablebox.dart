import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Availablebox extends StatefulWidget {
  Availablebox(
      {super.key,
      required this.maintext,
      required this.subtext,
      required this.imageicon,
      this.status = false});

  final String maintext;
  final String subtext;
  final String imageicon;
  bool status;

  @override
  State<Availablebox> createState() => _AvailableboxState();
}

class _AvailableboxState extends State<Availablebox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      height: 200,
      decoration: BoxDecoration(
          color: Color(0xFF0E1129), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Text(
                    widget.maintext,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.subtext,
                    style: const TextStyle(
                        color: Color(0xFF5FD855), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 50,
                width: 50,
                child: Image.asset(widget.imageicon),
              ),
              Switch(
                  value: widget.status,
                  onChanged: (value) {
                    setState(() {
                      widget.status = value;
                    });
                  })
            ],
          ),
        ],
      ),
    );
  }
}
