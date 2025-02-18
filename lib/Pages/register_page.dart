import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edusn/constants/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  'Register your Account',
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
                        obsecure: false,
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
                  title: "Register",
                  fontSize: 19,
                  boxcolor: Color(0xFF7F265B),
                  textcolor: Colors.white,
                ),
                const SizedBox(
                  height: 25,
                ),
                kLoginButton(
                  title: "Login as Guest User",
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
