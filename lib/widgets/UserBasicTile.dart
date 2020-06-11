
import 'package:flutter/material.dart';
import 'package:tinylearn_client/models/User.dart';

import 'MyCircleAvatar.dart';
import 'package:tinylearn_client/functional/dateformat/shorttext_time.dart';

class UserBasicTile extends StatelessWidget {

  final User user;
  final DateTime dateTime;
  final List<Widget> children;

  const UserBasicTile({Key key, this.user, this.dateTime, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8),
          MyCircleAvatar(url: user?.imageUrl),
          SizedBox(width: 8),
          Expanded(child: _buildBody(context),),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
   return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('@${user?.username ?? ""}', style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Text('${dateTime?.shortText}', style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey),)
          ],
        ),
        SizedBox(height: 4),
        ...children
      ],
    ); 
  }
}
