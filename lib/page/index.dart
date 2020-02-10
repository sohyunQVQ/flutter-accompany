import 'package:flutter/material.dart';
import 'home/home_index.dart';
class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  var _controller = PageController(initialPage: 0);


  List<Widget> pageView = [
    HomeIndex(),
    HomeIndex(),
    HomeIndex(),
    HomeIndex(),
  ];

  List navItem = [
    {'icon':Icons.home,'title':'首页'},
    {'icon':Icons.local_pizza,'title':'饲主圈'},
    {'icon':Icons.message,'title':'消息'},
    {'icon':Icons.person,'title':'我'},
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: pageView,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: navItem.map((e)=>BottomNavigationBarItem(icon: Icon(e['icon']),title: Text(e['title']))).toList(),
          currentIndex: _currentIndex,
          onTap: (int index){
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[400],
        unselectedItemColor: Colors.black26,
      ),
    );
  }
}
