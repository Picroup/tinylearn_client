import 'package:flutter/material.dart';

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
    _currentIndex = 0;
    _pageController = PageController(
      initialPage: _currentIndex,
    );
    _items = createItems();
    super.initState();
  }

  void _onTapTab(int index) {
    final item = _items[index];
    if (item.key == 'add') return;
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  List<_Item> createItems() {
    return [
      _Item(
        key: 'home',
        widget: Container(color: Colors.orange),
        barItem: BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('首页'),
        )
      ),
      _Item(
        key: 'search',
        widget: Container(color: Colors.green),
        barItem: BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('搜索'),
        )
      ),
      _Item(
        key: 'add',
        widget: Container(),
        barItem: BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          title: Text('发布'),
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
        widget: Container(color: Colors.lime),
        barItem: BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我的'),
        )
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
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