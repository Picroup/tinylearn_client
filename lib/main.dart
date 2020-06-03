import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tinylearn_client/app/AppProvider.dart';

import 'pages/tab/TabPage.dart';

void main() {
  Intl.defaultLocale = 'zh';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          appBarTheme: AppBarTheme(
            color: Colors.white
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TabPage(),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
