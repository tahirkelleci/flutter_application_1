import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartPage extends StatelessWidget {
 Future<void> _submitOrder(BuildContext context) async {
  final cart = Provider.of<CartModel>(context, listen: false);
  final orderItems = cart.items.map((food) {
    return {
      'name': food.name,
      'price': food.price,
      'quantity': food.quantity,
      'total': food.price * food.quantity,
    };
  }).toList();

  final totalPrice = cart.totalPrice;

  try {
    await FirebaseFirestore.instance.collection('orders').add({
      'items': orderItems,
      'totalPrice': totalPrice,
      'timestamp': FieldValue.serverTimestamp(),
    });

    cart.clearCart(); 

    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Siparişiniz oluşturuldu!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              '✅',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(); 
                Navigator.of(context).pop(); 
              },
              child: Text('Tamam'),
            )
          ],
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sipariş gönderilirken hata oluştu: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Sepetim'),
      ),
      body: cart.items.isEmpty
          ? Center(child: Text("Sepet boş"))
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final food = cart.items[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          food.imgUrl,
                          width: 60,
                          height: 60,
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
                    title: Text(
                      food.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${food.quantity} x ${food.price.toStringAsFixed(2)}₺',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(food.price * food.quantity).toStringAsFixed(2)}₺',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            cart.removeItem(food);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${food.name} sepetten kaldırıldı.'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.items.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(16),
              color: kPrimaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Toplam:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${cart.totalPrice.toStringAsFixed(2)}₺",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: kPrimaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () => _submitOrder(context),
                    child: Text("Siparişi Tamamla"),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}