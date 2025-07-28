import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/models/food.dart';
import 'package:flutter_application_1/screens/home/widget/food_list_view.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/screens/home/widget/restaurant_info.dart';
import 'package:flutter_application_1/screens/home/widget/food_list.dart';
import 'package:flutter_application_1/models/restaurant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_application_1/screens/home/widget/food_item.dart';
import 'package:flutter_application_1/screens/detail/detail.dart';
import 'package:flutter_application_1/screens/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/cart_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selected = 0;
  final pageController = PageController();
  final restaurant = Restaurant.generateRestaurant();
  String searchText = '';
  List<dynamic> searchResults = [];
  
  
  final ScrollController _scrollController = ScrollController();
  
  List<Food> getAllFoods() {
    return restaurant.menu.values.expand((list) => list).toList();
  }

  void handleSearch(String text) {
    setState(() {
      searchText = text;
      if (text.isEmpty) {
        searchResults = [];
      } else {
        searchResults = getAllFoods()
            .where((food) => food.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
    });
  }

  bool hasProductInCart() {
    final cart = Provider.of<CartModel>(context, listen: false);
    return cart.items.isNotEmpty;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true, 
            trackVisibility: true, 
            thickness: 8.0, 
            radius: Radius.circular(4.0), 
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    searchText.isEmpty ? Icons.refresh_outlined : Icons.arrow_back_ios_outlined,
                    Icons.search_outlined,
                    leftCallback: () {
                      if (searchText.isNotEmpty) {
                        handleSearch('');
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    },
                    onSearch: handleSearch,
                  ),
                  RestaurantInfo(),
                  if (searchText.isEmpty) ...[
                    FoodList(selected, (int index) {
                      setState(() {
                        selected = index;
                      });
                      pageController.jumpToPage(index);
                    }, restaurant),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5, 
                      child: FoodListView(
                        selected,
                        (int index) {
                          setState(() {
                            selected = index;
                          });
                        },
                        pageController,
                        restaurant,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      height: 60,
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: restaurant.menu.length,
                        effect: CustomizableEffect(
                          dotDecoration: DotDecoration(
                            width: 8,
                            height: 8,
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          activeDotDecoration: DotDecoration(
                            width: 10,
                            height: 10,
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            dotBorder: DotBorder(
                              color: kPrimaryColor,
                              padding: 2,
                              width: 2,
                            ),
                          ),
                        ),
                        onDotClicked: (index) => pageController.jumpToPage(index),
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7, 
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: searchResults.isEmpty
                            ? Center(child: Text("Sonuç bulunamadı"))
                            : ListView.separated(
                                itemCount: searchResults.length,
                                separatorBuilder: (_, __) => SizedBox(height: 15),
                                itemBuilder: (context, index) {
                                  final food = searchResults[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(food),
                                        ),
                                      );
                                    },
                                    child: FoodItem(food),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                  SizedBox(height: 100), // Alt boşluk
                ],
              ),
            ),
          ),
          floatingActionButton: cart.items.isNotEmpty
              ? FloatingActionButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                    setState(() {});
                  },
                  backgroundColor: kPrimaryColor,
                  elevation: 2,
                  child: Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 30),
                )
              : null,
        );
      },
    );
  }
}
