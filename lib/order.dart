enum PaperType {
  Glossy,
  Matte,
  Satin,
}
class Order {
  String id;
  String purchaseId;
  String title;
  String description;
  String option;
  PaperType paperType;


  Order({
    required this.id,
    required this.purchaseId,
    required this.title,
    required this.description,
    required this.option,
    required this.paperType,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'purchaseId': purchaseId,
      'title': title,
      'description': description,
      'option': option,
      'paperType': paperType.toString().split('.').last,
    };
  }


  static Order fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      purchaseId: map['purchaseId'],
      title: map['title'],
      description: map['description'],
      option: map['option'],
      paperType: PaperType.values.firstWhere((e) => e.toString().split('.').last == map['paperType']),
    );
  }
}
