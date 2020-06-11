import 'package:flutter/material.dart';
import 'package:tinylearn_client/app/AppNotifier.dart';
import 'package:tinylearn_client/pages/createpost/CreatePostPage.dart';
import 'package:tinylearn_client/pages/home/HomePage.dart';
import 'package:tinylearn_client/pages/login/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/pages/me/MePage.dart';
import 'package:tinylearn_client/pages/notification/NotificationsPage.dart';
import 'package:tinylearn_client/pages/search/SearchPage.dart';
import 'package:intl/date_symbol_data_local.dart';

class TabPage extends StatefulWidget {

  @override
  createState() => _TabState();
}

class _Item {
  final String key;
  final Widget widget;
  final IconData iconData;

  _Item({@required this.key, @required this.widget, @required this.iconData});

}

class _TabState extends State<TabPage> {

  // state
  int _currentIndex;
  List<_Item> _items;

  // service
  PageController _pageController;

  @override
  void initState() {
    initializeDateFormatting('zh');
    
    _currentIndex = 1;
    _pageController = PageController(
      initialPage: _currentIndex,
    );
    _items = createItems();
    super.initState();
  }

  void _onTapTab(int index) {
    final item = _items[index];
    final AppNotifier appViewModel = context.read();
    if (!appViewModel.isLogin && item.key != 'search') {
      this._routeToLogin();
      return;
    }
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _onTapAdd() {
    final AppNotifier appViewModel = context.read();
    if (!appViewModel.isLogin) {
      this._routeToLogin();
      return;
    }
    _routeToCreatePost();
  }

  void _routeToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginPage()
      )
    );
  }

  void _routeToCreatePost() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CreatePostPage(),
    ));
  }

  List<_Item> createItems() {
    return [
      _Item(
        key: 'home',
        widget: HomePage(),
        iconData: Icons.home,
      ),
      _Item(
        key: 'search',
        widget: SearchPage(),
        iconData: Icons.search, 
      ),
      _Item(
        key: 'notifications',
        widget: NotificationsPage(),
        iconData: Icons.notifications,
      ),
      _Item(
        key: 'me',
        widget: MePage(),
        iconData: Icons.person,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isSessionInfoInit = context.select<AppNotifier, bool>((viewModel) => viewModel.isSessionInfoInit);
    if (!isSessionInfoInit) return Container(color: Theme.of(context).scaffoldBackgroundColor);
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _items.map((item) => item.widget).toList(),
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Theme.of(context).accentColor,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _processBarItems(
            _items.asMap()
              .map((index, item) => MapEntry(index, _buildBarItem(item, index)))
              .values.toList()
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        onPressed: _onTapAdd,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _BarItem _buildBarItem(_Item item, int index) {
    return _BarItem(
      iconData: item.iconData,
      selected: _currentIndex == index,
      onPressed: () => _onTapTab(index),
    );
  }

  List<Widget> _processBarItems(List<_BarItem> barItems) {
    if (barItems.length == 0 || barItems.length % 2 != 0) return barItems;
    final middle = (barItems.length / 2).floor();
    return [
      ...barItems.sublist(0, middle),
      Container(width: 36, height: 10),
      ...barItems.sublist(middle)
    ];
  }
}

class _BarItem extends StatelessWidget {

  final IconData iconData;
  final bool selected;
  final VoidCallback onPressed;

  const _BarItem({
    Key key,
    @required this.iconData, 
    this.selected = false, 
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
        color: selected 
          ?  Theme.of(context).accentColor
          : Theme.of(context).disabledColor,
      ),
      onPressed: onPressed,
    );
  }
}

