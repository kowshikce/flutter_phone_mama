import 'package:flutter/material.dart';
import 'package:flutter_phone_mama/Screens/DemoImageScreen.dart';
import '../helper/custom_route.dart';

class FadeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CustomRoute(
          builder: (ctx) => DemoImageScreen(),
        ));
      },
      child: Container(
        width: 100,
        height: 100,
        child: Hero(
          tag: "BookImage",
          child: FadeInImage(
            placeholder: AssetImage(
              "assets/images/abc.jpg",
            ),
            image: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/1/13/Michael_Mandiberg_and_Jonathan_Kiritharan_with_%27Print_Wikipedia%27%2C_NYC%2C_June_17%2C_2015_-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
