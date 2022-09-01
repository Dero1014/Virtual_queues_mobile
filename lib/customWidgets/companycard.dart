import 'package:flutter/material.dart';
import 'package:noq/classes/company.dart';
import 'package:noq/pages/service_select_page.dart';

import '../classes/user.dart';

class CompanyCard extends StatelessWidget {
  Company company;
  User user;

  CompanyCard(this.company, this.user);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServicePage(company, user)));
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  company.getCompanyName(),
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  company.getCompanyDescription(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
