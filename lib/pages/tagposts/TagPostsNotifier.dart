
import 'package:tinylearn_client/functional/foundation/SilenceChangeNotifier.dart';
import 'package:tinylearn_client/functional/networking/TagService/TagService.dart';
import 'package:tinylearn_client/functional/networking/TagService/types/TagPostsInput.dart';
import 'package:tinylearn_client/models/CursorPosts.dart';
import 'package:tinylearn_client/models/Tag.dart';

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