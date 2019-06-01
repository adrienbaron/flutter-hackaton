import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentor/models/request.dart';

const double _kTopMargin = 10.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> cardList = <Widget>[];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Firestore.instance
          .collection("Requests")
          .where("userId", isEqualTo: 123)
          .snapshots()
          .listen((data) {
        cardList = data.documents.map((document) {
          Request request = Request.fromMap(document.data);

          return Positioned(
            top: _kTopMargin,
            child: Draggable(
              onDragEnd: (drag) {
                _removeCard();
              },
              childWhenDragging: Container(),
              feedback: Card(
                elevation: 12,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: 340,
                  height: 500,
                ),
              ),
              child: RequestCard(
                red: 255,
                green: 255,
                blue: 255,
                requestText: request.text,
              ),
            ),
          );
        }).toList();
        setState(() {});
      });
    });
  }

  void _removeCard() {
    setState(() {
      cardList.removeAt(cardList.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Title"),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: cardList,
        ),
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  RequestCard({
    Key key,
    this.red,
    this.green,
    this.blue,
    this.requestText,
  }) : super(key: key);

  final int red;
  final int green;
  final int blue;
  final String requestText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      color: Color.fromARGB(255, red, green, blue),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 340,
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueGrey.shade500,
              backgroundImage: AssetImage('images'),
            ),
            Text(
              'Name',
              style: TextStyle(
                fontFamily: 'Pacifico',
                color: Colors.black,
                fontSize: 35,
              ),
            ),
            Text(
              'MY EMAIL',
              style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  color: Colors.blueGrey.shade800,
                  fontSize: 20,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Text(
              requestText,
              style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  color: Colors.blueGrey.shade800,
                  fontSize: 20,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
