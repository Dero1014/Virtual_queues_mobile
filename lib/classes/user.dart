import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:noq/classes/company.dart';

import 'custom.dart';

class User {
  int uId;
  String uName;
  int myPosition = -1;
  int myTurn = 0;

  User(this.uId, this.uName);

  Future<bool> queueUp(Company company, Service service) async {
    var cf = CustomFunctions();
    var uri = Uri.parse("https://noq.ddns.net/mobile/queueup.mob.php");
    var response = await post(uri, body: {
      'queueUp': "submited",
      'cName': company.getCompanyName(),
      'sName': service.getServiceName(),
      'uId': "$uId",
    });
    print(response.body);
    String json = cf.resolveJson(response.body, 0);
    Map map = jsonDecode(json);
    if (map["result"] == true) {
      print("Queue process success");
      return true;
    }
    return false;
  }

  void inQueue(Function toQueue) async {
    var cf = CustomFunctions();
    var uri = Uri.parse("https://noq.ddns.net/mobile/inqueue.mob.php");
    var response = await post(uri, body: {
      'inQueue': "submited",
      'uId': "$uId",
    });
    print("Response : " + response.body);
    String json = cf.resolveJson(response.body, 0);
    Map map = jsonDecode(json);
    if (map["result"] == true) {
      Company company =
          new Company(map["cId"], map["cName"], map["xcName"], map["cDesc"]);
      Service service = new Service(map["sId"], map["sName"],
          map["numberOfUsers"], map["avgTime"], map["timeSum"]);
      toQueue(company, service);
    }
  }

  void setMyPosition(int position) {
    myPosition = position;
  }

  void setMyTurn(int turn) {
    myTurn = turn;
  }

  int getUserId() {
    return uId;
  }

  int getUserPosition() {
    return myPosition;
  }

  int getUserTurn() {
    return myTurn;
  }

  String getUsername() {
    return uName;
  }
}
