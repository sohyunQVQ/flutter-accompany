import 'package:accompany/data/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accompany/page/common/login.dart';
import 'package:location/location.dart';
import 'package:toast/toast.dart';
import 'page/index.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main(){
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,  //设置为透明
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthModel _auth = AuthModel();

  LocationData currentLocation;
  var location = new Location();
  Future<bool> _checkPersmission() async {
    bool hasPermission = await location.hasPermission();
//    await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
    if (!hasPermission) {

      bool requestPermission =  await location.requestPermission();

//      PermissionStatus requestPermissionResult =
//      await SimplePermissions.requestPermission(
//          Permission.WhenInUseLocation);
//      if (requestPermissionResult != PermissionStatus.authorized) {
      if(requestPermission==false){
        Toast.show("申请定位权限失败", context);
        return false;
      }
    }
    LocationData _data = await location.getLocation();
    setState(() {
      currentLocation = _data;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    bool islogin = false;
    Future<bool> _getLoc = _checkPersmission();
    _getLoc.then((e){
      if(islogin==false) {
        islogin=true;
        _auth.loadLogged(other: {
          'latitude': currentLocation.latitude.toString(),
          'longitude': currentLocation.longitude.toString()
        });
      }
    });
    Future.delayed(Duration(seconds: 1), (){
      if(islogin==false){
        islogin = true;
        _auth.loadLogged();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>_auth)
    ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.white,
      ),
      home: new SalashPage()
      ),
    );
  }
}

class SalashPage extends StatefulWidget {
  @override
  _SalashPageState createState() => _SalashPageState();
}

class _SalashPageState extends State<SalashPage> {

  //页面初始化状态的方法
  @override
  void initState() {
    super.initState();
    //开启倒计时
    countDown();
  }

  void countDown() async{
    //设置倒计时三秒后执行跳转方法
    var duration = new Duration(seconds: 3);
    new Future.delayed(duration, goToHomePage);
  }

  void goToHomePage(){
    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>Consumer<AuthModel>(builder: (context, user, child) {
      if (user?.user != null) {
        return new Index();
      }else{
        return new LoginScreen();
      }
    })), (Route<dynamic> rout)=>false);
  }
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: Image.asset("images/sp.png",fit: BoxFit.cover,),//此处fit: BoxFit.cover用于拉伸图片,使图片铺满全屏
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginScreen()));
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Consumer<AuthModel>(
              builder: (context, user, child) {
                return RaisedButton(onPressed: (){
                  user.logout();
                },
                  child: Text('logout'),);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
