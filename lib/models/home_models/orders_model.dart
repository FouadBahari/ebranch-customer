class OrderModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  OrderModel({this.status, this.errNum, this.msg, this.data});

  OrderModel.fromJson(Map<dynamic, dynamic> json) {
    this.status = json["status"];
    this.errNum = json["errNum"];
    this.msg = json["msg"];
    this.data = json["data"]==null ? null : (json["data"] as List).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = this.status;
    data["errNum"] = this.errNum;
    data["msg"] = this.msg;
    if(this.data != null)
      data["data"] = this.data!.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Data {
  int? id;
  String? productId;
  String? amount;
  double? price;
  int? userId;
  int? driverId;
  String? address;
  String? photo;
  String? lat;
  String? lang;
  String? status;
  String? type;
  dynamic rate;
  dynamic replay;
  dynamic deliveryPrice;
  dynamic code;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;
  Driver? driver;

  Data({this.id, this.productId, this.amount, this.price, this.userId, this.driverId, this.address, this.lat, this.lang, this.status, this.type, this.rate, this.replay, this.createdAt, this.updatedAt, this.products, this.driver});

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.productId = json["product_id"];
    this.amount = json["amount"];
    this.price = double.parse(json["price"].toString());
    this.userId = json["user_id"];
    this.driverId = json["driver_id"];
    this.address = json["address"];
    this.photo = json["photo"];
    this.lat = json["lat"];
    this.lang = json["lang"];
    this.status = json["status"];
    this.type = json["type"];
    this.rate = json["rate"];
    this.replay = json["replay"];
    this.deliveryPrice = json["deleveryprice"];
    this.code = json["code"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
    this.products = json["products"]==null ? null : (json["products"] as List).map((e)=>Products.fromJson(e)).toList();
    this.driver = json["driver"] == null ? null : Driver.fromJson(json["driver"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["product_id"] = this.productId;
    data["amount"] = this.amount;
    data["price"] = this.price;
    data["user_id"] = this.userId;
    data["driver_id"] = this.driverId;
    data["address"] = this.address;
    data["photo"] = this.photo;
    data["lat"] = this.lat;
    data["lang"] = this.lang;
    data["status"] = this.status;
    data["type"] = this.type;
    data["rate"] = this.rate;
    data["replay"] = this.replay;
    data["deleveryprice"] = this.deliveryPrice;
    data["code"] = this.code;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    if(this.products != null)
      data["products"] = this.products!.map((e)=>e.toJson()).toList();
    if(this.driver != null)
      data["driver"] = this.driver!.toJson();
    return data;
  }
}

class Driver {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? type;
  dynamic emailVerifiedAt;
  String? photo;
  int? serviceId;
  String? address;
  String? lat;
  String? lang;
  int? wallet;
  int? status;
  String? token;
  String? createdAt;
  String? updatedAt;

  Driver({this.id, this.name, this.email, this.phone, this.type, this.emailVerifiedAt, this.photo, this.serviceId, this.address, this.lat, this.lang, this.wallet, this.status, this.token, this.createdAt, this.updatedAt});

  Driver.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.email = json["email"];
    this.phone = json["phone"];
    this.type = json["type"];
    this.emailVerifiedAt = json["email_verified_at"];
    this.photo = json["photo"];
    this.serviceId = json["service_id"];
    this.address = json["address"];
    this.lat = json["lat"];
    this.lang = json["lang"];
    this.wallet = json["wallet"];
    this.status = json["status"];
    this.token = json["token"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["email"] = this.email;
    data["phone"] = this.phone;
    data["type"] = this.type;
    data["email_verified_at"] = this.emailVerifiedAt;
    data["photo"] = this.photo;
    data["service_id"] = this.serviceId;
    data["address"] = this.address;
    data["lat"] = this.lat;
    data["lang"] = this.lang;
    data["wallet"] = this.wallet;
    data["status"] = this.status;
    data["token"] = this.token;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  int? price;
  String? photo;
  int? offer;
  String? description;
  int? userId;
  int? catId;
  int? amount;
  String? colors;
  String? sizes;
  String? createdAt;
  String? updatedAt;
  User? user;

  Products({this.id, this.name, this.price, this.photo, this.offer, this.description, this.userId, this.catId, this.amount, this.colors, this.sizes, this.createdAt, this.updatedAt, this.user});

  Products.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.price = json["price"];
    this.photo = json["photo"];
    this.offer = json["offer"];
    this.description = json["description"];
    this.userId = json["user_id"];
    this.catId = json["cat_id"];
    this.amount = json["amount"];
    this.colors = json["colors"];
    this.sizes = json["sizes"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
    this.user = json["user"] == null ? null : User.fromJson(json["user"]);
    // this.cat = json["cat"] == null ? null : Cat.fromJson(json["cat"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["price"] = this.price;
    data["photo"] = this.photo;
    data["offer"] = this.offer;
    data["description"] = this.description;
    data["user_id"] = this.userId;
    data["cat_id"] = this.catId;
    data["amount"] = this.amount;
    data["colors"] = this.colors;
    data["sizes"] = this.sizes;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    if(this.user != null)
      data["user"] = this.user!.toJson();
    // if(this.cat != null)
    //   data["cat"] = this.cat!.toJson();
    return data;
  }
}

class Cat {
  int? id;
  String? name;
  int? userId;
  String? photo;
  String? createdAt;
  String? updatedAt;

  Cat({this.id, this.name, this.userId, this.photo, this.createdAt, this.updatedAt});

  Cat.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.userId = json["user_id"];
    this.photo = json["photo"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["user_id"] = this.userId;
    data["photo"] = this.photo;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? type;
  dynamic emailVerifiedAt;
  String? photo;
  int? serviceId;
  String? address;
  String? lat;
  String? lang;
  int? wallet;
  int? status;
  String? token;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.name, this.email, this.phone, this.type, this.emailVerifiedAt, this.photo, this.serviceId, this.address, this.lat, this.lang, this.wallet, this.status, this.token, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.email = json["email"];
    this.phone = json["phone"];
    this.type = json["type"];
    this.emailVerifiedAt = json["email_verified_at"];
    this.photo = json["photo"];
    this.serviceId = json["service_id"];
    this.address = json["address"];
    this.lat = json["lat"];
    this.lang = json["lang"];
    this.wallet = json["wallet"];
    this.status = json["status"];
    this.token = json["token"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["email"] = this.email;
    data["phone"] = this.phone;
    data["type"] = this.type;
    data["email_verified_at"] = this.emailVerifiedAt;
    data["photo"] = this.photo;
    data["service_id"] = this.serviceId;
    data["address"] = this.address;
    data["lat"] = this.lat;
    data["lang"] = this.lang;
    data["wallet"] = this.wallet;
    data["status"] = this.status;
    data["token"] = this.token;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}