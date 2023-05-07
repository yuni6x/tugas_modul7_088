class ProductModel {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,
  };
}
