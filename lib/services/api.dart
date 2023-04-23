import 'dart:convert';
import 'dart:io';
import 'package:frontend/models/fitness_session.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/class_info.dart';
import 'package:frontend/models/user_ranking.dart';
import 'package:frontend/models/subscription.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String BASE_API_URL = 'europe-west2-msp-gym.cloudfunctions.net';

  Future<User> fetchUser({required String userId}) async {
    Uri uri = Uri.https(
      BASE_API_URL,
      '/app/users/$userId',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      User user = User.fromMap(data);

      return user;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<http.Response> createUser(String name, String email, String userId) async {
    Uri uri = Uri.https(BASE_API_URL, '/app/users');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.post(uri, body: json.encode({"id": userId, "plan": "unsubscribed",
      "birthdate": "2000-01-01T00:00:00Z",
      "name": name,
      "weight": 70,
      "email": email,
      "height": 1750,
      "role": "user"}), headers: headers);
    return response;
  }

  Future<http.Response> updateUser({required User user}) async {
    Uri uri = Uri.https(BASE_API_URL, '/app/users/${user.userId}');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': user.userId,
    };

    var response = await http.put(uri, body: json.encode(user.toJson()), headers: headers);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<http.Response> deleteUser(String uid) async {
    final response =
        await http.delete(Uri.parse(BASE_API_URL + '/app/users/' + uid));
    return response;
  }

  Future<http.Response> createFitnessSession(
      FitnessSession fitnessSession, String userId) async {
    Uri uri = Uri.https(BASE_API_URL, '/app/metrics');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    var response =
        await http.post(uri, body: json.encode(fitnessSession.toJson()), headers: headers);
    return response;
  }

  Future<http.Response> deleteFitnessSession(int id) async {
    final response = await http
        .delete(Uri.parse(BASE_API_URL + 'app/metrics/' + id.toString()));
    return response;
  }

  Future<List<FitnessSession>> fetchFitnessSessions(
      {required String userId}) async {
    Uri uri = Uri.https(
      BASE_API_URL,
      '/app/metrics',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<FitnessSession> fitnessSessions =
          data.map((item) => FitnessSession.fromJson(item)).toList();

      return fitnessSessions;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<FitnessSession> fetchFitnessSession({required int id}) async {
    Uri uri = Uri.https(
      BASE_API_URL,
      '/app/metrics',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'id': id.toString(),
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      FitnessSession fitnessSession = FitnessSession.fromJson(data);

      return fitnessSession;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<ClassInfo> fetchClassInfo(
      {required String classId, required String userId}) async {
    Uri uri = Uri.https(
      BASE_API_URL,
      '/app/classes/$classId',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ClassInfo classInfo = ClassInfo.fromMap(data);

      return classInfo;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<Map<String, List<ClassInfo>>> fetchClassInfoList(
      {required String userId}) async {
    Uri uri = Uri.https(
      BASE_API_URL,
      '/app/classes',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ClassInfo> classInfoList =
            data.map((item) => ClassInfo.fromMap(item)).toList();
        Map<String, List<ClassInfo>> groupedObjects = {};
        for (var obj in classInfoList) {
          String name = obj.name;
          if (groupedObjects.containsKey(name)) {
            groupedObjects[name]!.add(obj);
          } else {
            groupedObjects[name] = [obj];
          }
        }
        return groupedObjects;
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<UserRanking> fetchUserRanking({required String userId}) async {
    Uri uri = Uri.https(
      BASE_API_URL,
      '/app/ranking',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      UserRanking userRanking = UserRanking.fromJson(data);

      return userRanking;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<Map<String, List<UserRanking>>> fetchUserRankingMap(
      {required String userId}) async {
    Uri uri = Uri.https(
      BASE_API_URL,
      '/app/metrics/leaderboard',
    );

    Map<String, String> headers = {
      'userId': userId,
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final data = <String, List<UserRanking>>{};
      jsonData.forEach((key, value) {
        final dataList =
            (value as List).map((json) => UserRanking.fromJson(json)).toList();
        data[key] = dataList;
      });
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Subscription> fetchSubscription({required String userId}) async {
    Uri uri = Uri.https(
      BASE_API_URL,
      '/app/subscriptions',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Subscription subscription = Subscription.fromJson(data);

      return subscription;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<http.Response> createSubscription(
      String name, String description, double price, String userId) async {
    Uri uri = Uri.https(BASE_API_URL, '/app/subscriptions');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    var response = await http.post(uri,
        body: jsonEncode({
          'name': name,
          'description': description,
          'price': price,
        }),
        headers: headers);
    return response;
  }

  Future<http.Response> deleteSubscription(String uid) async {
    final response =
        await http.delete(Uri.parse(BASE_API_URL + '/subscriptions/' + uid));
    return response;
  }

  Future<http.Response> updateSubscription(Subscription subscription) async {
    Uri uri = Uri.https(BASE_API_URL, '/app/subscriptions');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response =
        await http.put(uri, body: subscription.toJson(), headers: headers);
    return response;
  }

  Future<http.Response> changeUserSubscription(
      String userId, String subscriptionId) async {
    Uri uri = Uri.https(BASE_API_URL, '/app/subscriptions/' + subscriptionId);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    var response = await http.post(uri, headers: headers);
    return response;
  }

  Future<List<Subscription>> fetchSubscriptions(String userId) async {
    Uri uri = Uri.https(
      BASE_API_URL,
      '/app/subscriptions',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Subscription> subscriptions =
            data.map((item) => Subscription.fromJson(item)).toList();

        return subscriptions;
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    } catch (e) {
      return [];
    }
  }

  Future<http.Response> subscribeToClass(String classId, String userId) {
    Uri uri = Uri.https(BASE_API_URL, '/app/classes/$classId');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };

    var response = http.post(uri,
        body: jsonEncode({
          "id": classId,
        }),
        headers: headers);
    return response;
  }

  //create class
  Future<http.Response> createClass(ClassInfo classInfo, String userId) async {
    Uri uri = Uri.https(BASE_API_URL, '/app/classes');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'userId': userId,
    };
    try {
      var response =
      await http.post(uri, headers: headers, body: json.encode(classInfo.toJson()));
      return response;
    } catch (e) {
      return http.Response("error", 500);
    }
  }

}
