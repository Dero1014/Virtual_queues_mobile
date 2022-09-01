import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:noq/classes/company.dart';
import 'package:noq/classes/custom.dart';

import '../classes/user.dart';

class QueuePage extends StatefulWidget {
  User user;
  Company company;
  Service service;

  QueuePage(this.user, this.company, this.service);

  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  late Timer timer;
  bool visibility = true;

  @override
  void initState() {
    super.initState();
    print("Queue start...");
    widget.user.queueUp(widget.company, widget.service);
    timer = Timer.periodic(
        Duration(milliseconds: 500), (Timer t) => getQueueInfo());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void getQueueInfo() async {
    print("Fetch queue data...");
    var cf = CustomFunctions();
    var uri = Uri.parse("https://noq.ddns.net/mobile/queuedata.mob.php");
    var response = await post(uri, body: {
      'grabQueueData': 'submited',
      'cName': widget.company.getCompanyName(),
      'sName': widget.service.getServiceName(),
      'uId': widget.user.getUserId().toString(),
    });
    print(response.body);
    String json = cf.resolveJson(response.body, 0);
    Map map = jsonDecode(json);
    if (map["inQueue"] == true) {
      setState(() {
        widget.user.setMyPosition(map["position"]);
        widget.service.setAverageTime(map["averageTime"]);
      });
    } else {
      Navigator.pushReplacementNamed(context, '/user', arguments: widget.user);
    }

    if (map["myTurn"] == 1) {
      widget.user.setMyTurn(1);
    } else {
      widget.user.setMyTurn(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    String positionText =
        "Current position is " + widget.user.getUserPosition().toString();
    String timeText = "Average wait time is " +
        (widget.service.getServiceAverageTime() * widget.user.getUserPosition())
            .toString() +
        " mins";

    if (widget.user.getUserTurn() == 1) {
      setState(() {
        positionText = "You are up!";
        timeText = "";
        visibility = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Queue for " + widget.service.getServiceName()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            positionText,
          ),
          Text(
            timeText,
          ),
          Visibility(
            visible: visibility,
            child: ElevatedButton(
              onPressed: () async {
                var cf = CustomFunctions();
                var uri =
                    Uri.parse("https://noq.ddns.net/mobile/queuedrop.mob.php");
                var response = await post(uri, body: {
                  'queueDrop': 'submited',
                  'cName': widget.company.getCompanyName(),
                  'sName': widget.service.getServiceName(),
                  'uId': widget.user.getUserId().toString()
                });
                print(response.body);

                String json = cf.resolveJson(response.body, 0);
                Map map = jsonDecode(json);

                if (map["drop"] == true) {
                  Navigator.pushReplacementNamed(context, '/user',
                      arguments: widget.user);
                }
              },
              child: Text("Drop"),
            ),
          )
        ],
      ),
    );
  }
}
