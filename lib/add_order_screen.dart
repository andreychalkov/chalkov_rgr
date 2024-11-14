import 'package:flutter/material.dart';
import 'package:rgr_application/purchase.dart';
import 'package:rgr_application/order.dart';

class AddOrderScreen extends StatefulWidget {
  final Purchase purchase;

  AddOrderScreen({required this.purchase});

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String selectedOption = 'А2';
  List<String> options = ['А2', 'А3', 'А4'];

  PaperType selectedPaperType = PaperType.Glossy;
  List<PaperType> paperTypes = PaperType.values;

  void _saveOrder() {
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      purchaseId: widget.purchase.id,
      title: _titleController.text,
      description: _descriptionController.text,
      option: selectedOption,
      paperType: selectedPaperType,
    );

    Navigator.pop(context, newOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text('Добавить в корзину')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Заголовок заказа'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Описание заказа'),
            ),
            DropdownButton<String>(
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            DropdownButton<PaperType>(
              value: selectedPaperType,
              onChanged: (PaperType? newValue) {
                setState(() {
                  selectedPaperType = newValue!;
                });
              },
              items: paperTypes.map<DropdownMenuItem<PaperType>>((PaperType paperType) {
                return DropdownMenuItem<PaperType>(
                  value: paperType,
                  child: Text(paperType.toString().split('.').last),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _saveOrder,
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
