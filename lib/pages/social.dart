import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msa/backend/my_flutter_app_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../backend/my_flutter_app_icons.dart';

class Social extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(children: <Widget>[
        SizedBox(height: 30),
        Text('The MSA team',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 30),
        Contact(
          name: "Luka Pirš",
          position: "Aerospace Engineer",
          profilePictureUrl: 'assets/luka.png',
          twitterUrl: '',
          gitHubUrl: 'https://github.com/luka78',
          linkedinUrl: '',
        ),
        Contact(
          name: "Matija Likar",
          position: "Avionics Engineer",
          profilePictureUrl: 'assets/matija.png',
          twitterUrl: 'https://twitter.com/likar_matija',
          gitHubUrl: 'https://www.linkedin.com/in/matija-likar-77249119a',
          linkedinUrl: 'https://github.com/MatijaLik',
        ),
      ]),
    );
  }
}

class Contact extends StatelessWidget {
  String name;
  String position;
  String profilePictureUrl;

  String twitterUrl;
  String gitHubUrl;
  String linkedinUrl;

  Contact(
      {this.name,
      this.position,
      this.profilePictureUrl,
      this.twitterUrl,
      this.gitHubUrl,
      this.linkedinUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                topRow(),
                Divider(height: 0, indent: 8, endIndent: 8),
                socialIcons(),
              ])),
    );
  }

  Widget topRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        children: <Widget>[
          circularProfilePic(),
          SizedBox(width: 20),
          userLabel(),
        ],
      ),
    );
  }

  Widget circularProfilePic() {
    return Container(
        width: 75.0,
        height: 75.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill, image: AssetImage(profilePictureUrl)),
        ));
  }

  Widget userLabel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*2*/
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            '$name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '$position',
          style: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget socialIcons() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: new Icon(CustomIcons.iconmonstr_twitter_1),
            onPressed: () {
              launch(twitterUrl);
            },
          ),
          IconButton(
            icon: new Icon(CustomIcons.octicons_mark_github),
            onPressed: () {
              launch(gitHubUrl);
            },
          ),
          IconButton(
            icon: new Icon(CustomIcons.linkedin_square_logo),
            onPressed: () {
              launch(linkedinUrl);
            },
          ),
        ],
      ),
    );
  }
}
