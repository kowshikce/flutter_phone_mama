import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/animation.dart';

class GridViewItem extends StatefulWidget {
  @override
  _GridViewItemState createState() => _GridViewItemState();
}

class _GridViewItemState extends State<GridViewItem>
    with SingleTickerProviderStateMixin {
  var _isFavourite = false;
  var _init = true;

  AnimationController _controller;
  Animation<Size> heightAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 272), end: Size(double.infinity, 330))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInCirc));
    heightAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final itemWidth = mediaQuery.size.width / 2.5;
    // (mediaQuery.size.height - mediaQuery.padding.top) / 3
    return GestureDetector(
      onTap: () async {
        if (_init) {
          await _controller.forward();
          await _controller.reverse();
        } else {
          _controller.reverse();
          _init = true;
        }
      },
      child: Container(
        height: heightAnimation.value.height,
        width: itemWidth,
        child: Card(
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                        child: FadeInImage.memoryNetwork(
                            fit: BoxFit.fitWidth,
                            placeholder: kTransparentImage,
                            image:
                                "https://i.gadgets360cdn.com/large/samsunggalaxya7small_1537274788144.jpg??downsize=278:209&output-quality=80"),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38, width: 0),
                            color: Colors.black38),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white70,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            FittedBox(
                              child: Text(
                                "115K",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.white70, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: itemWidth,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0, color: Colors.black26),
                            color: Colors.black38),
                        child: Text(
                          "Samsung galaxy A7 (2018)",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                              fontSize: 20),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 5,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        child: Row(
                          children: <Widget>[
                            Center(
                              child: Icon(
                                Icons.star,
                                size: 24,
                                color: Colors.amber,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Center(
                              child: Text(
                                "4.3",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Center(
                        child: Text(
                          "280\$",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.blueAccent, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Center(
                        child: Text(
                          "380\$",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                              letterSpacing: 0,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isFavourite = !_isFavourite;
                          });
                        },
                        child: Center(
                          child: Icon(
                            (_isFavourite)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
