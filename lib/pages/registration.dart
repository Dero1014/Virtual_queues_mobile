import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:noq/classes/custom.dart';
import '../customWidgets/customWidget.dart';

class Registartion extends StatefulWidget {
  const Registartion({Key? key}) : super(key: key);

  @override
  State<Registartion> createState() => _RegistartionState();
}

class _RegistartionState extends State<Registartion> {
  var visibility = false;
  @override
  Widget build(BuildContext context) {
    var username = TextEditingController();
    var email = TextEditingController();
    var password = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "NoQ",
          style: TextStyle(color: Colors.grey[50]),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[800],
      ),
      body: Column(children: [
        TextWidget(username, "Username", false),
        TextWidget(email, "Email", false),
        TextWidget(password, "Password", true),
        ElevatedButton(
            onPressed: () async {
              var cf = new CustomFunctions();
              var uri =
                  Uri.parse("https://noq.ddns.net/mobile/registration.mob.php");
              var response = await post(uri, body: {
                'registerUser': 'submited',
                'uName': username.text,
                'uEmail': email.text,
                'uPass': password.text,
              });
              print(response.body);
              String json = cf.resolveJson(response.body, 0);
              Map map = jsonDecode(json);

              if (map["register"] == "success") {
                setState(() {
                  visibility = true;
                });
                print("registered user");
              } else {
                setState(() {
                  visibility = false;
                });
              }

              username.clear();
              email.clear();
              password.clear();
            },
            child: Text("Signup")),
        Visibility(
          visible: true,
          child: Text("Signed up!"),
        ),
      ]),
    );
  }
}
