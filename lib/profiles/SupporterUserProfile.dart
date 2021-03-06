import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:artCraftLiving/home_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

int artworkIndex = 0;

class SupportedUserProfile extends StatefulWidget {
  SupportedUserProfile({Key key}) : super(key: key);

  @override
  _SupportedUserProfileState createState() => _SupportedUserProfileState();
}

class _SupportedUserProfileState extends State<SupportedUserProfile> {
  bool _loading = true;
  bool _showabout = false;
  @override
  Future<void> didChangeDependencies() async {
    listArtWorkDetail.clear();
    await FirebaseFirestore.instance
        .collection("ArtWork")
        .orderBy("dateTime", descending: false)
        // ignore: deprecated_member_use
        .getDocuments()
        .then((value) => {
              for (int i = 0; i < value.documents.length; i++)
                {
                  if (value.documents[i]["userUid"] ==
                      supportersList[userIndex].userUid)
                    listArtWorkDetail.add(ArtWorks(
                      pics: value.documents[i]["imageUrls"],
                      tittle: value.documents[i]["tittle"],
                      technique: value.documents[i]["technique"],
                      docId: value.documents[i].documentID,
                      size: value.documents[i]["size"],
                      year: value.documents[i]["year"],
                      aboutArt: value.documents[i]["aboutArt"],
                      userUid: value.documents[i]["userUid"],
                      price: value.documents[i]["price"],
                      sold: value.documents[i]["sold"],
                      userDocid: supportersList[userIndex].userDocid,
                      buyeruserUid: value.documents[i]["buyerUid"],
                      buyerdocId: value.documents[i]["buyerdocId"],
                    ))
                }
            });
    setState(() {
      _loading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      NetworkImage(supportersList[userIndex].userpic),
                  radius: 40,
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supportersList[userIndex].username,
                      style: TextStyle(fontSize: 22),
                    ),
                    if (_showabout)
                      Column(
                        children: [
                          SingleChildScrollView(
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 200,
                                height: 100,
                                child: AutoSizeText(
                                  supportersList[userIndex].about,
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey[600]),
                                  maxLines: 100,
                                ),
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     setState(() {
                          //       _showabout = false;
                          //     });
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         'See less',
                          //         style: TextStyle(
                          //             color: Colors.grey[600],
                          //             fontSize: 13,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    if (!_showabout)
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        child: LayoutBuilder(builder: (context, size) {
                          final span = TextSpan(
                            text: supportersList[userIndex].about,
                          );
                          final tp = TextPainter(
                              text: span,
                              maxLines: 1,
                              textDirection: TextDirection.rtl);
                          tp.layout(maxWidth: size.maxWidth);

                          if (tp.didExceedMaxLines) {
                            // The text has more than three lines.
                            // TODO: display the prompt message

                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      supportersList[userIndex].about,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _showabout = true;
                                      });
                                    },
                                    child: Text(
                                      '...See more',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Text(
                              supportersList[userIndex].about,
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.grey[600]),
                            );
                          }
                        }),
                      ),
                  ],
                ),
              ],
            ),
            FlatButton(
                onPressed: () async {
                  var url = "https://www.instagram.com/" +
                      supportersList[userIndex].instagram +
                      "/";

                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      universalLinksOnly: true,
                    );
                  } else {
                    throw 'There was a problem to open the url: $url';
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/insta.jpeg"))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Visit Instagram Profile"),
                    )
                  ],
                )),
            Divider(),
            SizedBox(height: 30),
            Container(
                height: MediaQuery.of(context).size.height / 1.8,
                width: MediaQuery.of(context).size.width,
                child: _loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        itemCount: listArtWorkDetail.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          // mainAxisSpacing: 10,
                          crossAxisSpacing: 2,
                          // childAspectRatio: 0.6,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              artworkIndex = index;
                              Navigator.pushReplacementNamed(
                                  context, USERS_ARTWORK);
                            },
                            child: _art(
                                listArtWorkDetail[index].pics[0],
                                USERS_ARTWORK,
                                context,
                                listArtWorkDetail[index].sold),
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}

Widget _art(String image, String routeName, BuildContext context, bool sold) {
  return Stack(
    children: [
      Center(
        child: Container(
          child: CachedNetworkImage(
            height: 200,
            fit: BoxFit.cover,
            imageUrl: image,
            placeholder: (context, url) =>
                Center(child: new CircularProgressIndicator()),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ),
      ),
      if (sold)
        Center(
            child: Container(
          color: Colors.black.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "SOLD",
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ))
    ],
  );
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key key,
    this.trimLines = 2,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = Colors.blue;
    final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: _readMore ? "... read more" : " read less",
        style: TextStyle(
          color: colorClickableText,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(
              color: widgetColor,
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
