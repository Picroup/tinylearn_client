
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {

  final String url;

  const MyCircleAvatar({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(
        url ?? ""
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}