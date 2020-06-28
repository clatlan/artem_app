import 'package:artem_app/services/models/school.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

import 'package:artem_app/layouts/event/event_widgets.dart';
import 'package:artem_app/layouts/profile/my_profile.dart';
import 'package:artem_app/layouts/common/background.dart';

import '../../services/models/event.dart';
import '../../services/models/union.dart';
import '../../services/models/user.dart';
import '../../services/models/role.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/image.png');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

//Future<File> f = getImageFileFromAssets('assets/images');

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

class HomePageFGrd extends StatefulWidget {
  final Function redirectToSearch;

  HomePageFGrd(this.redirectToSearch);

  @override
  _HomePageFGrdState createState() => _HomePageFGrdState();
}

class _HomePageFGrdState extends State<HomePageFGrd> {
  Future<File> image;
  List<User> users = [
    User(
      firstName: "Aymeric",
      lastName: "Zigues",
      roles: [Role(name: "Président", union: Union(name: "BDE Ensad"))],
    ),
    User(
        firstName: "Clément",
        lastName: "Atlan",
        roles: [Role(name: "Trésorier", union: Union(name: "BDE Ensad"))]
    ),
    User(
        firstName: "Emilien",
        lastName: "Ouzeri",
        roles: [Role(name: "Secrétaire Général", union: Union(name: "BDE Ensad"))]
    ),
    User(
        firstName: "Théo",
        lastName: "Carciente",
        roles: [Role(name: "Relations Alumni", union: Union(name: "BDE Ensad"))]
    ),
    User(
        firstName: "Arnaud",
        lastName: "Giron",
        roles: [Role(name: "Pôle Communication", union: Union(name: "BDE Ensad"))]
    )
  ];

  @override
  void initState() {
    super.initState();
    image = getImageFileFromAssets('images_test/24hdeStan.png');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: image,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Event> events = [
            Event(
              name: "Gala Mines Nancy",
              timeStart: DateTime.parse("2020-06-04 20:00:00Z"),
              timeEnd: DateTime.parse("2020-06-05 05:00:00Z"),
              place: "Campus Artem",
              description: """
    Comme vous le savez, notre très chère coloc adore recevoir et trouve toujours de bonnes raisons pour faire la fête tous ensemble.
      En ce début d’année 2020, de multiples occasions nous poussent à organiser une ÉNORME teuf.
      Voici les occasions (liste non exhaustive - les organisateurs se réservent le droit d’ajouter des éléments à tout moment) :
      - 2020 c’est cool
      - Milouche atteint tranquillement son quart de siècle
      - Les tenants du titre de «best couple of the coloc», benbaleon, se sont pacsés
      - Du renfort débarque dans l’équipe de Milouche pour décrocher le titre car Jubin va enfin payer un loyer
      - Le café gagnant débarque au RCS (http://www.le-cafe-gagnant.fr/ - Si tu t’inscris pas t’es un batard)
      - Oscar obtient fièrement son jeton des 3 mois sans toucher un kendama
      L’objectif est donc de débuter au mieux cette décennie, sous un thème qui, nous l’espérons, sera au cœur des préoccupations à venir : l’éco-responsabilité. C’est à dire vert. Donc mets-toi au vert et viens en vert. Viens qu’avec du verre et de la verte.
      Des cadeaux seront à gagner #couponsDott #gourdesOFO #kawayOFO""",
              union: Union(name: "BDE Ensad",
              school: School(name: "Ensad"),
              description: "Le Bureau des Élèves de Mines Nancy est une association de loi 1901 dont le but est de gérer la vie associative à l'École des Mines de Nancy ainsi que de faire le lien entre les élèves, les entreprises et les alumni.",
                logo: Image.asset('assets/images_test/BDE.png'),
                image: Image.asset('assets/images_test/Anominous.jpg'),
                members: users,
              ),
              image: snapshot.data,
            ),
            Event(
                name: "Soirée DVA",
                timeStart: DateTime.parse("2020-06-15 22:00:00Z"),
                timeEnd: DateTime.parse("2020-06-16 03:00:00Z"),
                place: "L'NVRS CLUB",
                description: """
              Bonsoir bonsoir c'est nous !
Comme vous le savez un anniversaire en avril ou en mai se fête en juin. Cela va toujours par 3, c'est un peu comme le sel, le poivre et le cumin ou encore Batman, Robin et Albert.
C'est pour cela que vous êtes conviés à une boom birthday party sur notre rooftop de peeeeetits connards parisiens, avec vue sur Tour Eiffel au 34 rue Castagnary 75015 Paris le 6 juin 2020 à l'heure de l'apéro pour fêter les anniversaires de notre charmante Pauline et de l'autre.
ça fera plaisir de tous vous voir.
Il fera beau
Pauline & Ben
(titre du 1er spectacle de Gad Elmaleh )
              """,
                union: Union(name: "Sonomines"))
          ];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    "Quoi de neuf à Artem ?",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
//                color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.4,
                child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.8,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                    ),
                    items: events.map((event) {
                      return EventPreview(event: event);
                    }).toList()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                        duration: Duration(seconds: 2),
                        curve: Curves.easeIn,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pink,
                          elevation: 6,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MyProfile();
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
                                  "Mon profil",
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                        elevation: 6,
                        child: InkWell(
                          onTap: () {
                            widget.redirectToSearch();
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
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
      },
    );
  }
}
