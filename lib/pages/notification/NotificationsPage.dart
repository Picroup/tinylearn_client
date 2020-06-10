
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/functional/foundation/SilenceChangeNotifier.dart';
import 'package:tinylearn_client/functional/graphql/errorMessage.dart';
import 'package:tinylearn_client/functional/networking/PostService/types/CursorInput.dart';
import 'package:tinylearn_client/functional/networking/UserService/UserService.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/NotificationsData.dart';
import 'package:tinylearn_client/models/CursorNotifications.dart';
import 'package:tinylearn_client/widgets/Spinner.dart';

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
        onRefresh: () async => notificationsNotifier.onTriggerRefreshNotificaions(),
        child: ListView.builder(
          // padding: const EdgeInsets.only(top: 16),
          itemCount: itemsLength + 1,
          itemBuilder: (context, index) {
            if (index == itemsLength) {
              return notificationsNotifier.hasNoMoreData ? Container() : Spinner();
            }
            final item = items[index];
            return ListTile(
              title: Text(item.kind),
            ); 
          }, 
          // separatorBuilder: (BuildContext context, int index) => Container(color: Colors.white, height: 16),
        ),
      ),
    );;
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
    onTriggerRefreshNotificaions();
  }

  void onTriggerRefreshNotificaions() async {
    print('onTriggerRefreshNotificaions');
    if (isGettingData) return;
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
}