

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/functional/networking/TagService/TagService.dart';
import 'package:tinylearn_client/functional/networking/TagService/types/TagsInput.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchNotifier(context.read()),
      child: Consumer<SearchNotifier>(
        builder: (context, value, child) => Container(
          color: Colors.orange,
        ),
      ),
    );
  }
}

class SearchNotifier extends ChangeNotifier {

  final TagService tagService;

  SearchNotifier(this.tagService) {
    _test();
  }

  _test() async {

    try {
      final data = await tagService.tags(TagsInput(take: 12));
      print(data.toMap());
    } catch (error) {
      print('$error');
    }
  }

}