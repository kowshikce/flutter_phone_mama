import 'package:flutter/material.dart';

class Jigsaw extends StatefulWidget {
  @override
  _JigsawState createState() => _JigsawState();
}

class _JigsawState extends State<Jigsaw> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _rotationAnimation;

  var isLoaded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _rotationAnimation = Tween<double>(begin: 0, end: 360)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: Container(
            child: GestureDetector(
              onTap: () {
                if (isLoaded) {
                  _controller.forward();
                  isLoaded = !isLoaded;
                } else {
                  _controller.reverse();
                  isLoaded = !isLoaded;
                }
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(color: Colors.orange),
              ),
            ),
          ),
        );
      },
    );
  }
}
