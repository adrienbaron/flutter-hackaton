import 'package:flutter/material.dart';

class MatchCard {
  int redColor = 0;
  int greenColor = 0;
  int blueColor = 0;
  double margin = 0;

  MatchCard(int red, int green, int blue, double marginTop) {
    redColor = red;
    greenColor = green;
    blueColor = blue;
    margin = marginTop;
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Choose Your Mentor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> cardList;

  void _removeCard(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardList = _getMatchCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: cardList,
        ),
      ),
    );
  }

  List<Widget> _getMatchCard() {
    List<MatchCard> cards = new List();
    cards.add(MatchCard(255, 255, 255, 0));
    cards.add(MatchCard(255, 255, 255, 20));
    cards.add(MatchCard(255, 255, 255, 30));

    List<Widget> cardList = new List();

    for (int x = 0; x < 3; x++) {
      cardList.add(Positioned(
        top: cards[x].margin,
        child: Draggable(
          onDragEnd: (drag) {
            _removeCard(x);
          },
          childWhenDragging: Container(),
          feedback: Card(
            elevation: 12,
            color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor,
                cards[x].blueColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 340,
              height: 500,
            ),
          ),
          child: Card(
            elevation: 12,
            color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor,
                cards[x].blueColor),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    'description',
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
          ),
        ),
      ));
    }
    return cardList;
  }
}
