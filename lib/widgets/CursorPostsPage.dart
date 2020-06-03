import 'package:flutter/material.dart';
import 'package:tinylearn_client/models/Post.dart';
import 'PostListTile.dart';
import 'Spinner.dart';

class CursorPostsPage extends StatelessWidget {
  const CursorPostsPage({
    Key key,
    @required this.posts,
    @required this.hasNoMoreData,
    @required this.onReachBottom,
  }) : super(key: key);

  final List<Post> posts;
  final bool hasNoMoreData;
  final VoidCallback onReachBottom; 

  @override
  Widget build(BuildContext context) {
    final postsLength = posts?.length ?? 0;
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.maxScrollExtent - notification.metrics.pixels <= 200) {
          onReachBottom();
        }
        return false;
      },
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        itemCount: postsLength + 1,
        itemBuilder: (context, index) {
          if (index == postsLength) {
            return hasNoMoreData ? Container() : Spinner();
          }
          final post = posts[index];
          return PostListTile(post: post); 
        }, 
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}