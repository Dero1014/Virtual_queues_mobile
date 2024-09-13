import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:noq/classes/company.dart';
import 'package:noq/classes/user.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.getUsername()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (() async {
                  var queues = QueueListData();
                  var uri = Uri.parse(
                      "https://noq.ddns.net/mobile/companiesdata.mob.php");
                  var response = await post(uri, body: {
                    'grabCompData': 'submited',
                  });

                  queues.fetchCompanies(response.body);

                  Navigator.pushNamed(
                    context,
                    '/company',
                    arguments: user,
                  );
                }),
                child: Text("Queue Page"),
              ),
              ElevatedButton(
                onPressed: (() async {
                  Navigator.pushReplacementNamed(context, '/');
                }),
                child: Text("Log out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
