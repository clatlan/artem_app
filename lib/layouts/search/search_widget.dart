import 'package:artem_app/layouts/common/background.dart';
import 'package:artem_app/layouts/common/loader.dart';
import 'package:artem_app/services/models/data_factory.dart';
import 'package:artem_app/services/models/event.dart';
import 'package:artem_app/services/models/union.dart';
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

class CardData {
  final image;
  final title;
  final text;
  CardData({Key key, this.image, this.title, this.text});

  factory CardData.fromUser (User user){
    return CardData(image: user.school.image(), title: user.firstName + ' ' + user.lastName,text : '' );
  }

  factory CardData.detectType (data) {
    if (data.runtimeType == User) {
      return CardData.fromUser(data);
    }
    else {
      return CardData.fromUnion(data);
    }

  }

  factory CardData.fromUnion (Union union) {
    return CardData(image: union.school.image(), title: union.fullName(), text: '');
  }

}

class ForeGroundState extends State<ForeGround> {
  String loadedTextQuery;
  final searchText = TextEditingController();
  final dataFactory = DataFactory();
  bool finishedLoading = false;
  bool needsReload = true;
  Future<List> data;
  int selectedIndex = 0;

  Function selectButtonOfIndexCallback(index) {
    return (() => setState(() {
      this.selectedIndex = index;
      needsReload = true;
    }));
  }

  @override
  void initState() {
    super.initState();
    searchText.addListener(() {
      if (searchText.text != loadedTextQuery)
        setState(() => {
          needsReload = true
        });
    });
  }


  @override
  Widget build(BuildContext context) {
    if (needsReload) {
      print(selectedIndex);
      data = [dataFactory.fetchUsers, dataFactory.fetchUnions][this.selectedIndex](startsWith: searchText.text);

      finishedLoading = false;
      data.whenComplete(() {
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
        SearchSelectType(selectButtonOfIndexCallback: this.selectButtonOfIndexCallback, selectedButton: this.selectedIndex,),
        SearchResult(data: data, finishedLoading: this.finishedLoading)
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
          alignment: Alignment.topCenter,
          child: TextField(
            controller: searchText,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xffffffff),
              hintText: "Etudiants, Associations ou évènements...",
              hintStyle:
                  TextStyle(color: Colors.pink.withOpacity(0.6)),
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

class ButtonSelectType extends StatelessWidget {
  final String buttonText;
  final Function buttonCallback;
  final bool isSelected;

  ButtonSelectType(this.buttonText, this.buttonCallback, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonCallback,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class SearchSelectType extends StatefulWidget {

  final int selectedButton;
  Function selectButtonOfIndexCallback;

  SearchSelectType({Key key, @required this.selectedButton, @required this.selectButtonOfIndexCallback})
      : super(key: key);


  @override
  _SearchSelectTypeState createState() => _SearchSelectTypeState();
}

class _SearchSelectTypeState extends State<SearchSelectType> {



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ButtonSelectType(
            'Etudiant',
            this.widget.selectButtonOfIndexCallback(0),
            this.widget.selectedButton == 0,
          ),
          ButtonSelectType(
            'Association',
            this.widget.selectButtonOfIndexCallback(1),
            this.widget.selectedButton == 1,
          ),
        ],
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final Future<List> data;
  bool finishedLoading;

  SearchResult({Key key, @required this.data, @required this.finishedLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasData && finishedLoading) {
          return Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var cardData = CardData.detectType(snapshot.data[index]);
              return ResultEntry(data: cardData);
                },
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
  final CardData data;

  ResultEntry({Key key, @required this.data}) : super(key: key);

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
              Center(child: data.image),
              Spacer(flex: 1),
              Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(data.title,
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17))),
                      Text(data.text)
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
