const keyId = 'id';
const keyName = 'pizzaName';
const keyDescription = 'description';
const keyPrice = 'price';
const keyImage = 'imageUrl';

class Pizza {
  int? id;
  String? pizzaName;
  String? description;
  double? price;
  String? imageUrl;

  Pizza();

  Pizza.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[keyId]?.toString() ?? '0') ?? 0;
    pizzaName = json[keyName]?.toString() ?? '';
    description = json[keyDescription]?.toString() ?? '';
    price = double.tryParse(json[keyPrice]?.toString() ?? '0.0') ?? 0.0;
    imageUrl = json[keyImage]?.toString() ?? '';
  }

  factory Pizza.fromJsonOrNull(Map<String, dynamic> json) {
    Pizza pizza = Pizza();
    pizza.id = int.tryParse(json[keyId]?.toString() ?? '0') ?? 0;
    pizza.pizzaName = json[keyName]?.toString() ?? '';
    pizza.description = json[keyDescription]?.toString() ?? '';
    pizza.price = double.tryParse(json[keyPrice]?.toString() ?? '0.0') ?? 0.0;
    pizza.imageUrl = json[keyImage]?.toString() ?? '';
    if (pizza.id == 0 || pizza.pizzaName!.trim() == '') {
      return Pizza();
    }
    return pizza;
  }

  Map<String, dynamic> toJson() {
    return {
      keyId: id,
      keyName: pizzaName,
      keyDescription: description,
      keyPrice: price,
      keyImage: imageUrl,
    };
  }
}
