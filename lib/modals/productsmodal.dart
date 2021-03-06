import 'package:hive/hive.dart';
part 'productsmodal.g.dart';

@HiveType(typeId: 10)
class Products {
  @HiveField(0)
  String longDescription;
  @HiveField(1)
  List<Images> images;
  @HiveField(2)
  dynamic quantity;
  @HiveField(3)
  dynamic salesPrice;
  @HiveField(4)
  dynamic regularPrice;
  @HiveField(5)
  dynamic weightG;
  @HiveField(6)
  String stockStatus;
  @HiveField(7)
  String length;
  @HiveField(8)
  dynamic rating;
  @HiveField(9)
  String shortDescription;
  @HiveField(10)
  String subCategory;
  @HiveField(11)
  String subbrand;
  @HiveField(12)
  String name;
  @HiveField(13)
  String width;
  @HiveField(14)
  dynamic onSale;
  @HiveField(15)
  dynamic id;
  @HiveField(16)
  String category;
  @HiveField(17)
  String brand;
  @HiveField(18)
  dynamic setOf;
  @HiveField(19)
  String height;

  Products(
      {this.longDescription,
      this.images,
      this.quantity,
      this.salesPrice,
      this.regularPrice,
      this.weightG,
      this.stockStatus,
      this.length,
      this.rating,
      this.shortDescription,
      this.subCategory,
      this.subbrand,
      this.name,
      this.width,
      this.onSale,
      this.id,
      this.category,
      this.brand,
      this.setOf,
      this.height});

  Products.fromJson(Map<String, dynamic> json) {
    longDescription = json['longDescription'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
    quantity = json['quantity'];
    salesPrice = json['salesPrice'];
    regularPrice = json['regularPrice'];
    weightG = json['weight (g)'];
    stockStatus = json['stock-status'];
    length = json['length'];
    rating = json['rating'];
    shortDescription = json['short-description'];
    subCategory = json['sub-category'];
    subbrand = json['subbrand'];
    name = json['name'];
    width = json['width'];
    onSale = json['onSale'];
    id = json['id'];
    category = json['category'];
    brand = json['brand'];
    setOf = json['setOf'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['longDescription'] = longDescription;
    if (images != null) {
      data['images'] = images.map((v) => v.toJson()).toList();
    }
    data['quantity'] = quantity;
    data['salesPrice'] = salesPrice;
    data['regularPrice'] = regularPrice;
    data['weight (g)'] = weightG;
    data['stock-status'] = stockStatus;
    data['length'] = length;
    data['rating'] = rating;
    data['short-description'] = shortDescription;
    data['sub-category'] = subCategory;
    data['subbrand'] = subbrand;
    data['name'] = name;
    data['width'] = width;
    data['onSale'] = onSale;
    data['id'] = id;
    data['category'] = category;
    data['brand'] = brand;
    data['setOf'] = setOf;
    data['height'] = height;
    return data;
  }
}

@HiveType(typeId: 11)
class Images {
  @HiveField(0)
  String number;
  @HiveField(1)
  String src;

  Images({this.number, this.src});

  Images.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['number'] = number;
    data['src'] = src;
    return data;
  }
}
