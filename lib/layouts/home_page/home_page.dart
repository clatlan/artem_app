import 'package:artem_app/layouts/profile/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:artem_app/layouts/common/background.dart';
import 'package:artem_app/layouts/event/event_widget.dart';

class HomePage extends StatelessWidget {
  final Function redirectToSearch;

  HomePage(this.redirectToSearch);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[Background(), HomePageFGrd(redirectToSearch)],
    );
  }
}

class HomePageFGrd extends StatelessWidget {
  final Function redirectToSearch;

  HomePageFGrd(this.redirectToSearch);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 60),
            child: Text(
              "Quoi de neuf à Artem ?",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: EdgeInsets.all(10),
          child: EventWidget(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.4,
                    duration: Duration(seconds: 2),
                    curve: Curves.easeIn,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.pink,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ProfileWidget();
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.account_box,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              "Accéder à mon profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                  duration: Duration(seconds: 2),
                  curve: Curves.easeIn,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    child: InkWell(
                      onTap: () {
                        redirectToSearch();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 40,
                          ),
                          Text(
                            "Rechercher",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
