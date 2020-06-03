
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/widgets/CursorPostsPage.dart';

import 'TagPostsNotifier.dart';

class TagPostsPage extends StatefulWidget {
  final String tagName;

  const TagPostsPage({Key key, this.tagName}) : super(key: key);

  @override
  _TagPostsPageState createState() => _TagPostsPageState();
}

class _TagPostsPageState extends State<TagPostsPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => TagPostsNotifier(
        tagName: widget.tagName,
        tagService: context.read()
      ),
      child: Builder(
        builder: (context) {
          final TagPostsNotifier tagPostsNotifier = context.watch();
          return CursorPostsPage(
            posts: tagPostsNotifier.tag?.posts?.items,
            hasNoMoreData: tagPostsNotifier.hasNoMoreData,
            onReachBottom: () => tagPostsNotifier.onTiggerGetTagPosts(),
          );
        },
      ),
    );
  }

}

