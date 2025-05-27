import 'package:hive/hive.dart';

part 'hive_product.g.dart';

@HiveType(typeId: 0)
class HiveProduct extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? category;

  @HiveField(4)
  double? price;

  @HiveField(5)
  double? discountPercentage;

  @HiveField(6)
  double? rating;

  @HiveField(7)
  int? stock;

  @HiveField(8)
  List<String>? tags;

  @HiveField(9)
  String? brand;

  @HiveField(10)
  String? sku;

  @HiveField(11)
  int? weight;

  @HiveField(12)
  String? warrantyInformation;

  @HiveField(13)
  String? shippingInformation;

  @HiveField(14)
  String? availabilityStatus;

  @HiveField(15)
  String? returnPolicy;

  @HiveField(16)
  int? minimumOrderQuantity;

  @HiveField(17)
  List<String>? images;

  @HiveField(18)
  String? thumbnail;

  @HiveField(19)
  int qty = 1;

  HiveProduct({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.images,
    this.thumbnail,
    this.qty = 1,
  });

  factory HiveProduct.fromJson(Map<String, dynamic> json) => HiveProduct(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    category: json["category"],
    price: json["price"]?.toDouble(),
    discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    tags: json["tags"] == null
        ? []
        : List<String>.from(json["tags"]!.map((x) => x)),
    brand: json["brand"],
    sku: json["sku"],
    weight: json["weight"],
    warrantyInformation: json["warrantyInformation"],
    shippingInformation: json["shippingInformation"],
    availabilityStatus: json["availabilityStatus"],
    returnPolicy: json["returnPolicy"],
    minimumOrderQuantity: json["minimumOrderQuantity"],
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x)),
    thumbnail: json["thumbnail"],
    qty: json["qty"] ?? 1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": category,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "brand": brand,
    "sku": sku,
    "weight": weight,
    "warrantyInformation": warrantyInformation,
    "shippingInformation": shippingInformation,
    "availabilityStatus": availabilityStatus,
    "returnPolicy": returnPolicy,
    "minimumOrderQuantity": minimumOrderQuantity,
    "images": images == null
        ? []
        : List<dynamic>.from(images!.map((x) => x)),
    "thumbnail": thumbnail,
    "qty": qty,
  };
}
