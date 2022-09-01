import 'package:flutter/material.dart';
import 'package:noq/classes/user.dart';
import 'package:noq/pages/login.dart';
import 'package:noq/pages/queue_page.dart';
import 'package:noq/pages/registration.dart';
import 'package:noq/pages/company_select_page.dart';
import 'package:noq/pages/user_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/registration': (context) => Registartion(),
      '/user': (context) => UserPage(),
      '/company': (context) => CompanyPage(),
    },
  ));
}
