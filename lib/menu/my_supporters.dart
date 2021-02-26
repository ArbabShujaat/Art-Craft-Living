import 'package:artCraftLiving/Model/model.dart';
import 'package:artCraftLiving/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

int userIndex = 0;

class MySupporters extends StatefulWidget {
  MySupporters({Key key}) : super(key: key);

  @override
  _MySupportersState createState() => _MySupportersState();
}

class _MySupportersState extends State<MySupporters> {
  bool _loading = true;
  @override
  Future<void> didChangeDependencies() async {
    supportersList.clear();

    await FirebaseFirestore.instance
        .collection("Users")
        .document(userDetails.userDocid)
        .collection("Supporters")
        .getDocuments()
        .then((value2) async {
      print(userDetails.userDocid);
      if (value2.documents.length != 0)
        for (int j = 0; j < value2.documents.length; j++) {
          await FirebaseFirestore.instance
              .collection("Users")
              .where("userUid", isEqualTo: value2.documents[j]['userUid'])

              // ignore: deprecated_member_use
              .getDocuments()
              .then((value) => {
                    for (int i = 0; i < value.documents.length; i++)
                      {
                        supportersList.add(UserDetails(
                          instagram: value.documents[i]["instagram"],
                          about: value.documents[i]["userAbout"],
                          userEmail: value.documents[i]["userEmail"],
                          bonusCredit: value.documents[i]["bonusCredit"],
                          soldCredit: value.documents[i]["soldCredit"],
                          points: value.documents[i]["points"],
                          userUid: value.documents[i]["userUid"],
                          username: value.documents[i]["userName"],
                          verified: value.documents[i]["verified"],
                          firstTime: value.documents[i]["firstTime"],
                          userpic: value.documents[i]["userImage"],
                          userDocid: value.documents[i].documentID,
                        ))
                      }
                  });
        }

      print("entered3");
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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'MySupporters',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: supportersList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (index == 0) {
                            userIndex = 0;
                          } else
                            userIndex = index;
                          Navigator.pushNamed(context, SUPPORTER_USER_PROFILE);
                        },
                        child: member(
                            supportersList[index].userpic,
                            supportersList[index].username,
                            supportersList[index].about,
                            SUPPORTER_USER_PROFILE,
                            context),
                      ),
                      Divider(),
                    ],
                  );
                }),
      ),
    );
  }
}

Widget member(String img, String username, String about, String routeName,
    BuildContext context) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.grey[200],
      backgroundImage: NetworkImage(img),
      radius: 25,
    ),
    title: Text(
      username,
      style: TextStyle(fontSize: 17),
    ),
    subtitle: Text(about),
    // onTap: () {

    // },
  );
}
