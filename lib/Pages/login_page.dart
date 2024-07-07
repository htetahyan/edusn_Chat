import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edusn/Pages/chat_page.dart';
import 'package:flutter_edusn/Pages/register_page.dart';
import 'package:flutter_edusn/constants/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 60,
              right: 20,
              left: 20,
            ),
            child: Column(
              children: [
                Image(
                  image: AssetImage("Images/EDUSNlogop.png"),
                  width: 300,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Login to your Account',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kInputBoxes(
                        title: "Username",
                        hintText: "James",
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      kInputBoxes(
                        title: "Password",
                        hintText: "@#djdda",
                        obsecure: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value;
                          });
                        }),
                    Text("Remember me"),
                    Spacer(),
                    Text(
                      "forgot password?",
                      style: TextStyle(color: Color(0xFF7F265B)),
                    )
                  ],
                ),
                kLoginButton(
                  ontap: () {
                    setState(() {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => ChatPage()));
                    });
                  },
                  title: "Login",
                  fontSize: 19,
                  boxcolor: Color(0xFF7F265B),
                  textcolor: Colors.white,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Don't have an account?",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                kLoginButton(
                  title: "Login as Guest User",
                  ontap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  textcolor: Color(0xFF7F265B),
                  fontSize: 14,
                ),
              ],
            ),
          )),
          Expanded(
            child: Image(
              image: AssetImage(
                "Images/EDUBG.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
