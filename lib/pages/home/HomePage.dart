
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/functional/foundation/SilenceChangeNotifier.dart';
import 'package:tinylearn_client/functional/networking/PostService/PostService.dart';
import 'package:tinylearn_client/functional/networking/PostService/types/CursorInput.dart';
import 'package:tinylearn_client/functional/networking/PostService/types/TimelineData.dart';
import 'package:tinylearn_client/models/CursorPosts.dart';
import 'package:tinylearn_client/pages/createpost/CreatePostPage.dart';
import 'package:tinylearn_client/widgets/CursorPostsPage.dart';

class HomePage extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  void _routeToCreatePost() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CreatePostPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => HomeNotifier(postService: context.read()),
      child: Builder(
        builder: (context) {
          final HomeNotifier homeNotifier = context.watch();
          return Scaffold(
            appBar: AppBar(
              title: Text("关注", style: Theme.of(context).textTheme.headline5),
            ),
            body: _buildBody(homeNotifier),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
              onPressed: _routeToCreatePost,
            ),
          );
        }
      ),
    );
  }
  

  Widget _buildBody(HomeNotifier homeNotifier) {
    return CursorPostsPage(
      posts: homeNotifier.data?.timeline?.items,
      hasNoMoreData: homeNotifier.hasNoMoreData,
      onReachBottom: () => homeNotifier.onTriggerGetData(),
    );
  }
}

class HomeNotifier extends SilenceChangeNotifier {

  final PostService postService;

  // states

  bool isGettingData = false;
  TimelineData data;
  dynamic error;
  bool get hasNoMoreData => !isGettingData 
    && error == null
    && data != null
    && data.timeline.cursor == null;

  HomeNotifier({this.postService}) {
    onTriggerGetData();
  }

  onTriggerGetData() async {
    if (isGettingData || hasNoMoreData) return;
    isGettingData = true;
    error = null;
    notifyListeners();

    try {
      final _data = await postService.timeline(CursorInput(
        take: 12,
        cursor: data?.timeline?.cursor
      ));
      print(_data.toMap());
      _proccessNewData(_data);
    } catch (_error) {
      error = _error;
    } finally {
      isGettingData = false;
      notifyListeners();
    }
  }

  _proccessNewData(TimelineData _data) {
    final newCursorPosts = _data.timeline;
    if (this.data == null) {
      this.data = _data;
    } else {
      this.data = TimelineData(
        timeline: CursorPosts(
          cursor: newCursorPosts.cursor,
          items: [
            ...this.data.timeline.items,
            ...newCursorPosts.items
          ]
        )
      );
    }
  }
}
