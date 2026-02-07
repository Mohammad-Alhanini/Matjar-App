class ProductModel {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }
  }
}
