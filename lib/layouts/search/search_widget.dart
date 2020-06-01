import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:artem_app/layouts/common/background.dart';
import 'package:artem_app/layouts/common/loader.dart';
import 'package:artem_app/services/models/data_factory.dart';
import 'package:artem_app/services/models/user.dart';

import 'package:artem_app/layouts/profile/profile_widget.dart';


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
  String loadedTextQuery;
  final searchText = TextEditingController();
  final dataFactory = DataFactory();
  bool finishedLoading = false;
  bool needsReload = true;
  Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    searchText.addListener(() {
      if (searchText.text != loadedTextQuery)
        setState(() => {needsReload = true});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (needsReload) {
      users = dataFactory.fetchUsers(startsWith: searchText.text);
      finishedLoading = false;
      users.whenComplete(() {
        setState(() {
          loadedTextQuery = searchText.text;
          finishedLoading = true;
        });
      });
    }
    needsReload = false;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          child: SearchBar(searchText: searchText),
        ),
        SearchResult(users: users, finishedLoading: this.finishedLoading)
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchText.dispose();
    super.dispose();
  }
}

class SearchBar extends StatelessWidget {
  final searchText;

  SearchBar({Key key, @required this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
            child: Container(
          alignment: Alignment.topCenter,
          child: TextField(
            controller: searchText,
            decoration: InputDecoration(
              hintText: "Etudiants, Associations ou évènements",
              hintStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
        )));
  }
}

class SearchResult extends StatelessWidget {
  final Future<List<User>> users;
  bool finishedLoading;

  SearchResult({Key key, @required this.users, @required this.finishedLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users,
      builder: (context, snapshot) {
        if (snapshot.hasData && finishedLoading) {
          return Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) =>
                ResultEntry(user: snapshot.data[index]),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return Expanded(child: Loader());
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ProfileDialog(user: user);
            },
          );
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
