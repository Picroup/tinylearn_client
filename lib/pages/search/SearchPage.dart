

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/functional/foundation/SilenceChangeNotifier.dart';
import 'package:tinylearn_client/functional/networking/TagService/TagService.dart';
import 'package:tinylearn_client/functional/networking/TagService/types/TagsInput.dart';
import 'package:tinylearn_client/models/CursorTags.dart';
import 'package:tinylearn_client/pages/tagposts/TagPostsPage.dart';

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
        builder: (context, searchNotifier, child) => 
        searchNotifier.cursorTags?.items?.length == null
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: searchNotifier.cursorTags.items.length,
              child: Scaffold(
                appBar: _buildAppBar(context, searchNotifier),
                body: TabBarView(
                  children: searchNotifier.cursorTags.items
                      .map((tag) => TagPostsPage(tagName: tag.name))
                      .toList(),
                ),
              ),
            ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, SearchNotifier searchNotifier) {
    return AppBar(
      centerTitle: true,
      title: FlatButton(
        child: Row(
          children: <Widget>[
            Icon(Icons.search),
            SizedBox(width: 16),
            Expanded(child: Text('搜索', style: Theme.of(context).textTheme.subtitle1,),)
          ],
        ),
        onPressed: () {
          // showSearch
        },
      ),
      bottom: TabBar(
        isScrollable: true,
        labelColor: Theme.of(context).accentColor,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey,
        // labelStyle: Theme.of(context).textTheme.headline6,
        tabs: searchNotifier.cursorTags.items
          .map((item) => Tab(text: item.name == '#__all' ? '#全部' : item.name))
          .toList(),
      ),
    );
  }
}

class SearchNotifier extends SilenceChangeNotifier {

  final TagService tagService;

  // states

  bool isGettingTags = false;
  CursorTags cursorTags;
  dynamic getTagsError; 

  int currentIndex;

  String get currentTagName => currentIndex == null ||  cursorTags?.items == null
    ? null 
    : cursorTags.items[currentIndex].name; 

  SearchNotifier(this.tagService) {
    onTriggerGetTags();
  }

  onTriggerGetTags() async {
    if (isGettingTags) return;
    isGettingTags = true;
    cursorTags = null;
    getTagsError = null;
    notifyListeners();

    try {
      final data = await tagService.tags(TagsInput(take: 12));
      cursorTags = data.tags;
      print(data.toMap());
     } catch (error) {
      getTagsError = error;
    } finally {
      isGettingTags = false;
      notifyListeners();
    }
  }

}