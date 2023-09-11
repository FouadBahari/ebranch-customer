class NotificationModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  NotificationModel({this.status, this.errNum, this.msg, this.data});

  NotificationModel.fromJson(Map<dynamic, dynamic> json) {
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
  int? orderId;
  int? userId;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;
  User? user;
  dynamic order;

  Data({this.id, this.orderId, this.userId, this.title, this.body, this.createdAt, this.updatedAt, this.user, this.order});

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.orderId = json["order_id"];
    this.userId = json["user_id"];
    this.title = json["title"];
    this.body = json["body"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
    this.user = json["user"] == null ? null : User.fromJson(json["user"]);
    this.order = json["order"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["order_id"] = this.orderId;
    data["user_id"] = this.userId;
    data["title"] = this.title;
    data["body"] = this.body;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    if(this.user != null)
      data["user"] = this.user!.toJson();
    data["order"] = this.order;
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
  int? rate;
  String? token;
  dynamic webToken;
  dynamic date;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.name, this.email, this.phone, this.type, this.emailVerifiedAt, this.photo, this.serviceId, this.address, this.lat, this.lang, this.wallet, this.status, this.rate, this.token, this.webToken, this.date, this.createdAt, this.updatedAt});

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
    this.rate = json["rate"];
    this.token = json["token"];
    this.webToken = json["web_token"];
    this.date = json["date"];
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
    data["rate"] = this.rate;
    data["token"] = this.token;
    data["web_token"] = this.webToken;
    data["date"] = this.date;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}