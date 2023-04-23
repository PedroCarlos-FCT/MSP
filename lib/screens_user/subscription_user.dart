import 'package:flutter/material.dart';
import 'package:frontend/models/subscription.dart';
import 'package:frontend/screens_user/plan.dart';
import 'package:frontend/services/api.dart';
import 'package:frontend/configuration/globals.dart' as globals;

class SubscriptionUser extends StatefulWidget {
  @override
  _SubscriptionUserState createState() => _SubscriptionUserState();
}

class _SubscriptionUserState extends State<SubscriptionUser> {
  late Future<List<Subscription>> boxes;
  APIService apiService = APIService.instance;

  @override
  void initState() {
    super.initState();
    boxes = apiService.fetchSubscriptions(
      globals.currentUser.userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription Plans"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Subscription>>(
          future: boxes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(15),
                  child: Wrap(
                    children: snapshot.data!
                        .map((subscription) => Container(
                              margin: const EdgeInsets.all(10),
                              color: Colors.blue.shade100,
                              alignment: Alignment.center,
                              width: 400,
                              child: Plan(
                                  name: subscription.name,
                                  description: subscription.description,
                                  price: subscription.price,
                                  subscriptionId: subscription.id),
                            ),)
                        .toList(),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
