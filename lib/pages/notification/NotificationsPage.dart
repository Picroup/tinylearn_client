
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/functional/foundation/SilenceChangeNotifier.dart';
import 'package:tinylearn_client/functional/graphql/errorMessage.dart';
import 'package:tinylearn_client/functional/networking/PostService/types/CursorInput.dart';
import 'package:tinylearn_client/functional/networking/UserService/UserService.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/NotificationsData.dart';
import 'package:tinylearn_client/models/CursorNotifications.dart';
import 'package:tinylearn_client/models/Notification.dart' as noti;
import 'package:tinylearn_client/models/User.dart';
import 'package:tinylearn_client/widgets/Spinner.dart';
import 'package:tinylearn_client/widgets/UserBasicTile.dart';
import 'package:tinylearn_client/functional/foundation/int_time.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationsNotifier(
        userService: context.read()
      ),
      child: Builder(
        builder: (context) {
          final NotificationsNotifier notificationsNotifier = context.watch();
          return Scaffold(
            appBar: AppBar(
              title: Text("通知", style: Theme.of(context).textTheme.headline5),
            ),
            body: _buildBody(notificationsNotifier),
          );
        }
      ),
    );
  }

  Widget _buildBody(NotificationsNotifier notificationsNotifier) {
    final items = notificationsNotifier.data?.notifications?.items;
    final itemsLength = items?.length ?? 0;
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.maxScrollExtent - notification.metrics.pixels <= 200) {
          notificationsNotifier.onTriggerGetData();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async => notificationsNotifier.onTriggerRefreshNotifications(),
        child: ListView.builder(
          // padding: const EdgeInsets.only(top: 16),
          itemCount: itemsLength + 1,
          itemBuilder: (context, index) {
            if (index == itemsLength) {
              return notificationsNotifier.hasNoMoreData ? Container() : Spinner();
            }
            final item = items[index];
            return _buildNotificationItem(context, item, index); 
          }, 
          // separatorBuilder: (BuildContext context, int index) => Container(color: Colors.white, height: 16),
        ),
      ),
    );;
  }

  Widget _buildNotificationItem(BuildContext context, noti.Notification item, int index) {
    return Opacity(
      opacity: index < 2 ? 1.0 : 0.6,
      // opacity: item.readed ? 0.6 : 1.0,
      child: UserBasicTile(
        user: item.user,
        dateTime: item.created.time,
        children: _buildNotificationTileChildren(context, item),
      ),
    );
  }

  List<Widget> _buildNotificationTileChildren(BuildContext context, noti.Notification item) {
    
    switch (item.kind) {
      case 'followUser':
        return [
          Text('关注了你', style: Theme.of(context).textTheme.headline6),
        ];
      case 'upPost':
        return [
          Text('给你的文章点赞', style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 64,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MarkdownBody(data: item.upPostPost?.content, onTapLink: (url) async {

                }),
              ),
            ),
          ),
        ];
      case 'markPost':
        return [
          Text('标记了你的文章', style: Theme.of(context).textTheme.headline6),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MarkdownBody(data: item.markPostPost?.content, onTapLink: (url) async {

              }),
            ),
          ),
        ];
      default:
        return [
          Text('未知通知类型，请升级此应用查看', style: Theme.of(context).textTheme.headline6),
        ];
    }
  }
}

extension Fields on noti.Notification {

  User get user {
    switch (this.kind) {
    case 'followUser':
      return followUserUser;
    case 'upPost':
      return upPostUser;
    case 'markPost':
      return markPostUser;
    default:
      return null;
  }
  }
}

class NotificationsNotifier extends SilenceChangeNotifier {

  final UserService userService;

  // states

  bool isGettingData = false;
  NotificationsData data;
  dynamic error;
  bool get hasNoMoreData => !isGettingData 
    && error == null
    && data != null
    && data.notifications.cursor == null;

  NotificationsNotifier({
    @required this.userService
  }) {
    onTriggerRefreshNotifications();
  }

  void onTriggerRefreshNotifications() async {
    if (isGettingData) return;
    print('onTriggerRefreshNotifications');
    data = null;
    error = null;
    notifyListeners();

    onTriggerGetData();
  }

  void onTriggerGetData() async {
    if (isGettingData || hasNoMoreData) return;
    isGettingData = true;
    error = null;
    notifyListeners();

    try {
      final _data = await userService.notifications(CursorInput(
        take: 12,
        cursor: data?.notifications?.cursor
      ));
      print(_data.toMap());
      _proccessNewData(_data);
    } catch (_error) {
      error = _error;
      print(errorMessage(error));
    } finally {
      isGettingData = false;
      notifyListeners();
    }
  }

  _proccessNewData(NotificationsData _data) {
    final newCursorNotifications = _data.notifications;
    if (this.data == null) {
      this.data = _data;
      _onTriggerMarkAllAsReaded();
    } else {
      this.data = NotificationsData(
        notifications: CursorNotifications(
          cursor: newCursorNotifications.cursor,
          items: [
            ...this.data.notifications.items,
            ...newCursorNotifications.items
          ]
        )
      );
    }
  }

  _onTriggerMarkAllAsReaded() async {
    if (data != null 
      && data.notifications.items.isNotEmpty 
      && !data.notifications.items.first.readed) {

      try {
        await userService.markAllNotificationsAsRead();  
        print('markAllNotificationsAsRead success!');
      } catch (_error) {
        print(errorMessage(_error));
      }
    }
  }
}