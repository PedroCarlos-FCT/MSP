import 'package:flutter/material.dart';
import 'package:frontend/screens_user/confirmationPage.dart';
import 'package:frontend/services/api.dart';
import 'package:frontend/configuration/globals.dart' as globals;
import 'package:http/http.dart' as http;

class Plan extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String subscriptionId;
  final APIService apiService = APIService.instance;


  Plan({required this.name, required this.description, required this.price, required this.subscriptionId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    description,
                    softWrap: true,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        http.Response response = await apiService.changeUserSubscription(globals.currentUser.userId, subscriptionId);
                        print(response.statusCode);
                        if(response.statusCode == 200)
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmationPage(
                                  amount: price,
                                  description: 'Membership fee')),
                        ); //add subscription to the user
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.payment, color: Colors.white),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            '\$$price',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
