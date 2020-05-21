
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/functional/graphql/errorMessage.dart';
import 'package:tinylearn_client/functional/fundation/int_time.dart';
import 'package:tinylearn_client/functional/networking/PostService/PostService.dart';
import 'package:tinylearn_client/models/Post.dart';
import 'package:tinylearn_client/models/PostsData.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key key, this.title}): super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<PostService>(
      builder: (context, _postService, child) => 
        Center(
          child: futureBuilder(_postService),
        ),
    );
  }

  FutureBuilder<PostsData> futureBuilder(PostService _postService) {
    return FutureBuilder<PostsData>(
      future: _postService.posts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final posts = snapshot.data.posts;
          return ListView(
            children: posts.map(_postListTile).toList(),
          );
        }
        if (snapshot.hasError) {
          return Text(errorMessage(snapshot.error));
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _postListTile(Post post) {
    return ListTile(
      title: Text(post.content),
      trailing: Text(post.created?.time.toString() ?? ''),
    );
  }
}
