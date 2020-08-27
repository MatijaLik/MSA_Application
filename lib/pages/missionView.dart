import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

import '../main.dart';
import '../backend/sheetsRequest.dart';

class MissionView extends StatefulWidget {
  MissionView({Key key}) : super(key: key);
  static List<Mission> globalMissions;

  @override
  _MissionViewState createState() => _MissionViewState();
}

class _MissionViewState extends State<MissionView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: MissionView.globalMissions.length,
          itemBuilder: (BuildContext context, int index) {
            return MissionView.globalMissions[index];
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }

  Future<void> _refresh() {
    print("STARTED REFRESH");
    return fetchJsonList().then((_missions) {
      print("ENDED REFRESH");
      setState(() => MissionView.globalMissions = _missions);
    });
  }
}

class Mission extends StatefulWidget {
  String name;
  String description;
  String dateStr;
  String badgeUrl;

  DateTime date;

  Mission({this.name, this.description, this.dateStr, this.badgeUrl});

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
        name: json['name'],
        description: json['description'],
        dateStr: json['date'],
        badgeUrl: json['badgeUrl']);
  }
  @override
  _MissionState createState() => _MissionState();
}

class _MissionState extends State<Mission> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    //Formatira datum
    String formatedDate;
    if (widget.dateStr == '' || widget.dateStr == 'TBD')
      formatedDate = 'TBD';
    else {
      widget.date = DateTime.parse(widget.dateStr);
      formatedDate = DateFormat("dd/MM/yyyy").format(widget.date);
    }

    //ce ni slike uporabi default logo
    Widget img;
    if (widget.badgeUrl == '')
      img = Image.asset('assets/logo.jpg');
    else
      img = CachedNetworkImage(
        placeholder: (context, url) => Image.asset('assets/logo.jpg'),
        imageUrl: widget.badgeUrl,
      );

    DateTime temp = widget.date;
    final Event event = Event(
      title: widget.name,
      description: widget.description,
      location: 'Maribor, Slovenija',
      startDate: temp.add(Duration(days: 1)),
      endDate: widget.date,
      allDay: true,
    );

    Widget front = Card(
      child: Container(
        height: 85,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
            cardKey.currentState.toggleCard();
          },
          child: Container(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              leading: Container(width: 75, height: 75, child: img),
              title: Text(widget.name),
              subtitle: Text(widget.description),
              trailing: Text('$formatedDate'),
            ),
          ),
        ),
      ),
    );

    Widget back = Card(
      //padding: EdgeInsets.all(8),

      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () => {
          print("Background tapped"),
          cardKey.currentState.toggleCard(),
        },
        child: Container(
          padding: EdgeInsets.all(8),
          height: 85,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 120,
                padding: EdgeInsets.all(10),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () => {Add2Calendar.addEvent2Cal(event)},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      SizedBox(height: 5),
                      Text("Add to calendar"),
                    ],
                  ),
                ),
              ),
              Container(
                width: 120,
                padding: EdgeInsets.all(10),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () => {Add2Calendar.addEvent2Cal(event)},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.format_list_bulleted),
                      SizedBox(height: 5),
                      Text("Description"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return FlipCard(
      direction: FlipDirection.VERTICAL,
      key: cardKey,
      flipOnTouch: false,
      front: front,
      back: back,
    );
  }
}
