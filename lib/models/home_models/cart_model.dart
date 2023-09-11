import 'markets_model.dart';

class CartModel {
  bool? status;
  String? errNum;
  dynamic price;
  dynamic price2;
  String? msg;
  Vendors? vendor;
  List<CartData>? data ;

  CartModel({this.status, this.errNum, this.vendor,this.msg, this.data});

  CartModel.fromJson(Map<dynamic, dynamic> json) {
    this.status = json["status"];
    this.errNum = json["errNum"];
    this.msg = json["msg"];
    this.price = json["price"];
    this.price2 = json["price2"];
    this.data = (json["data"]==null ? null : (json["data"] as List).map((e)=>CartData.fromJson(e)).toList())!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = this.status;
    data["errNum"] = this.errNum;
    data["msg"] = this.msg;
    data["price"] = this.price;
    data["price2"] = this.price2;
    if(this.data != null)
      data["data"] = this.data!.map((e)=>e.toJson()).toList();
    return data;
  }
}

class CartData {
  int? id;
  String? name;
  double? price;
  String? photo;
  int? quantity;
  int? offer;
  String? description;
  dynamic userId;
  dynamic catId;
  double? amount;
  String? colors;
  String? sizes;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  CartData({this.id, this.name, this.price, this.photo, this.offer, this.description, this.userId, this.quantity = 1 ,this.catId, this.amount, this.colors, this.sizes, this.createdAt, this.updatedAt, this.pivot});

  CartData.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.price = double.parse(json["price"].toString());
    this.quantity = json["quantity"];
    this.photo = json["photo"];
    this.offer = int.parse(json["offer"].toString());
    this.description = json["description"];
    this.userId = json["user_id"];
    this.catId = json["cat_id"];
    this.amount = double.parse(json["amount"].toString());
    this.colors = json["colors"];
    this.sizes = json["sizes"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
    this.pivot = json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["price"] = this.price;
    data["photo"] = this.photo;
    data["quantity"] = this.quantity;
    data["offer"] = this.offer;
    data["description"] = this.description;
    data["user_id"] = this.userId;
    data["cat_id"] = this.catId;
    data["amount"] = this.amount;
    data["colors"] = this.colors;
    data["sizes"] = this.sizes;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    if(this.pivot != null)
      data["pivot"] = this.pivot!.toJson();
    return data;
  }
}

class Pivot {
  dynamic userId;
  dynamic productId;

  Pivot({this.userId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    this.userId = json["user_id"];
    this.productId = json["product_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["user_id"] = this.userId;
    data["product_id"] = this.productId;
    return data;
  }
}