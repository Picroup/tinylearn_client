
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tinylearn_client/models/Post.dart';
import 'package:tinylearn_client/functional/foundation/int_time.dart';
import 'package:tinylearn_client/functional/dateformat/shorttext_time.dart';

import 'MyCircleAvatar.dart';

class PostListTile extends StatelessWidget {

  final Post post;

  const PostListTile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8),
          MyCircleAvatar(url: post.user?.imageUrl),
          SizedBox(width: 8),
          Expanded(child: _buildPostBody(post, context),),
          SizedBox(width: 16),
        ],
      ),
    );
  }


  Column _buildPostBody(Post post, BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('@${post.user?.username ?? ""}', style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('${post.created.time.shortText}', style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey),)
          ],
        ),
        SizedBox(height: 4),
        Text(post.content, overflow: TextOverflow.ellipsis, maxLines: 5, style: Theme.of(context).textTheme.bodyText1),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildIconButton(
              icon: Icons.thumb_up,
            ),
            _buildIconButton(
              icon: Icons.bookmark,
            ),
            _buildIconButton(
              icon: Icons.more_horiz,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton({
    IconData icon,
    VoidCallback onPressed
  }) {
    return GestureDetector(
        child: Icon(icon, size: 16, color: Colors.grey,),
        onTap: onPressed,
      )
    ;
  }
}
