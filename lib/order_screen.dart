import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rgr_application/purchase.dart';
import 'package:rgr_application/order.dart';
import 'package:rgr_application/add_order_screen.dart';
import 'package:rgr_application/edit_order_screen.dart';

class OrderScreen extends StatefulWidget {
  final Purchase purchase;

  OrderScreen({required this.purchase});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> orders = [];

  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пользователь не авторизован')),
      );
      return;
    }

    setState(() {
      orders = [
        Order(
          id: '1',
          title: 'Заказ 1',
          description: 'Описание заказа 1',
          purchaseId: widget.purchase.id,
          option: 'А2',
          paperType: PaperType.Glossy,
        ),
        Order(
          id: '2',
          title: 'Заказ 2',
          description: 'Описание заказа 2',
          purchaseId: widget.purchase.id,
          option: 'А2',
          paperType: PaperType.Matte,
        ),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _addOrder() async {
    final newOrder = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddOrderScreen(purchase: widget.purchase),
      ),
    );

    if (newOrder != null) {
      setState(() {
        orders.add(newOrder);
      });
    }
  }

  void _editOrder(Order order) async {
    final updatedOrder = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditOrderScreen(
          order: order,
          onOrderUpdated: (updatedOrder) {
            setState(() {
              final index = orders.indexWhere((o) => o.id == updatedOrder.id);
              if (index != -1) {
                orders[index] = updatedOrder;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Заказы корзины: ${widget.purchase.title}')),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            title: Text(order.title),
            subtitle: Text(
                'Формат: ${order.option}\nТип бумаги: ${order.paperType.toString().split('.').last}\n${order.description}'),
            onTap: () => _editOrder(order),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addOrder,
        child: Icon(Icons.add),
        tooltip: 'Добавить в корзину',
      ),
    );
  }
}