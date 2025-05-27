ProductsModel productsModelFromJson(Map<String, dynamic> obj) =>
    ProductsModel.fromJson(obj);

class ProductsModel {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductsModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      ProductsModel(
        products: json["products"] == null
            ? []
            : List<Product>.from(
            json["products"]!.map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() =>
      {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };

  ProductsModel copyWith({
    List<Product>? products,
    int? total,
    int? skip,
    int? limit,
  }) {
    return ProductsModel(
      products: products ?? this.products,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }
}

class Product {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  int? weight;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  String? returnPolicy;
  int? minimumOrderQuantity;
  List<String>? images;
  String? thumbnail;
  int qty;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
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
        qty: 1,
      );

  Map<String, dynamic> toJson() =>
      {
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
        "images":
        images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": thumbnail,
        "qty": qty,
      };
}


