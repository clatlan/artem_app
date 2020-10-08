import 'dart:async';
import 'dart:convert';
import 'package:artem_app/services/models/crous_entry.dart';
import 'package:artem_app/services/models/event.dart';
import 'package:http/http.dart' as http;
import '../../services/variables.dart' as globals;
import './user.dart';
import './union.dart';
import '../../services/auth_service.dart';

class DataFactory {
  final auth = AuthService();

  Future<User> fetchUser(int i) async {
    final response = await http.get(
      globals.endpoint + '/api/v1/users/' + i.toString(),
      headers: {'Authorization': auth.jwt()},
    );

    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      return User.fromJson(user['user']);
    } else {
      // If that call was not successful, throw an error.
      throw Exception(globals.standardErrorMessage);
    }
  }

  Future<List<Union>> fetchUnions({startsWith = '', pageNumber = 0}) async {
    final response = await http.get(
      globals.endpoint +
          '/api/v1/unions?starts_with=' +
          startsWith +
          '&page_number=' +
          pageNumber.toString(),
      headers: {'Authorization': auth.jwt()},
    );

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      List<Union> unions = [];
      for (var i = 0; i < list.length; i++) {
        unions.add(Union.fromJson(list[i]['union']));
      }
      return unions;
    } else {
      // If that call was not successful, throw an error.
      throw Exception(globals.standardErrorMessage);
    }
  }

  Future<List> searchAll() {}

  Future<List<User>> fetchUsers({startsWith = '', pageNumber = 0}) async {
    final response = await http.get(
      globals.endpoint +
          '/api/v1/users?starts_with=' +
          startsWith +
          '&page_number=' +
          pageNumber.toString(),
      headers: {'Authorization': auth.jwt()},
    );

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      List<User> users = [];
      for (var i = 0; i < list.length; i++) {
        users.add(User.fromJson(list[i]['user']));
      }
      return users;
    } else {
      // If that call was not successful, throw an error.
      throw Exception(globals.standardErrorMessage);
    }
  }

  Future<List<CrousEntry>> fetchCrousEntries() async {
    final response = await http.get(
      globals.endpoint + '/api/v1/crous_entries',
      headers: {'Authorization': auth.jwt()},
    );

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      List<CrousEntry> crousEntries = [];
      for (var i = 0; i < list.length; i++) {
        crousEntries.add(CrousEntry.fromJson(list[i]['crous_entry']));
      }
      return crousEntries;
    } else {
      // If that call was not successful, throw an error.
      throw Exception(globals.standardErrorMessage);
    }
  }

  Future<List<Event>> fetchEvents({onlyFutureEvents = false}) async {
    final response = await http.get(
      globals.endpoint + '/api/v1/events',
      headers: {'Authorization': auth.jwt()},
    );

    if (response.statusCode == 200) {
      var list = json.decode(response.body);
      List<Event> events = [];
      for (var i = 0; i < list.length; i++) {
        events.add(Event.fromJson(list[i]['event']));
      }
      if (onlyFutureEvents) {
        Event todayEvent = Event(name: "Today is today");
        events.add(todayEvent);
        events.sort((eventA, eventB) {
          return eventA.timeStart.compareTo(eventB.timeStart);
        });
        int cuttingIndex = 0;
        for (int i = 0; i < events.length; i++){
          if (events[i].id == todayEvent.id){
            cuttingIndex = i;
          }
        }
        return events.sublist(cuttingIndex + 1, events.length);
      } else {
        events.sort((eventA, eventB) {
          return eventA.timeStart.compareTo(eventB.timeStart);
        });
        return events;
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception(globals.standardErrorMessage);
    }
  }

  createOrUpdateEvent(Event event) async {
    final response = await http.post(
      globals.endpoint + '/api/v1/events',
      headers: {'Authorization': auth.jwt()},
      body: {event: event.toJson()}.toString(),
    );

    return response.statusCode;
  }
}
