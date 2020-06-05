



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tinylearn_client/app/AppNotifier.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/functional/chain/chain.dart';
import 'package:tinylearn_client/functional/foundation/React.dart';
import 'package:tinylearn_client/functional/foundation/SilenceChangeNotifier.dart';
import 'package:tinylearn_client/functional/graphql/errorMessage.dart';
import 'package:tinylearn_client/functional/networking/PostService/PostService.dart';
import 'package:tinylearn_client/functional/networking/PostService/types/CreatePostInput.dart';
import 'package:tinylearn_client/widgets/MyCircleAvatar.dart';


const String _markdownData = """
# Markdown Example
Markdown allows you to easily include formatted text, images, and even formatted Dart code in your app.

sdfdf
## Titles

Setext-style

```
This is an H1
=============

This is an H2
-------------
```

Atx-style

```
# This is an H1

## This is an H2

###### This is an H6
```

Select the valid headers:

- [x] `# hello`
- [ ] `#hello`

## Links
[github](https://github.com/flutter/flutter_markdown/issues?q=is%3Aissue+is%3Aopen+code)

[Google's Homepage][Google]

[#Flutter]()  [@luojie]()

```
[inline-style](https://www.google.com)

[reference-style][Google]
```

## Images

![Flutter logo](/dart-lang/site-shared/master/src/_assets/image/flutter/icon/64.png)
![](https://minio.picroup.com:444/tinylearn.dev/profile_male_5.JPG)

## Tables

|Syntax                                 |Result                               |
|---------------------------------------|-------------------------------------|
|`*italic 1*`                           |*italic 1*                           |
|`_italic 2_`                           | _italic 2_                          |
|`**bold 1**`                           |**bold 1**                           |
|`__bold 2__`                           |__bold 2__                           |
|`This is a ~~strikethrough~~`          |This is a ~~strikethrough~~          |
|`***italic bold 1***`                  |***italic bold 1***                  |
|`___italic bold 2___`                  |___italic bold 2___                  |
|`***~~italic bold strikethrough 1~~***`|***~~italic bold strikethrough 1~~***|
|`~~***italic bold strikethrough 2***~~`|~~***italic bold strikethrough 2***~~|

## Styling
Style text as _italic_, __bold__, ~~strikethrough~~, or `inline code`.

- Use bulleted lists
- To better clarify
- Your points

## Code blocks
Formatted Dart code looks really pretty too:

```swift
let a = a
```

```
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Markdown(data: markdownData),
    ),
  ));
}
```

## Markdown widget

This is an example of how to create your own Markdown widget:

    Markdown(data: 'Hello _world_!');

Enjoy!

[Google]: https://www.google.com/
""";

class CreatePostPage extends StatefulWidget {

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}
class _CreatePostPageState extends State<CreatePostPage> {


  // final TextEditingController _textEditingController = TextEditingController();

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreatePostNotifier(
        postService: context.read()
      ),
      child: Builder(
        builder: (context) {
          final CreatePostNotifier createPostNotifier = context.watch();
          return Scaffold(
            appBar: _buildAppBar(context, createPostNotifier),
            body: Builder(builder: _buildBody),
          );
        },
      ),
    ); 
  }

  AppBar _buildAppBar(BuildContext context, CreatePostNotifier createPostNotifier) {
    return AppBar(
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Container(
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              disabledColor: Theme.of(context).colorScheme.background,
              child: Text('发布', style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),),
              onPressed: createPostNotifier.isPoseEnable 
                ? createPostNotifier.onTriggerCreatePost
                : null,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final AppNotifier appNotifier = context.watch();
    final CreatePostNotifier createPostNotifier = context.watch();
    return Chain((Widget child) => React(
        listenable: createPostNotifier,
        select: (CreatePostNotifier notifier) => notifier.message,
        areEqual: (previous, current) => identical(previous, current),
        onTigger: (value) => Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(value))),
        child: child,
      ))
      .child((child) => React(
        listenable: createPostNotifier,
        select: (CreatePostNotifier notifier) => notifier.data,
        onTigger: (value) async {
          await Future.delayed(Duration(seconds: 2));
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
        child: child,
      ))
      .build(SafeArea(
        child: Column(
          children: <Widget>[
            _buildContent(appNotifier, createPostNotifier),
            _buildKeyboardBar(context),
          ],
        ),
      ));
  }

  Expanded _buildContent(AppNotifier appNotifier, CreatePostNotifier createPostNotifier) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyCircleAvatar(url: appNotifier.sessionInfo?.user?.imageUrl),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                expands: true,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLength: 550,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: createPostNotifier.onSetContent,
              ),
            ),
          ],
        )
      ),
    );
  }

  Container _buildKeyboardBar(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor, 
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      // height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Icon(Icons.camera_alt,),
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Icon(Icons.image,),
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text('@', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),),
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text('#', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),),
            ),
          ),
        ],
      ),
    );
  }

  // Markdown _markdown() {
  //   return Markdown(
  //     controller: controller,
  //     data: _markdownData,
  //     selectable: false,
  //     imageDirectory: 'https://raw.githubusercontent.com',
  //     imageBuilder: (uri) => CircleAvatar(
  //       backgroundImage: CachedNetworkImageProvider(uri.toString()),
  //       backgroundColor: Colors.grey[100],
  //     ),
  //     onTapLink: (href) {
  //       print(href);
  //     },
  //   );
  // }
}

class CreatePostNotifier extends SilenceChangeNotifier {

  final PostService postService;

  CreatePostNotifier({this.postService});

  // states 
  String content = '';

  bool isPosting = false;
  String data;
  dynamic error;

  String message;

  bool get isPoseEnable => !isPosting
    && data == null
    && isContentValid;

  bool get isContentValid => content.trim().length >= 5;

  void onSetContent(String content) {
    this.content = content;
    notifyListeners();
  }

  void onTriggerCreatePost() async {
    if (!isPoseEnable) return;

    isPosting = true;
    data = null;
    error = null;
    notifyListeners();

    try {
      data = await postService.createPost(CreatePostInput(content: content.trim()));
      message = '发布成功!';
    } catch (error) {
      this.error = error;
      message = errorMessage(error);
    } finally {
      isPosting = false;
      notifyListeners();
    }

  }
}