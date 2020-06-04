
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tinylearn_client/app/AppNotifier.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/models/User.dart';
import 'package:tinylearn_client/widgets/MyCircleAvatar.dart';

class MePage extends StatefulWidget {

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final AppNotifier appNotifier = context.watch();
    final user = appNotifier.sessionInfo?.user;
    return Scaffold(
      appBar: AppBar(title: Text('我的', style: Theme.of(context).textTheme.headline5)),
      body: _buildBody(user, context),
    );
  }

  ListView _buildBody(User user, BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: MyCircleAvatar(url: user?.imageUrl),
              title: Text('@${user?.username ?? ''}', style: Theme.of(context).textTheme.headline6,),
              trailing: OutlineButton(
                child: Text('更新资料', style:  Theme.of(context).textTheme.button,), 
                onPressed: () {
                
              }),
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('博文', style: Theme.of(context).textTheme.headline6),
            trailing: Text('4', style:  Theme.of(context).textTheme.subtitle1),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('关注', style: Theme.of(context).textTheme.headline6),
            trailing: Text('8', style:  Theme.of(context).textTheme.subtitle1),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('粉丝', style: Theme.of(context).textTheme.headline6),
            trailing: Text('18', style:  Theme.of(context).textTheme.subtitle1),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('标记', style: Theme.of(context).textTheme.headline6),
            trailing: Text('28', style:  Theme.of(context).textTheme.subtitle1),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('点过的赞', style: Theme.of(context).textTheme.headline6),
            trailing: Text('38', style:  Theme.of(context).textTheme.subtitle1),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('更多选项', style: Theme.of(context).textTheme.headline6),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => MeMorePage(),
            ))
          ),
        ),
      ],
    );
  }
}

class MeMorePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('更多选项', style: Theme.of(context).textTheme.headline5)),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('反馈', style: Theme.of(context).textTheme.headline6),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('隐私政策', style: Theme.of(context).textTheme.headline6),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('关于 APP', style: Theme.of(context).textTheme.headline6),
              onTap: () async {
                final PackageInfo packageInfo = await PackageInfo.fromPlatform();
                showAboutDialog(
                  context: context,
                  applicationVersion: packageInfo.version,
                  applicationLegalese: 'Copyright (c) 2020 Jie Luo',
                 );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('退出登录', style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),),
              onPressed: () { },
            ),
          )
          // Card(
          //   child: R,
          // ),
        ],
      ),
    );
  }
}