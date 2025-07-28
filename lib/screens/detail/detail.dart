import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/cart_model.dart';
import 'package:flutter_application_1/models/food.dart';
import 'package:flutter_application_1/screens/detail/widget/food_detail.dart';
import 'package:flutter_application_1/screens/detail/widget/food_img.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/screens/cart_page.dart';

class DetailPage extends StatefulWidget {
  final Food food;

  const DetailPage(this.food);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void _showCartDialog(BuildContext context, CartModel cart) {
    // Mevcut ürünü sepetten al
    final currentItem = cart.items.firstWhere(
      (item) => item.name == widget.food.name,
      orElse: () => widget.food, // Sepette yoksa mevcut food'u kullan
    );
    
    if (cart.items.isEmpty) {
      // Sepet boşsa direkt sepet sayfasına git
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CartPage())
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Başarı ikonu
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Sepete Eklendi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            
            // Ürün bilgileri
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Ürün resmi
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        currentItem.imgUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.orange[100],
                            child: Icon(
                              Icons.restaurant,
                              color: Colors.orange,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Ürün detayları
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentItem.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${currentItem.quantity} Adet',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${currentItem.price.toStringAsFixed(2)} TL',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Butonlar
            Row(
              children: [
                // Alışverişe Devam Et butonu
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(); // Dialog'u kapat
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.orange),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Alışverişe Devam Et',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Sepete Git butonu
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(); // Dialog'u kapat
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartPage())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Sepete Git',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;

    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  Icons.arrow_back_ios_outlined,
                  food.isFavorite ? Icons.favorite : Icons.favorite_outline,
                  leftCallback: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  ),
                  rightCallback: () {
                    setState(() {
                      food.isFavorite = !food.isFavorite;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          food.isFavorite
                              ? 'Favorilere eklendi ❤️'
                              : 'Favorilerden çıkarıldı 💔',
                        ),
                        duration: Duration(seconds: 1),
                        backgroundColor: food.isFavorite ? Colors.red : Colors.grey,
                      ),
                    );
                  },
                ),
                FoodImg(food),
                FoodDetail(food, onChanged: () => setState(() {})),
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            width: 100,
            height: 56,
            child: RawMaterialButton(
              fillColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 30),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.getItemQuantity(food.name).toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                _showCartDialog(context, cart);
              },
            ),
          ),
        );
      },
    );
  }
}