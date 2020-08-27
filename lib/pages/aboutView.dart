import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Image.asset(
        'assets/logo.jpg',
        width: 600,
        height: 240,
        fit: BoxFit.cover,
      ),
      titleSection,
      textSection,
      Divider(),
      sponzorji,
    ]);
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Momci Space Program',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Maribor, Slovenija',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Text('Potrjeni jebači '),
      Icon(
        Icons.done_all,
        color: Colors.green[500],
      ),
    ],
  ),
);

Widget textSection = Container(
  padding: const EdgeInsets.all(20),
  child: Text(
    'Momci Space Program je kulminacije raketnega modelarstva republik bivše Jugoslavije. MSA sam oblikuje, izdeluje ter lansira najsodobnejše raketne modele. Uporabljamo iterativni pristop k rayvoju in oblikovanju rešitev. Združuje nas vrhunsko znanje programiranja PID sistemov ter večletne izkušnje s 3D tiskom.',
    softWrap: true,
  ),
);

Widget sponzorji = Container(
  padding: const EdgeInsets.all(25.0),
  height: 300,
  child: Column(children: [
    Text(
      'Sponzorji',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: 20,
    ),
    Card(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 50,
              child: Image.asset(
                'assets/benis.png',
              ),
            ),
            Text(
              "Okrepčevalnica Benis",
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    ),
  ]),
);
