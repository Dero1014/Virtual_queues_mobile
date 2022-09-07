import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:noq/classes/company.dart';
import 'package:noq/classes/custom.dart';
import 'package:noq/customWidgets/customWidget.dart';
import 'package:noq/pages/queue_page.dart';

import '../classes/user.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  var username = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          TextWidget(username, "Username", false),
          SizedBox(
            height: 15,
          ),
          TextWidget(password, "Password", true),
          ElevatedButton(
            onPressed: () async {
              var cf = CustomFunctions();
              var uri = Uri.parse("https://noq.ddns.net/mobile/login.mob.php");
              var response = await post(uri, body: {
                'mobileLogin': 'submited',
                'username': username.text,
                'password': password.text,
              });
              print("sent");
              print(response.body);

              if (response.body.contains("success")) {
                print("login");
                String json = cf.resolveJson(response.body, 0);
                Map map = jsonDecode(json);
                User user = new User(map["uId"], map["uName"]);

                // Check if user is already in queue
                user.inQueue((Company company, Service service) async {
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QueuePage(user, company, service)),
                    (Route<dynamic> route) => false,
                  );
                });

                Navigator.pushReplacementNamed(
                  context,
                  '/user',
                  arguments: user,
                );
              } else {
                print("login failed");
              }

              username.clear();
              password.clear();
            },
            child: Text(
              "Log in",
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/registration',
              );
            },
            child: Text("Signup"),
          )
        ]),
      ),
    );
  }
}
