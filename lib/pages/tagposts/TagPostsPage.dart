
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/functional/foundation/SilenceChangeNotifier.dart';
import 'package:tinylearn_client/functional/networking/TagService/TagService.dart';
import 'package:tinylearn_client/functional/networking/TagService/types/TagPostsInput.dart';
import 'package:tinylearn_client/models/CursorPosts.dart';
import 'package:tinylearn_client/models/Tag.dart';
import 'package:tinylearn_client/widgets/PostListTile.dart';
import 'package:tinylearn_client/widgets/Spinner.dart';

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
  void initState() {
    initializeDateFormatting('zh');
    super.initState();
  }

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
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.maxScrollExtent - notification.metrics.pixels <= 200) {
                tagPostsNotifier.onTiggerGetTagPosts();
              }
              return false;
            },
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemCount: tagPostsNotifier.postsLength + 1,
              itemBuilder: (context, index) {
                if (index == tagPostsNotifier.postsLength) {
                  return tagPostsNotifier.hasNoMoreData ? Container() : Spinner();
                }
                final post = tagPostsNotifier.tag.posts.items[index];
                return PostListTile(post: post); 
              }, 
              separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          );
        },
      ),
    );
  }

}

class TagPostsNotifier extends SilenceChangeNotifier {

  final TagService tagService;
  final String tagName;

  // states

  bool isGettingTagPosts = false;
  Tag tag;
  dynamic getTagPostsError;
  bool get hasNoMoreData => !isGettingTagPosts 
    && getTagPostsError == null
    && tag != null
    && tag.posts.cursor == null;

  int get postsLength => tag?.posts?.items?.length ?? 0;
  
  TagPostsNotifier({this.tagService, this.tagName}) {
    onTiggerGetTagPosts();
  }

  onTiggerGetTagPosts() async {
    if (isGettingTagPosts || hasNoMoreData) return;
    isGettingTagPosts = true;
    getTagPostsError = null;
    notifyListeners();

    try {
      final data = await tagService.tagPots(TagPostsInput(
        tagName: tagName,
        take: 12,
        cursor: tag?.posts?.cursor
      ));
      print(data.toMap());
      _proccessNewTagPosts(data.tag);
    } catch (error) {
      getTagPostsError = error;
    } finally {
      isGettingTagPosts = false;
      notifyListeners();
    }
  }

  _proccessNewTagPosts(Tag newTag) {
    final newPosts = newTag.posts;
    if (this.tag == null) {
      this.tag = newTag;
    } else {
      final posts = CursorPosts(
        cursor: newPosts.cursor,
        items: [
          ...this.tag.posts.items,
          ...newPosts.items
        ]
      );
      this.tag = this.tag.copyWith(posts: posts);
    }
  } 
}