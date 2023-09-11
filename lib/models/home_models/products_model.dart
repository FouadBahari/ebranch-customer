class ProductsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  ProductsModel({this.status, this.errNum, this.msg, this.data});

  ProductsModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  double? price;
  String? photo;
  int? offer;
  String? description;
  dynamic userId;
  dynamic catId;
  double? amount;
  String? colors;
  String? sizes;
  String? createdAt;
  String? updatedAt;
  Cat? cat;

  Data(
      {this.id,
        this.name,
        this.price,
        this.photo,
        this.offer,
        this.description,
        this.userId,
        this.catId,
        this.amount,
        this.colors,
        this.sizes,
        this.createdAt,
        this.updatedAt,
        this.cat});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
    photo = json['photo'];
    offer = int.parse(json['offer'].toString());
    description = json['description'];
    userId = json['user_id'];
    catId = json['cat_id'];
    amount = double.parse(json['amount'].toString());
    colors = json['colors'];
    sizes = json['sizes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cat = json['cat'] != null ? new Cat.fromJson(json['cat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['offer'] = this.offer;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['cat_id'] = this.catId;
    data['amount'] = this.amount;
    data['colors'] = this.colors;
    data['sizes'] = this.sizes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.cat != null) {
      data['cat'] = this.cat!.toJson();
    }
    return data;
  }
}

class Cat {
  int? id;
  String? name;
  dynamic userId;
  String? photo;
  String? createdAt;
  String? updatedAt;

  Cat(
      {this.id,
        this.name,
        this.userId,
        this.photo,
        this.createdAt,
        this.updatedAt});

  Cat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class ProductData {
//  int? id;
  String? name;
  String? price;
  String? photo;
  int? offer;
  String? description;
 // dynamic userId;
 // dynamic catId;
  double? amount;
  String? colors;
  String? sizes;
//  String? createdAt;
 // String? updatedAt;
  Cat? cat;

  ProductData(
      {//this.id,
        this.name,
        this.price,
        this.photo,
        this.offer,
        this.description,
       // this.userId,
        //this.catId,
        this.amount,
        this.colors,
        this.sizes,
       // this.createdAt,
        //this.updatedAt,
        this.cat});

  ProductData.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    name = json['name'];
    price = json['price'];
    photo = json['photo'];
    offer = int.parse(json['offer'].toString());
    description = json['description'];
 //   userId = json['user_id'];
   // catId = json['cat_id'];
    amount = double.parse(json['amount'].toString());
    colors = json['colors'];
    sizes = json['sizes'];
 //   createdAt = json['created_at'];
   // updatedAt = json['updated_at'];
    cat = json['cat'] != null ? new Cat.fromJson(json['cat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['offer'] = this.offer;
    data['description'] = this.description;
   // data['user_id'] = this.userId;
    //data['cat_id'] = this.catId;
    data['amount'] = this.amount;
    data['colors'] = this.colors;
    data['sizes'] = this.sizes;
  //  data['created_at'] = this.createdAt;
    //data['updated_at'] = this.updatedAt;
    if (this.cat != null) {
      data['cat'] = this.cat!.toJson();
    }
    return data;
  }
}