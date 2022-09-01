import 'package:flutter/material.dart';
import 'package:noq/classes/company.dart';
import 'package:noq/pages/queue_page.dart';

import '../classes/user.dart';

class ServiceCard extends StatelessWidget {
  Service service;
  Company company;
  User user;

  ServiceCard(this.service, this.company, this.user);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Card(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                service.getServiceName(),
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[600],
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QueuePage(user, company, service)),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: const Icon(Icons.add_box_outlined),
                label: const Text("Enter queue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
