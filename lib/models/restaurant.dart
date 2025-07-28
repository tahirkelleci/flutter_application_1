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
      'Sempati Sosyal Tesis',
      '20-30 dakika',
      '2.4 km',
      'Restoran',
      'assets/images/sempati.jpg',
      'En iyi yemekler burada',
      4.7,
      {
        'Tavsiye': Food.generateFoodList(), 
        'Popüler': Food.generatePopularFoodList(),
        'Kebap' : Food.generateFavoriFoodList() ,
        'Tatlı'  : Food.generateSweetFoodList(),
        'İçecek': Food.generateDrinkList(),
      },
    );
  }
}
