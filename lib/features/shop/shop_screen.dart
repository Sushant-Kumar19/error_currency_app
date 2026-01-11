import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {'name': 'Chocolate Bar', 'cost': 50},
    {'name': 'Headphones', 'cost': 200},
    {'name': 'Notebook', 'cost': 30},
    {'name': 'Water Bottle', 'cost': 40},
    {'name': 'USB Drive', 'cost': 80},
    {'name': 'Coffee Mug', 'cost': 60},
    {'name': 'Desk Lamp', 'cost': 150},
    {'name': 'Backpack', 'cost': 300},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🛒 Shop'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Dummy wallet display
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '🪙 Coins: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '50 Dummy', // Dummy value
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // List of dummy items
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text('${item['cost']} 🪙'),
                      trailing: ElevatedButton(
                        onPressed: () {}, // No action
                        child: Text('Buy'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
