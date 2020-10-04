import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import '../../services/models/event.dart';
import '../../services/models/user.dart';
import '../../services/models/role.dart';
import '../../services/models/data_factory.dart';
import '../../services/auth_service.dart';
import '../common/union_page.dart';
import 'add_event_page.dart';

class EventPreview extends StatelessWidget {
  final Event event;

  EventPreview({Key key, @required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return EventWidget(event: event);
          },
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.8),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: event.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Ink.image(
                      image: Image.file(event.image).image,
                      fit: BoxFit.cover,
                      child: InkWell(
                        highlightColor: Color.fromRGBO(50, 50, 50, 0.5),
                        splashColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EventWidget(event: event);
                            },
                          );
                          // show the full page
                        },
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          event.name,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          Icon(
                            Icons.event,
                            color: Colors.pink,
                          ),
                          (event.timeStart != null)
                              ? Text(
                                  DateFormat.yMMMMd("fr_FR")
                                      .format(event.timeStart),
                                  style: TextStyle(fontSize: 16))
                              : Text("date à définir"),
                          Spacer(),
                          Icon(
                            Icons.place,
                            color: Colors.pink,
                          ),
                          Text(
                            event.place,
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                                0.5,
                                1
                              ],
                              colors: [
                                Colors.black,
                                Colors.transparent,
                              ]).createShader(bounds),
                          child: RichText(
                            textAlign: TextAlign.justify,
                            maxLines: 6,
                            text: TextSpan(
                                text: event.description,
                                style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Text("En savoir plus",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class EventWidget extends StatelessWidget {
  final Event event;

  EventWidget({Key key, @required this.event});

  List<Widget> informationWidgetsList(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Center(
            child: Text(
          event.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.event,
                color: Colors.pink,
                size: 24,
              ),
              Text(
                DateFormat.yMMMMd("fr_FR").format(event.timeStart),
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Icon(Icons.location_on, color: Colors.pink, size: 24),
              Text(
                event.place,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Row(
            children: <Widget>[
              Text(
                "Organisé par : ",
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  border: Border.all(width: 0.2, color: Colors.grey),
                ),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(200),
                    ),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return UnionPage(union: event.union);
                          },
                        );
                      },
                      child: event.union.logo != null
                          ? Image.asset(
                              'assets/images_test/BDE.png',
                              fit: BoxFit.fill,
                            )
                          : Center(
                              child: Text(
                                event.union.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            "Informations",
            style: TextStyle(
                fontSize: 20,
                color: Colors.pink,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
      Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SelectableText(
            event.description,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      SizedBox(
        height: 40,
      )
    ];
  }

  Widget imageWidget(BuildContext context) {
    return Container(
        child: event.image != null
            ? Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: Ink.image(
                    image: Image.file(event.image).image,
                    fit: BoxFit.cover,
                    child: InkWell(
//                        child: Image.file(event.image, fit: BoxFit.scaleDown),
                      highlightColor: Color.fromRGBO(50, 50, 50, 0.5),
                      splashColor: Colors.transparent,
                    ),
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
              child: event.image != null
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
          event.image != null
              ? Positioned(
                  top: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Scaffold(
                              body: Stack(
                                children: <Widget>[
                                  PhotoView(
                                    imageProvider:
                                        Image.file(event.image).image,
////                              fit: BoxFit.contain,
//                          image: Image.file(event.image).image,
                                  ),
                                  Positioned(
                                    top: 10.0,
                                    left: 10.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 32.0),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Colors.grey[700],
                                              width: 0.8),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(0, 0))
                                          ],
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.arrow_back,
                                              color: Colors.grey[700]),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              : Container(),
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
          Positioned(
              top: -10.0,
              right: 10.0,
              child: EditButton(eventTobeEdited: event))
        ],
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final Event eventTobeEdited;

  EditButton({Key key, @required this.eventTobeEdited});

  bool canEdit(User user) {
    for (Role role in user.roles) {
      if (role.canPublish && role.union.name == eventTobeEdited.union.name) {
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
                icon: Icon(Icons.edit, color: Colors.grey[700]),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddEvent(
                        user: snapshot.data,
                        eventToBeEdited: eventTobeEdited,
                      );
                    },
                  );
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
