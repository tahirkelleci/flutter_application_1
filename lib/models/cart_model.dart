import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/food.dart';

class CartModel extends ChangeNotifier {
  final List<Food> _items = [];

  List<Food> get items => _items;

  double get totalPrice {
    return _items.fold(0.0, (total, food) => total + (food.price * food.quantity));
  }

  void addItem(Food food) {
    final existingIndex = _items.indexWhere((item) => item.name == food.name);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      Food newFood = Food(
        food.imgUrl,
        food.desc,
        food.name,
        food.waitTime,
        food.score,
        food.cal,
        food.price,
        1,
        food.ingredients,
        food.about,
        hightLight: food.hightLight,
        isFavorite: food.isFavorite,
        id: food.id,
      );
      _items.add(newFood);
    }

    notifyListeners();
  }

  void removeItem(Food food) {
    _items.removeWhere((item) => item.name == food.name);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  int getItemQuantity(String foodName) {
    try {
      final existingItem = _items.firstWhere((item) => item.name == foodName);
      return existingItem.quantity;
    } catch (e) {
      return 0;
    }
  }

  void updateQuantity(Food food, int quantity) {
    final existingIndex = _items.indexWhere((item) => item.name == food.name);

    if (existingIndex >= 0) {
      if (quantity > 0) {
        _items[existingIndex].quantity = quantity;
      } else {
        _items.removeAt(existingIndex);
      }
      notifyListeners();
    }
  }

  
  int get totalItemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
}
