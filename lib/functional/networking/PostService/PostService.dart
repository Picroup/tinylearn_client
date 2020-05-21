

import 'package:tinylearn_client/models/PostsData.dart';

abstract class PostService {

  Future<PostsData> posts();
}