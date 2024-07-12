import 'package:flutter/material.dart';
import 'package:flutter_edusn/Pages/chat_page.dart';
import 'package:flutter_edusn/constants/availablebox.dart';

class AvailablePage extends StatelessWidget {
  const AvailablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Availablebox(
                  maintext: "Talk with chatbot",
                  subtext: "24&7 available",
                  imageicon: "Images/bot.png",
                  status: true),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Availablebox(
                  maintext: "Talk with Customer Service",
                  subtext: "Available only 9AM - 4PM(GMT +6:30)",
                  imageicon: "Images/cusicon.png",
                  status: true),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Availablebox(
                  maintext: "Talk with Accountant Pay for school payments ",
                  subtext: "Available only 9AM - 4PM(GMT +6:30)",
                  imageicon: "Images/cusicon.png",
                  status: true),
            )
          ],
        ),
      )),
    );
  }
}
