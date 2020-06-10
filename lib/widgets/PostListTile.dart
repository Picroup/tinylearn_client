
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tinylearn_client/models/Post.dart';
import 'package:tinylearn_client/functional/foundation/int_time.dart';
import 'package:url_launcher/url_launcher.dart';

import 'UserBasicTile.dart';

class PostListTile extends StatelessWidget {

  final Post post;
  final MarkdownTapLinkCallback onTapLink;

  const PostListTile({Key key, this.post, this.onTapLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserBasicTile(
      user: post?.user,
      dateTime: post?.created?.time,
      children: <Widget>[
        // Text(post.content, overflow: TextOverflow.ellipsis, maxLines: 5, style: Theme.of(context).textTheme.bodyText1),
        MarkdownBody(data: post.content, onTapLink: (url) async {
          if (await canLaunch(url)) {
            await launch(url);
          }
        }),
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
