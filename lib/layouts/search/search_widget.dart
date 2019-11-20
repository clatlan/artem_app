import 'package:artem_app/services/models/data_factory.dart';
import 'package:artem_app/services/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[Background(), ForeGround()],
    );
  }
}

class ForeGround extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForeGroundState();
}

class ForeGroundState extends State<ForeGround> {
  String searchQuery;
  final searchText = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchText.addListener(() => setState(() => searchQuery = searchText.text));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          child: SearchBar(searchText: searchText),
        ),
        Expanded(child: SearchResult(searchQuery: searchQuery))
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  final searchText;

  SearchBar({Key key, @required this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: ClipRect(
            child: TextField(
            controller: searchText,
            decoration: InputDecoration(
              hintText: "Etudiants, Associations ou évènements",
                hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink[300]),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink),
                borderRadius: BorderRadius.all(Radius.circular((25.0))),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
            ),
          ),
        ));
  }
}

class SearchResult extends StatelessWidget {
  final String searchQuery;

  SearchResult({Key key, @required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataFactory = DataFactory();
    final Future<List<User>> users =
        dataFactory.fetchUsers(startsWith: searchQuery);
    return FutureBuilder(
      future: users,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) =>
                ResultEntry(user: snapshot.data[index]),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

class ResultEntry extends StatelessWidget {
  final User user;

  ResultEntry({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: 400,
          height: 100,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Center(child: user.school.image()),
              Spacer(flex: 1),
              Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(user.firstName + ' ' + user.lastName,
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17))),
                      Text(user.unionsString())
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class TextWithPadding extends StatelessWidget {
  final String text;
  final double padding;

  TextWithPadding({Key key, @required this.text, @required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: padding), child: Text(text));
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/BlurArtem.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
