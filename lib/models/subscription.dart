class Subscription {
  double price;
  String name;
  String description;
  String id;

  Subscription({
    required this.price,
    required this.name,
    required this.description,
    required this.id,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      price: json['price'],
      name: json['name'],
      description: json['description'],
      id: json['id'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'price': price,
    'name': name,
    'description': description,
    'id': id,
  };
}
