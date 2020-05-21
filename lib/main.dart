import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/app/AppProvider.dart';
import 'functional/graphql/errorMessage.dart';
import 'functional/networking/PostService/PostService.dart';
import 'functional/fundation/int_time.dart';
import 'models/Post.dart';
import 'models/PostsData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  const MyHomePage({Key key, this.title}): super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
