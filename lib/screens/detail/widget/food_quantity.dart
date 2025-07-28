import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/cart_model.dart';



class FoodQuantity extends StatefulWidget {
  final Food food;
  final VoidCallback? onChanged;

  const FoodQuantity(this.food, {this.onChanged});

  @override
  _FoodQuantityState createState() => _FoodQuantityState();
}

class _FoodQuantityState extends State<FoodQuantity> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.food.quantity.toInt();
  }

  void increase() {
  setState(() {
    quantity++;
    widget.food.quantity = quantity;
  });

  final cart = Provider.of<CartModel>(context, listen: false);

  // Eğer ürün sepette yoksa ekle, varsa miktarı güncelle
  if (cart.getItemQuantity(widget.food.name) == 0) {
    cart.addItem(widget.food);
  } else {
    cart.updateQuantity(widget.food, quantity);
  }

  if (widget.onChanged != null) widget.onChanged!();
}


  void decrease() {
    if (quantity == 0) return; // negatif olmasın

    setState(() {
      quantity--;
      widget.food.quantity = quantity;
    });

    final cart = Provider.of<CartModel>(context, listen: false);
    cart.updateQuantity(widget.food, quantity);

    if (widget.onChanged != null) widget.onChanged!();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 40,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(-0.3, 0),
            child: Container(
              width: 120,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Text(
                    '₺ ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.food.price.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.3, 0),
            child: Container(
              height: double.maxFinite,
              width: 120,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: decrease,
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: increase,
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
