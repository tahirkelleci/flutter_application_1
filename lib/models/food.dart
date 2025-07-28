class Food {
  String imgUrl;
  String desc;
  String name;
  String waitTime;
  num score;
  String cal;
  num price;
  int quantity;
  int? id;

  List<Map<String, String>> ingredients;
  String about;
  bool isFavorite;
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
    this.isFavorite = false,
    this.id,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'imgUrl': imgUrl,
      'desc': desc,
      'name': name,
      'waitTime': waitTime,
      'score': score,
      'cal': cal,
      'price': price,
      'quantity': quantity,
      'about': about,
      'isFavorite': isFavorite,
      'hightLight': hightLight,
      'ingredients': ingredients, 
      'id': id,
    };
  }

  
  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      map['imgUrl'] ?? '',
      map['desc'] ?? '',
      map['name'] ?? '',
      map['waitTime'] ?? '',
      (map['score'] ?? 0).toDouble(),
      map['cal'] ?? '',
      (map['price'] ?? 0).toDouble(),
      map['quantity'] ?? 0,
      (map['ingredients'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e))
              .toList() ??
          [],
      map['about'] ?? '',
      hightLight: map['hightLight'] ?? false,
      isFavorite: map['isFavorite'] ?? false,
      id: map['id'],
    );
  }

  
  static List<Food> generateFoodList() {
    return [
      Food(
        'assets/images/dish1.png',
        'Satışta 1 numara',
        'Mercimek çorbası',
        '50 dakika',
        4.8,
        '325 kcal',
        50,
        0,
        [
          {'Mercimek': 'assets/images/mercimek.jpeg'},
          {'Pirinç': 'assets/images/pirinç.jpeg'},
          {'Salça': 'assets/images/salça.jpeg'},
          {'Soğan': 'assets/images/soğan.jpeg'},
        ],
        'Türkiye\'de en sevilen çorba',
        hightLight: true,
      ),
      Food(
        'assets/images/dish2.png',
        'Patlıcan ve etin uyumu',
        'Karniyarik',
        '50 dakika',
        4.7,
        '325 kcal',
        100,
        0,
        [
          {'Kıyma': 'assets/images/kıyma.jpeg'},
          {'Patlıcan': 'assets/images/patlıcan.jpeg'},
          {'Domates': 'assets/images/domates.jpeg'},
          {'Soğan': 'assets/images/soğan.jpeg'},
        ],
        'Klasik Türk yemeği',
        hightLight: true,
      ),
      Food(
        'assets/images/dish3.png',
        'Tavsiye edilir',
        'Hamsi Tava',
        '50 dakika',
        4.6,
        '325 kcal',
        120,
        0,
        [
          {'Hamsi': 'assets/images/hamsi.jpeg'},
          {'Yağ': 'assets/images/yağ.jpeg'},
          {'Un': 'assets/images/un.jpeg'},
          {'Tuz': 'assets/images/tuz.jpeg'},
        ],
        'Karadeniz Bölgesine özgü',
        hightLight: true,
      ),
    ];
  }

  static List<Food> generateFavoriFoodList() {
    return [
      Food(
        'assets/images/iskender_kebap.jpeg',
        'Bursaya özgü',
        'İskender Kebap',
        '50 dakika',
        4.8,
        '325 kcal',
        250,
        0,
        [
          {'Mercimek': 'assets/images/mercimek.jpeg'},
          {'Pirinç': 'assets/images/pirinç.jpeg'},
          {'Salça': 'assets/images/salça.jpeg'},
          {'Soğan': 'assets/images/soğan.jpeg'},
        ],
        'Bursa mutfağının vazgeçilmezi',
        hightLight: true,
      ),
      Food(
        'assets/images/adana_kebap.jpeg',
        'Adanaya özgü',
        'Adana Kebap',
        '50 dakika',
        4.7,
        '325 kcal',
        300,
        0,
        [
          {'Kıyma': 'assets/images/kıyma.jpeg'},
          {'Patlıcan': 'assets/images/patlıcan.jpeg'},
          {'Domates': 'assets/images/domates.jpeg'},
          {'Soğan': 'assets/images/soğan.jpeg'},
        ],
        'Adana kebap çok lezzetli',
        hightLight: true,
      ),
      Food(
        'assets/images/döner.jpeg',
        'Tavsiye edilir',
        'Döner Kebap',
        '50 dakika',
        4.6,
        '325 kcal',
        200,
        0,
        [
          {'Hamsi': 'assets/images/hamsi.jpeg'},
          {'Yağ': 'assets/images/yağ.jpeg'},
          {'Un': 'assets/images/un.jpeg'},
          {'Tuz': 'assets/images/tuz.jpeg'},
        ],
        'Türkiye mutfağının vazgeçilmezi',
        hightLight: true,
      ),
    ];
  }

  static List<Food> generateSweetFoodList() {
    return [
      Food(
        'assets/images/baklava.jpeg',
        'Türk Lezzeti',
        'Baklava',
        '50 dakika',
        4.8,
        '325 kcal',
        150,
        0,
        [
          {'Yufka': 'assets/images/yufka.jpeg'},
          {'Şeker': 'assets/images/şeker.jpeg'},
          {'Fıstık': 'assets/images/antep_fıstığı.jpeg'},
          {'Un': 'assets/images/un.jpeg'},
        ],
        'Türkiye mutfağının en sevilen tatlısı',
        hightLight: true,
      ),
      Food(
        'assets/images/künefe.jpeg',
        'Hataya özgü',
        'Kunefe',
        '50 dakika',
        4.7,
        '325 kcal',
        180,
        0,
        [
          {'Peynir': 'assets/images/kaşar_peyniri.jpeg'},
          {'Şeker': 'assets/images/şeker.jpeg'},
          {'Yağ': 'assets/images/yağ.jpeg'},
          {'Yumurta': 'assets/images/yumurta.jpeg'},
        ],
        'Hatay mutfağının vazgeçilmezi',
        hightLight: true,
      ),
      Food(
        'assets/images/tulumba.jpeg',
        'Tavsiye edilir',
        'Tulumba',
        '50 dakika',
        4.6,
        '325 kcal',
        80,
        0,
        [
          {'Nişasta': 'assets/images/nişasta.jpeg'},
          {'Yağ': 'assets/images/yağ.jpeg'},
          {'Un': 'assets/images/un.jpeg'},
          {'Şeker': 'assets/images/şeker.jpeg'},
        ],
        'Şekerli ve çıtır çıtır bir tatlı',
        hightLight: true,
      ),
    ];
  }

  static List<Food> generatePopularFoodList() {
    return [
      Food(
        'assets/images/dish4.png',
        'En Popüler',
        'Domatesli Tavuk',
        '50 dakika',
        5.0,
        '325 kcal',
        200,
        0,
        [
          {'Tavuk': 'assets/images/tavuk.jpeg'},
          {'Domates': 'assets/images/domates.jpeg'},
          {'Yağ': 'assets/images/yağ.jpeg'},
          {'Tuz': 'assets/images/tuz.jpeg'},
        ],
        'Lezzetli bir tavuk yemeği',
        hightLight: true,
      ),
      Food(
        'assets/images/kuru_fasülye.jpeg',
        'En Popüler',
        'Kuru Fasulye',
        '50 dakika',
        5.0,
        '325 kcal',
        120,
        0,
        [
          {'Et': 'assets/images/kıyma.jpeg'},
          {'Salça': 'assets/images/salça.jpeg'},
          {'Yağ': 'assets/images/yağ.jpeg'},
          {'Tuz': 'assets/images/tuz.jpeg'},
        ],
        'Pilaavın en iyi arkadaşı',
        hightLight: true,
      ),
      Food(
        'assets/images/pilav.jpeg',
        'En Popüler',
        'Pilav',
        '50 dakika',
        5.0,
        '325 kcal',
        80,
        0,
        [
          {'Tavuk': 'assets/images/tavuk.jpeg'},
          {'Pirinç': 'assets/images/pirinç.jpeg'},
          {'Yağ': 'assets/images/yağ.jpeg'},
          {'Tuz': 'assets/images/tuz.jpeg'},
        ],
        'Kurufasulyenin en iyi arkadaşı',
        hightLight: true,
      ),
    ];
  }

  static List<Food> generateDrinkList() {
    return [
      Food(
        'assets/images/cay.jpg',
        'Geleneksel Türk çayı',
        'Çay',
        '5 dakika',
        4.8,
        '5 kcal',
        8,
        0,
        [
          {'Çay': 'assets/images/cay.jpg'},
          {'Çay Yaprağı': 'assets/images/çay_yaprağı.jpg'},
          {'Su': 'assets/images/su.jpg'},
          {'Şeker': 'assets/images/şeker.jpeg'},
        ],
        'Taze demlenmiş geleneksel Türk çayı. Kahvaltı ve ara öğünlerde mükemmel.',
        hightLight: true,
      ),
      Food(
        'assets/images/kahve.jpg',
        'Taze çekilmiş kahve',
        'Türk Kahvesi',
        '10 dakika',
        4.7,
        '15 kcal',
        25,
        0,
        [

          {'Kahve': 'assets/images/kahve.jpg'},
          {'Kahve Çekirdeği': 'assets/images/kahve_cekirdegi.jpg'},
          {'Su': 'assets/images/su.jpg'},
          {'Şeker': 'assets/images/şeker.jpeg'},
        ],
        'Geleneksel Türk kahvesi. Orta şekerli olarak servis edilir.',
        hightLight: true,
      ),
      Food(
        'assets/images/ayran.jpg',
        'Ev yapımı taze ayran',
        'Ayran',
        '2 dakika',
        4.6,
        '60 kcal',
        12,
        0,
        [
          {'Süt': 'assets/images/süt.jpg'},
          {'Yoğurt': 'assets/images/yogurt.jpg'},
          {'Su': 'assets/images/su.jpg'},
          {'Tuz': 'assets/images/tuz.jpeg'},
        ],
        'Geleneksel Türk içeceği. Yemeklerle mükemmel uyum sağlar.',
        hightLight: true,
      ),
      Food(
        'assets/images/cola.jpg',
        'Soğuk gazlı içecek',
        'Kola',
        '1 dakika',
        4.2,
        '140 kcal',
        15,
        0,
        [
          {'Şeker': 'assets/images/şeker.jpeg'},
          {'Kola': 'assets/images/cola.jpg'},
          {'Buz': 'assets/images/buz.jpg'},
          {'Soda': 'assets/images/soda.jpg'},
        ],
        'Soğuk servis edilen gazlı içecek.',
        hightLight: true,
      ),
      Food(
        'assets/images/limonata.jpg',
        'Taze sıkılmış limon suyu',
        'Limonata',
        '5 dakika',
        4.5,
        '80 kcal',
        18,
        0,
        [
          {'Limon': 'assets/images/limon.jpg'},
          {'Su': 'assets/images/su.jpg'},
          {'Şeker': 'assets/images/şeker.jpeg'},
          {'Nane': 'assets/images/nane.jpg'},
        ],
        'Taze limon ve nane ile hazırlanan serinletici içecek.',
        hightLight: true,
      ),
      Food(
        'assets/images/meyve_suyu.jpg',
        'Taze sıkılmış meyve suları',
        'Meyve Suyu',
        '3 dakika',
        4.4,
        '110 kcal',
        20,
        0,
        [
          {'Su': 'assets/images/su.jpg'},
          {'Portakal': 'assets/images/portakal.jpg'},
          {'Elma': 'assets/images/elma.jpg'},
          {'Şeker': 'assets/images/şeker.jpeg'},
        ],
        'Portakal, elma veya karışık meyve suyu seçenekleri.',
        hightLight: true,
      ),
    ];
  }
}