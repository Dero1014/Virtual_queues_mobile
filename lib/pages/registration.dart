import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Registartion extends StatefulWidget {
  const Registartion({Key? key}) : super(key: key);

  @override
  State<Registartion> createState() => _RegistartionState();
}

class _RegistartionState extends State<Registartion> {
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
        TextField(
          controller: username,
          decoration: InputDecoration(
              hintText: "Username",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  //Clear text from input
                  username.clear();
                },
                icon: const Icon(Icons.clear),
              )),
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(
              hintText: "Email",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  //Clear text from input
                  email.clear();
                },
                icon: const Icon(Icons.clear),
              )),
        ),
        TextField(
          controller: password,
          decoration: InputDecoration(
              hintText: "password",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  //Clear text from input
                  password.clear();
                },
                icon: const Icon(Icons.clear),
              )),
        ),
        ElevatedButton(
            onPressed: () async {
              var uri = Uri.parse(
                  "https://noq.ddns.net/includes/registration.inc.php");
              var response = await post(uri, body: {
                'submitReg': 'submited',
                'regUserName': username.text,
                'regUserEmail': email.text,
                'regUserPass': password.text,
              });
              print("sent");
              print(response.body);

              if (response.body.contains("registration success")) {
                print("registered user");
              }

              username.clear();
              email.clear();
              password.clear();
            },
            child: Text("Signup"))
      ]),
    );
  }
}
