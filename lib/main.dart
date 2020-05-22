import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tinylearn_client/PostsData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<PostsData> _postsData;

  @override
  void initState() {
    _postsData = _createPostsData();
    super.initState();
  }

  Future<PostsData> _createPostsData() async {
    
    final client = GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: 'http://10.0.0.105:4444/')
    );
    
    final result = await client.query(QueryOptions(
      documentNode: gql(r'''
        query {
          posts {
            id
            created
            content
          }
        }
      '''),
    ));
    if (result.hasException) throw result.exception;
    return PostsData.fromMap(result.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<PostsData>(
          future: _postsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildListView(context, snapshot);
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      )
    );
  }

  ListView buildListView(BuildContext context, AsyncSnapshot<PostsData> snapshot) {
    return ListView(
      children: snapshot.data.posts
        .map(postTile)
        .toList(),
    );
  }

  ListTile postTile(Post post) => ListTile(
    title: Text(post.content),
    subtitle: Text('${post.created.time}'),
  );
}

extension Time on int {

  DateTime get time => DateTime.fromMillisecondsSinceEpoch(this);
}

