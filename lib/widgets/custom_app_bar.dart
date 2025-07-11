import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final Function? leftCallback;
  final Function(String)? onSearch; // Arama fonksiyonu parametresi

  CustomAppBar(
    this.leftIcon, 
    this.rightIcon, 
    {this.leftCallback, this.onSearch}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: leftCallback != null 
              ? () => leftCallback!() 
              : () => Navigator.pop(context),
            child: _buildIcon(leftIcon),
          ),
          GestureDetector(
            onTap: () {
              _showSearchDialog(context);
            },
            child: _buildIcon(rightIcon),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Yemek Ara'),
        content: Container(
          width: double.maxFinite,
          child: TextField(
            controller: searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Yemek adı yazın...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty && onSearch != null) {
                onSearch!(value);
                Navigator.pop(context);
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'İptal',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final searchText = searchController.text.trim();
              if (searchText.isNotEmpty && onSearch != null) {
                onSearch!(searchText);
                Navigator.pop(context);
              }
            },
            child: Text('Ara'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 20,
        color: Colors.black87,
      ),
    );
  }
}