import 'package:flutter/material.dart';
import 'package:frontend/models/subscription.dart';
import 'package:frontend/screens_user/plan.dart';
import 'package:frontend/services/api.dart';
import 'package:frontend/configuration/globals.dart' as globals;
import 'package:http/http.dart' as http;

class SubscriptionAdmin extends StatefulWidget {
  @override
  State<SubscriptionAdmin> createState() => _SubscriptionAdminState();
}

class _SubscriptionAdminState extends State<SubscriptionAdmin> {
  late Future<List<Subscription>> boxes;
  APIService apiService = APIService.instance;

  void initState() {
    super.initState();
    boxes = apiService.fetchSubscriptions(
      globals.currentUser.userId,
    );
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _addPlan() async {
    if (_formKey.currentState!.validate()) {
      http.Response response = await apiService.createSubscription(
        _nameController.text,
        _descriptionController.text,
        double.parse(_priceController.text),
        globals.currentUser.userId
      );
      if(response.statusCode == 200) {
        setState(() {
          boxes = apiService.fetchSubscriptions(
            globals.currentUser.userId,
          );
        });
      }
      setState(() {
        _nameController.clear();
        _descriptionController.clear();
        _priceController.clear();
      });

    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
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
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(15),
                      child: Wrap(
                        children: snapshot.data!
                            .map(
                              (subscription) => Container(
                                margin: const EdgeInsets.all(10),
                                color: Colors.blue.shade100,
                                alignment: Alignment.center,
                                width: 400,
                                child: Plan(
                                    name: subscription.name,
                                    description: subscription.description,
                                    price: subscription.price,
                                    subscriptionId: subscription.id),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      color: Colors.blue.shade100,
                      alignment: Alignment.center,
                      width: 400,
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                    hintText: 'Plan name',
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a name for the plan';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                    hintText: 'Plan description',
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a description for the plan';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: 'Plan price',
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a price for the plan';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid price';
                                  }
                                  return null;
                                },
                              ),
                              ElevatedButton(
                                onPressed: _addPlan,
                                child: const Text('Add Plan'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
