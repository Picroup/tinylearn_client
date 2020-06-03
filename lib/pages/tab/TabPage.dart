import 'package:flutter/material.dart';
import 'package:tinylearn_client/app/AppNotifier.dart';
import 'package:tinylearn_client/pages/home/HomePage.dart';
import 'package:tinylearn_client/pages/login/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/pages/me/MePage.dart';
import 'package:tinylearn_client/pages/search/SearchPage.dart';
import 'package:intl/date_symbol_data_local.dart';

class TabPage extends StatefulWidget {

  @override
  createState() => _TabState();
}

class _Item {
  final String key;
  final Widget widget;
  final BottomNavigationBarItem barItem;

  _Item({@required this.key, @required this.widget, @required this.barItem});

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

  void _routeToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginPage()
      )
    );
  }

  List<_Item> createItems() {
    return [
      _Item(
        key: 'home',
        widget: HomePage(),
        barItem: BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('首页'),
        )
      ),
      _Item(
        key: 'search',
        widget: SearchPage(), 
        barItem: BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('搜索'),
        )
      ),
      _Item(
        key: 'notifications',
        widget: Container(color: Colors.amber),
        barItem: BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('通知'),
        )
      ),
      _Item(
        key: 'me',
        widget: MePage(),
        barItem: BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我的'),
        )
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isSessionInfoInit = context.select<AppNotifier, bool>((viewModel) => viewModel.isSessionInfoInit);
    if (!isSessionInfoInit) return Container(color: Theme.of(context).scaffoldBackgroundColor);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _items.map((item) => item.widget).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: _onTapTab,
        items: _items.map((item) => item.barItem).toList(),
      ),
    );
  }
}