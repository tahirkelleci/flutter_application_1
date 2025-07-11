class Food {
  String imgUrl;
  String desc;
  String name;
  String waitTime;
  num score;
  String cal;
  num price;
  num quantity;
  List<Map<String, String>> ingredients;
  String about;
  bool hightLight;

  Food(
    this.imgUrl,
    this.desc,
    this.name,
    this.waitTime,
    this.score,
    this.cal,
    this.price,
    this.quantity,
    this.ingredients,
    this.about, {
    this.hightLight = false,
  });

  static List<Food> generateFoodList() {
    return [
      Food(
        'assets/images/dish1.png',
        'No1. in Sales',
        'Soba soup',
        '50 dakika',
        4.8,
        '325 kcal',
        12,
        1,
        [
          {'Noodle': 'assets/images/ingre1.png'},
          {'Shrimp': 'assets/images/ingre2.png'},
          {'Egg': 'assets/images/ingre3.png'},
          {'Scallion': 'assets/images/ingre4.png'},
        ],
        'Simply put, ramen is a Japanese noodle soup.',
        hightLight: true,
      ),
      Food(
        'assets/images/dish2.png',
        'Low Fat',
        'Sai Ua Samun Phrai',
        '50 dakika',
        4.8,
        '325 kcal',
        18,
        0,
        [
          {'Noodle': 'assets/images/ingre1.png'},
          {'Shrimp': 'assets/images/ingre2.png'},
          {'Egg': 'assets/images/ingre3.png'},
          {'Scallion': 'assets/images/ingre4.png'},
        ],
        'Simply put, ramen is a Japanese noodle soup.',
        hightLight: true,
      ),
      Food(
        'assets/images/dish3.png',
        'Highly Recommended',
        'Ratatouille Pasta',
        '50 dakika',
        4.8,
        '325 kcal',
        17,
        0,
        [
          {'Noodle': 'assets/images/ingre1.png'},
          {'Shrimp': 'assets/images/ingre2.png'},
          {'Egg': 'assets/images/ingre3.png'},
          {'Scallion': 'assets/images/ingre4.png'},
        ],
        'Simply put, ramen is a Japanese noodle soup.',
        hightLight: true,
      ),
    ];
  }

  static List<Food> generatePopularFoodList() {
    return [
      Food(
        'assets/images/dish4.png',
        'Most Popular',
        'Tomata Chicken',
        '50 dakika',
        4.8,
        '325 kcal',
        14.5,
        0,
        [
          {'Noodle': 'assets/images/ingre1.png'},
          {'Shrimp': 'assets/images/ingre2.png'},
          {'Egg': 'assets/images/ingre3.png'},
          {'Scallion': 'assets/images/ingre4.png'},
        ],
        'Simply put, ramen is a Japanese noodle soup.',
        hightLight: true,
      ),
    ];
  }
}
