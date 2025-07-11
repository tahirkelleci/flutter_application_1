import 'package:flutter_application_1/models/food.dart';

class Restaurant {
  String name;
  String waitTime;
  String distance;
  String label;
  String logoUrl;
  String desc;
  num score;
  Map<String, List<Food>> menu;

  Restaurant(
    this.name,
    this.waitTime,
    this.distance,
    this.label,
    this.logoUrl,
    this.desc,
    this.score,
    this.menu,
  );

  static Restaurant generateRestaurant() {
    return Restaurant(
      'Restaurant',
      '20-30 min',
      '2.4 km',
      'Restaurant',
      'assets/images/restaurant_logo.png',
      'Orange sandwiches is delicious',
      4.7,
      {
        'Recommend': Food.generateFoodList(), // Veya ayrı metod oluştur
        'Popular': Food.generatePopularFoodList(),
        'Noodles': [],
        'Pizza': [],
      },
    );
  }
}
