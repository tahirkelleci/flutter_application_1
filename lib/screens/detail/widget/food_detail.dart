import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/detail/widget/food_quantity.dart'; // kBackground için gerekli



class FoodDetail extends StatelessWidget {
  final Food food;
  final VoidCallback? onChanged;

  const FoodDetail(this.food, {this.onChanged});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      color: kBackgroundColor,
      child: Column(
        children: [
          Text(
            food.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconText(
                Icons.access_time_outlined,
                Colors.blue,
                food.waitTime,
              ),
              _buildIconText(
                Icons.star_outline,
                Colors.amber,
                food.score.toString(),
              ),
              _buildIconText(
                Icons.local_fire_department_outlined,
                Colors.red,
                food.cal,
              ),
            ],
          ),
          SizedBox(height: 30),
          FoodQuantity(food,onChanged: onChanged),
          SizedBox(height: 30),
          Row(
            children: [
              Text(
                'Malzemeler',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder:
                  (context, index) => Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          food.ingredients[index].values.first,
                          width: 52,
                        ),
                        Text(food.ingredients[index].keys.first),
                      ],
                    ),
                  ),
              separatorBuilder: (_, index) => SizedBox(width: 15),
              itemCount: food.ingredients.length,
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Text(
                'Açıklama',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 10),
             Align(
               alignment: Alignment.centerLeft,
               child: Text(
                food.about,
                style: TextStyle(wordSpacing: 1.2, height: 1.5, fontSize: 16),
      ),
    ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 5),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
