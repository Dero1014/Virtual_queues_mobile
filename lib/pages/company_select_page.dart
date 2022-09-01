import 'package:flutter/material.dart';
import 'package:noq/classes/company.dart';
import 'package:noq/customWidgets/companycard.dart';

import '../classes/user.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  var queue = new QueueListData();

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text("Queue"),
      ),
      body: ListView.builder(
        itemCount: queue.getCompaniesList().length,
        itemBuilder: (context, index) {
          return CompanyCard(queue.getCompany(index), user);
        },
      ),
    );
  }
}
