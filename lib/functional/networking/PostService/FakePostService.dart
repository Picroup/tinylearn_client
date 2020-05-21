

import 'package:tinylearn_client/models/PostsData.dart';

import 'PostService.dart';

class FakePostService extends PostService {

  @override
  Future<PostsData> posts() async {
    await Future.delayed(Duration(seconds: 2), () {});
    const jsonData = '''
    {
      "posts": [
        {
          "id": "0",
          "content": "Flutter 开发演示",
          "created": 1589888348291
        },
        {
          "id": "0",
          "content": "Node 开发演示",
          "created": 1589888348291
        }
      ]
    }
    ''';
    return PostsData.fromJson(jsonData);
  }

}