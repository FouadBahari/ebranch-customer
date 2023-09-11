class AllCatsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  AllCatsModel({this.status, this.errNum, this.msg, this.data});

  AllCatsModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? name;
  String? email;
  String? phone;
  String? type;
  dynamic count;
  dynamic emailVerifiedAt;
  String? photo;
  int? serviceId;
  String? address;
  String? lat;
  String? lang;
  int? wallet;
  int? status;
  int? rate;
  int? seenUser;
  String? token;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.name, this.email, this.phone,this.seenUser, this.type,this.count, this.emailVerifiedAt, this.photo, this.serviceId, this.address, this.lat, this.lang, this.wallet, this.status, this.rate, this.token, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.email = json["email"];
    this.phone = json["phone"];
    this.type = json["type"];
    this.count = json["count"];
    this.emailVerifiedAt = json["email_verified_at"];
    this.photo = json["photo"];
    this.serviceId = json["service_id"];
    this.address = json["address"];
    this.lat = json["lat"];
    this.lang = json["lang"];
    this.wallet = json["wallet"];
    this.status = json["status"];
    this.rate = json["rate"];
    this.seenUser = json["seen_user"];
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
    data["count"] = this.count;
    data["email_verified_at"] = this.emailVerifiedAt;
    data["photo"] = this.photo;
    data["service_id"] = this.serviceId;
    data["address"] = this.address;
    data["lat"] = this.lat;
    data["lang"] = this.lang;
    data["wallet"] = this.wallet;
    data["status"] = this.status;
    data["rate"] = this.rate;
    data["seen_user"] = this.seenUser;
    data["token"] = this.token;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}