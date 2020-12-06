import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';


class MySoldArtwork extends StatefulWidget {
  MySoldArtwork({Key key}) : super(key: key);

  @override
  _MySoldArtworkState createState() => _MySoldArtworkState();
}

class _MySoldArtworkState extends State<MySoldArtwork> {
  
  bool review = false;
  
  @override
  Widget build(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width =  MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Art Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
                child: Container(
                  height: height / 2.5,
                  width: width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Carousel(
                      overlayShadow: false,
                      dotBgColor: Colors.transparent,
                      autoplay: false,
                      dotIncreaseSize: 3,
                      dotSize: 5,
                      // dotSpacing: 30,

                      dotIncreasedColor: Colors.white,
                      dotColor: Colors.black,
                      images: [
                        Image.asset(
                          "assets/art2.jpeg",
                          fit: BoxFit.fill,
                        ),
                        Image.asset(
                          "assets/art1.jpg",
                          fit: BoxFit.fill,
                        ),
                        Image.asset(
                          "assets/art3.jpg",
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ListTile(
              title: Text('Title'),
              subtitle: Text('Title'),
            ),
            ListTile(
              title: Text('Price'),
              subtitle: Text('Price'),
              trailing: Text('Size: size'),
            ),
            // ListTile(
            //   title: Text('Size'),
            //   subtitle: Text('Size'),
            // ),
            ListTile(
              title: Text('Technique'),
              subtitle: Text('Technique'),
              trailing: Text('Year: 2020'),
            ),
            // ListTile(
            //   title: Text('Year'),
            //   subtitle: Text('Year'),
            // ),
            ListTile(
              title: Text('About Art'),
              subtitle: Text('About Art'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _art(String image, String routeName, BuildContext context) {
  return InkWell(
    child: Container(
        child: Image(
      image: AssetImage(image),
      height: 200,
      fit: BoxFit.cover,
    )),
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
  );
}
