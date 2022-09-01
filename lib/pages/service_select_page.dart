import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:noq/classes/company.dart';
import '../classes/user.dart';
import '../customWidgets/servicecard.dart';

class ServicePage extends StatefulWidget {
  Company company;
  User user;
  ServicePage(this.company, this.user);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFunc();
  }

  void initFunc() async {
    var uri = Uri.parse("https://noq.ddns.net/mobile/servicesdata.mob.php");
    var response = await post(uri, body: {
      'grabServData': 'submited',
      'xcName': widget.company.getCompanySpacelessName()
    });
    print("Request sent");
    setState(() {
      widget.company.fetchServices(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services for " + widget.company.getCompanyName()),
      ),
      body: ListView.builder(
        itemCount: widget.company.getServices().length,
        itemBuilder: (context, index) {
          return ServiceCard(
              widget.company.getService(index), widget.company, widget.user);
        },
      ),
    );
  }
}
