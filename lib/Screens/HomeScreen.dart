import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../commom_widgets/GridViewItem.dart';
import '../commom_widgets/Localjigsaw.dart';
import '../commom_widgets/AniKow.dart';
import '../commom_widgets/Fade_widget.dart';
import '../commom_widgets/Fade_Image.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(
        children: [
          FadeImage(),
          SizedBox(
            height: 50,
          ),
          Jigsaw(),
          SizedBox(
            height: 50,
          ),
          AniWidget(),
          SizedBox(
            height: 50,
          ),
          FadeWidget(),
          SizedBox(
            height: 50,
          ),
          GridViewItem(),
          SizedBox(
            height: 50,
          )
        ],
      ),
    )));
  }
}
