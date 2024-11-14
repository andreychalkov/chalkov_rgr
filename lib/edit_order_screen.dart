import 'package:flutter/material.dart';
import 'package:rgr_application/order.dart';

class EditOrderScreen extends StatefulWidget {
  final Order order;
  final Function(Order) onOrderUpdated;

  EditOrderScreen({required this.order, required this.onOrderUpdated});

  @override
  _EditOrderScreenState createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  String selectedOption = '';
  PaperType selectedPaperType = PaperType.Glossy;

  List<String> options = ['А2', 'А3', 'А4'];
  List<PaperType> paperTypes = PaperType.values;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.order.title);
    _descriptionController = TextEditingController(text: widget.order.description);
    selectedOption = widget.order.option;
    selectedPaperType = widget.order.paperType;
  }

  void _updateOrder() {
    final updatedOrder = Order(
      id: widget.order.id,
      purchaseId: widget.order.purchaseId,
      title: _titleController.text,
      description: _descriptionController.text,
      option: selectedOption,
      paperType: selectedPaperType,
    );

    widget.onOrderUpdated(updatedOrder);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text('Редактировать заказ')),
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
              onPressed: _updateOrder,
              child: const Text('Сохранить изменения'),
            ),
          ],
        ),
      ),
    );
  }
}
