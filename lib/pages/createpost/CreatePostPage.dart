



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tinylearn_client/app/AppNotifier.dart';
import 'package:provider/provider.dart';
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




  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('发布', style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),),
                onPressed: () {
                  
                },
              ),
            ),
          )
        ],
      ),
      body: _buildBody(),
    ); 
  }

  Widget _buildBody() {
    final AppNotifier appNotifier = context.watch();
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
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
                    ),
                  ),
                ],
              )
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor, 
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 36,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.camera_alt, size: 22,),
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.image, size: 22,),
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('@', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),),
                  ),
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('#', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Markdown _markdown() {
    return Markdown(
      controller: controller,
      data: _markdownData,
      selectable: false,
      imageDirectory: 'https://raw.githubusercontent.com',
      imageBuilder: (uri) => CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(uri.toString()),
        backgroundColor: Colors.grey[100],
      ),
      onTapLink: (href) {
        print(href);
      },
      syntaxHighlighter: MySyntaxHighlighter(),
    );
  }
}

class MySyntaxHighlighter extends SyntaxHighlighter {
  @override
  TextSpan format(String source) {
    print(source);
    return TextSpan(text: source, style: TextStyle(color: Colors.cyan));
  }

}