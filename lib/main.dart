import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tinylearn_client/app/AppProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        title: '小小学',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          appBarTheme: AppBarTheme(
            color: Colors.white
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale.fromSubtags(languageCode: 'zh'), 
        ],
        home: TabPage(),
      ),
    );
  }
}
