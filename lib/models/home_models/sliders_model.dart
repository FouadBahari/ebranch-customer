class SlidersModel {
  bool? status;
  List<Data>? data;
  String? message;

  SlidersModel({this.status, this.data, this.message});

  SlidersModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? image;
  String? title;
  String? titleAr;
  int? marketId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.image,
        this.title,
        this.titleAr,
        this.marketId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['photo'];
    title = json['title'];
    titleAr = json['title_ar'];
    marketId = json['market_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.image;
    data['title'] = this.title;
    data['title_ar'] = this.titleAr;
    data['market_id'] = this.marketId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}