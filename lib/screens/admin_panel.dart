import 'package:flutter/material.dart';

void main() {
  runApp(RestaurantAdminApp());
}

class RestaurantAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restoran Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: AdminDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Meal {
  final int id;
  String name;
  String category;
  double price;
  String description;
  String image;
  String status;
  int orders;

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
    this.status = 'active',
    this.orders = 0,
  });
}

class Order {
  final int id;
  final String customer;
  final List<String> items;
  final double total;
  String status;
  final String time;
  final String address;

  Order({
    required this.id,
    required this.customer,
    required this.items,
    required this.total,
    required this.status,
    required this.time,
    required this.address,
  });
}

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  
  List<Meal> meals = [
    Meal(
      id: 1,
      name: 'Mercimek Çorbası',
      category: 'Tavsiye',
      price: 50,
      description: 'Sıcak ve besleyici',
      image: 'assets/corba.jpg',
      orders: 45,
    ),
    Meal(
      id: 2,
      name: 'Karnyarık',
      category: 'Popüler',
      price: 100,
      description: 'Geleneksel lezzet',
      image: 'assets/karnyarik.jpg',
      orders: 32,
    ),
    Meal(
      id: 3,
      name: 'Hamsi Tava',
      category: 'Kebap',
      price: 120,
      description: 'Taze hamsi',
      image: 'assets/hamsi.jpg',
      orders: 28,
    ),
  ];

  List<Order> orders = [
    Order(
      id: 1001,
      customer: 'Ahmet Y.',
      items: ['Mercimek Çorbası', 'Karnyarık'],
      total: 150,
      status: 'preparing',
      time: '12:30',
      address: 'Kadıköy, İstanbul',
    ),
    Order(
      id: 1002,
      customer: 'Fatma K.',
      items: ['Hamsi Tava'],
      total: 120,
      status: 'ready',
      time: '12:45',
      address: 'Beşiktaş, İstanbul',
    ),
    Order(
      id: 1003,
      customer: 'Mehmet A.',
      items: ['Mercimek Çorbası', 'Hamsi Tava'],
      total: 170,
      status: 'delivered',
      time: '11:15',
      address: 'Üsküdar, İstanbul',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Restoran Admin Panel'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 4),
                Text('4.7', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                _buildSidebarItem(Icons.dashboard, 'Dashboard', 0),
                _buildSidebarItem(Icons.restaurant_menu, 'Yemekler', 1),
                _buildSidebarItem(Icons.receipt_long, 'Siparişler', 2),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: _getSelectedPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    bool isSelected = _selectedIndex == index;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.orange : Colors.grey[600],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.orange : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        tileColor: isSelected ? Colors.orange[50] : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildMealsPage();
      case 2:
        return _buildOrdersPage();
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),
        // Stats Cards
        Row(
          children: [
            Expanded(child: _buildStatCard('Bugünkü Satış', '₺2,450', Icons.trending_up, Colors.green)),
            SizedBox(width: 16),
            Expanded(child: _buildStatCard('Toplam Sipariş', '47', Icons.shopping_cart, Colors.blue)),
            SizedBox(width: 16),
            Expanded(child: _buildStatCard('Ortalama Puan', '4.7', Icons.star, Colors.amber)),
            SizedBox(width: 16),
            Expanded(child: _buildStatCard('Aktif Yemek', '${meals.length}', Icons.restaurant, Colors.purple)),
          ],
        ),
        SizedBox(height: 32),
        // Recent Orders
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Son Siparişler',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...orders.take(5).map((order) => _buildOrderListItem(order)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  SizedBox(height: 8),
                  Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              Icon(icon, size: 32, color: color),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealsPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Yemek Yönetimi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () => _showMealDialog(),
              icon: Icon(Icons.add),
              label: Text('Yeni Yemek'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              children: [
                // Table Header
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text('Yemek', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Fiyat', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('Sipariş', style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text('İşlemler', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                // Table Content
                Expanded(
                  child: ListView.builder(
                    itemCount: meals.length,
                    itemBuilder: (context, index) => _buildMealRow(meals[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMealRow(Meal meal) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.restaurant, color: Colors.orange),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(meal.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(meal.description, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                meal.category,
                style: TextStyle(color: Colors.orange[800], fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(flex: 1, child: Text('₺${meal.price.toInt()}')),
          Expanded(flex: 1, child: Text('${meal.orders}')),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _showMealDialog(meal: meal),
                  icon: Icon(Icons.edit, color: Colors.blue),
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () => _deleteMeal(meal.id),
                  icon: Icon(Icons.delete, color: Colors.red),
                  iconSize: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sipariş Yönetimi',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) => _buildOrderCard(orders[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(Order order) {
    Color statusColor = _getStatusColor(order.status);
    String statusText = _getStatusText(order.status);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sipariş #${order.id}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(order.customer, style: TextStyle(color: Colors.grey[600])),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                        SizedBox(width: 4),
                        Text(order.time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey[500]),
                        SizedBox(width: 4),
                        Text(order.address, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('₺${order.total.toInt()}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    DropdownButton<String>(
                      value: order.status,
                      items: [
                        DropdownMenuItem(value: 'preparing', child: Text('Hazırlanıyor')),
                        DropdownMenuItem(value: 'ready', child: Text('Hazır')),
                        DropdownMenuItem(value: 'delivered', child: Text('Teslim Edildi')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          order.status = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 8),
            Text('Sipariş Detayı:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            SizedBox(height: 8),
            ...order.items.map((item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('• $item', style: TextStyle(color: Colors.grey[600])),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderListItem(Order order) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sipariş #${order.id}', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${order.customer} - ${order.time}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('₺${order.total.toInt()}', style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getStatusText(order.status),
                  style: TextStyle(color: _getStatusColor(order.status), fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'preparing':
        return Colors.orange;
      case 'ready':
        return Colors.green;
      case 'delivered':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'preparing':
        return 'Hazırlanıyor';
      case 'ready':
        return 'Hazır';
      case 'delivered':
        return 'Teslim Edildi';
      default:
        return 'Bilinmiyor';
    }
  }

  void _showMealDialog({Meal? meal}) {
    TextEditingController nameController = TextEditingController(text: meal?.name ?? '');
    TextEditingController priceController = TextEditingController(text: meal?.price.toString() ?? '');
    TextEditingController descriptionController = TextEditingController(text: meal?.description ?? '');
    String selectedCategory = meal?.category ?? 'Tavsiye';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(meal == null ? 'Yeni Yemek Ekle' : 'Yemek Düzenle'),
              content: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Yemek Adı'),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: InputDecoration(labelText: 'Kategori'),
                      items: ['Tavsiye', 'Popüler', 'Kebap', 'Tatlı']
                          .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: priceController,
                      decoration: InputDecoration(labelText: 'Fiyat (₺)'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Açıklama'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('İptal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                      if (meal == null) {
                        
                        meals.add(Meal(
                          id: meals.length + 1,
                          name: nameController.text,
                          category: selectedCategory,
                          price: double.parse(priceController.text),
                          description: descriptionController.text,
                          image: 'assets/default.jpg',
                        ));
                      } else {
                        
                        meal.name = nameController.text;
                        meal.category = selectedCategory;
                        meal.price = double.parse(priceController.text);
                        meal.description = descriptionController.text;
                      }
                      setState(() {});
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Kaydet'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) => setState(() {}));
  }

  void _deleteMeal(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Yemek Sil'),
          content: Text('Bu yemeği silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  meals.removeWhere((meal) => meal.id == id);
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Sil', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
