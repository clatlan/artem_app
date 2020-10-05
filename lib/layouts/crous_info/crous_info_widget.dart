import 'package:artem_app/layouts/common/loader.dart';
import 'package:flutter/material.dart';
import '../../services/models/data_factory.dart';
import '../../services/models/crous_entry.dart';

class CrousInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<List<CrousEntry>> entries = DataFactory().fetchCrousEntries();
    return FutureBuilder<List<CrousEntry>>(
      future: entries,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Infos Crous"),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: CrousInfoListView(crousInfoList: snapshot.data),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return Loader();
        }
      },
    );
  }
}

class CrousInfoListView extends StatelessWidget {
  final List<CrousEntry> crousInfoList;

  CrousInfoListView({Key key, @required this.crousInfoList});

  Widget makeCrousInfoWidget(crousEntry) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.info,
                color: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(crousEntry.title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: SelectableText(
                crousEntry.body,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: crousInfoList.map((crousEntry) {
      return makeCrousInfoWidget(crousEntry);
    }).toList());
  }
}
