import 'package:flutter/material.dart';

class AniWidget extends StatefulWidget {
  @override
  _AniWidgetState createState() => _AniWidgetState();
}

class _AniWidgetState extends State<AniWidget> {
  bool _isSeleted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSeleted = !_isSeleted;
        });
      },
      child: AnimatedContainer(
        width: _isSeleted ? 200 : 100,
        height: _isSeleted ? 200 : 100,
        color: _isSeleted ? Colors.greenAccent : Colors.red,
        alignment:
            _isSeleted ? Alignment.center : AlignmentDirectional.topCenter,
        duration: Duration(seconds: 2),
        curve: Curves.easeIn,
        child: FlutterLogo(
          size: 75,
        ),
      ),
    );
  }
}
