class ChatModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  ChatModel({this.status, this.errNum, this.msg, this.data});

  ChatModel.fromJson(Map<dynamic, dynamic> json) {
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
  int? userId;
  int? vendorId;
  String? message;
  String? send;
  String? createdAt;
  String? updatedAt;
  Vendor? vendor;

  Data({this.id, this.userId, this.vendorId, this.message, this.send, this.createdAt, this.updatedAt, this.vendor});

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.userId = json["user_id"];
    this.vendorId = json["vendor_id"];
    this.message = json["message"];
    this.send = json["send"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
    this.vendor = json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["user_id"] = this.userId;
    data["vendor_id"] = this.vendorId;
    data["message"] = this.message;
    data["send"] = this.send;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    if(this.vendor != null)
      data["vendor"] = this.vendor!.toJson();
    return data;
  }
}

class Vendor {
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
  String? createdAt;
  String? updatedAt;

  Vendor({this.id, this.name, this.email, this.phone, this.type, this.emailVerifiedAt, this.photo, this.serviceId, this.address, this.lat, this.lang, this.wallet, this.status, this.rate, this.token, this.createdAt, this.updatedAt});

  Vendor.fromJson(Map<String, dynamic> json) {
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
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}