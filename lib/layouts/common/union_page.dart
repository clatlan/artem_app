import 'package:flutter/material.dart';

import './union_members_carousel.dart';
import 'edit_union.dart';
import '../../services/models/union.dart';
import '../../services/models/role.dart';
import '../../services/models/data_factory.dart';
import '../../services/auth_service.dart';
import '../../services/models/user.dart';

class UnionPage extends StatelessWidget {
  final Union union;

  UnionPage({Key key, @required this.union});

  List<Widget> informationWidgetsList(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.height * 0.18,
              margin: const EdgeInsets.only(bottom: 6.0),
              decoration: BoxDecoration(
                border: Border.all(width: 0.4, color: Colors.grey),
                borderRadius: BorderRadius.all(
                  Radius.circular(200),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: union.logo != null
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
//                        image: Image.asset('assets/images_test/BDE.png').image,
                          image: union.logo.image,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          union.name ?? "Aucun nom défini.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
      union.logo == null
          ? Center(
              child: Text(
                union.name,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            )
          : Container(),
      Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 16),
          child: Center(
            child: Icon(
              Icons.info,
              size: 40,
              color: Colors.blue,
            ),
          )),
      Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SelectableText(
            union.description ?? "Aucune description définie.",
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: UnionMembersCarousel(union: union),
      ),
      EditButton(unionTobeEdited: union),
      SizedBox(
        height: 40,
      )
    ];
  }

  Widget imageWidget(BuildContext context) {
    return Container(
        child: union.image != null
            ? Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: Ink.image(
                    image: union.image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : null);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(top: 0, child: imageWidget(context)),
          Positioned(
            top: 0,
            child: Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: union.image != null
                  ? DraggableScrollableSheet(
                      initialChildSize: 0.55,
                      minChildSize: 0.55,
                      maxChildSize: 0.9,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey[700], width: 0.4),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 0))
                            ],
                          ),
                          child: ListView(
                              controller: scrollController,
                              children: informationWidgetsList(context)
//
                              ),
                        );
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: ListView(
                        children: informationWidgetsList(context),
                      ),
                    ),
            ),
          ),
          Positioned(
            top: -10.0,
            left: 10.0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[700], width: 0.8),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 0))
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
//          Positioned(
//              top: -10.0,
//              right: 10.0,
//              child: EditButton(unionTobeEdited: union))
        ],
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final Union unionTobeEdited;

  EditButton({Key key, @required this.unionTobeEdited});

  bool canEdit(User user) {
    for (Role role in user.roles) {
      if (role.canPublish && role.union.name == unionTobeEdited.name) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Future<User> user =
        DataFactory().fetchUser(AuthService().currentUser());
    return FutureBuilder<User>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.hasData && canEdit(snapshot.data)) {
          return Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              elevation: 2,
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              label: Text(
                "Modifier la page",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditUnion(union: unionTobeEdited);
                  },
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
