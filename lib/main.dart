import 'package:flutter/material.dart';
import 'package:flutter_phone_mama/Screens/DemoImageScreen.dart';
import 'package:flutter_phone_mama/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import './Screens/AuthScreen.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: MaterialApp(
        title: "PhoneMama",
        theme: ThemeData(
            primarySwatch: Colors.amber,
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrangeAccent,
            textTheme: TextTheme(
                headline6: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 25))),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          DemoImageScreen.routeName: (ctx) => DemoImageScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PhoneMama",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: HomeScreen(),
      ),
    );
  }
}
