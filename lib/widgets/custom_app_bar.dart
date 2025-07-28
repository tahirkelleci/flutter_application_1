import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final IconData leftIcon;
  final IconData rightIcon;
  final Function? leftCallback;
  final Function? rightCallback;
  final Function(String)? onSearch;

  const CustomAppBar(
    this.leftIcon,
    this.rightIcon, {
    this.leftCallback,
    this.onSearch,
    this.rightCallback,
  });

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
              
              if (rightCallback != null) {
                rightCallback!();
              } else {
                _showSearchDialog(context);
              }
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
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Yemek adi yazin...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            onSubmitted: (value) {
              final trimmed = value.trim();
              if (trimmed.isNotEmpty && onSearch != null) {
                onSearch!(trimmed);
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
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Lütfen bir şey yazin")),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: Text('Ara'),
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
        color: Colors.red,
      ),
    );
  }
}
