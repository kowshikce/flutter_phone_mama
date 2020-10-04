import 'package:flutter/material.dart';

class DemoImageScreen extends StatelessWidget {
  static const String routeName = "/demo-image-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.purple,
            expandedHeight: 500,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "BookImage",
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/1/13/Michael_Mandiberg_and_Jonathan_Kiritharan_with_%27Print_Wikipedia%27%2C_NYC%2C_June_17%2C_2015_-1.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                "Image",
                style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -1.2),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 500,
                      ),
                      Text(
                        "Book Image",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.8,
                            letterSpacing: -1.2,
                            color: Colors.orange),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 500,
            ),
          )
        ],
      ),
    );
  }
}
