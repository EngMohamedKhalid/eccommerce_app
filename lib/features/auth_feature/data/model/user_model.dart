// class UserModel {
//   UserModel({
//       this.id,
//       this.name,
//       this.email,
//       this.countryCode,
//       this.phone,
//       this.fullPhone,
//       this.lang,
//       this.isNotify,
//       this.token,
//       this.type,
//       this.image,
//       this.documents,
//       this.companyName,
//       this.commodity,});
//
//   UserModel.fromMap(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     countryCode = json['country_code'];
//     phone = json['phone'];
//     fullPhone = json['full_phone'];
//     lang = json['lang'];
//     isNotify = json['is_notify'];
//     token = json['token'];
//     type = json['type'];
//     image = json['image'];
//     documents = json['documents'];
//     companyName = json['company_name'];
//     commodity = json['commodity'];
//     isUser  = json['type']=='user';
//   }
//   num? id;
//   String? name;
//   String? email;
//   String? countryCode;
//   String? phone;
//   String? fullPhone;
//   String? lang;
//   bool? isNotify;
//   String? token;
//   String? type;
//   String? image;
//   String? documents;
//   dynamic companyName;
//   dynamic commodity;
//   bool? isUser;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['email'] = email;
//     map['country_code'] = countryCode;
//     map['phone'] = phone;
//     map['full_phone'] = fullPhone;
//     map['lang'] = lang;
//     map['is_notify'] = isNotify;
//     map['token'] = token;
//     map['type'] = type;
//     map['image'] = image;
//     map['documents'] = documents;
//     map['company_name'] = companyName;
//     map['commodity'] = commodity;
//     map['isUser'] = isUser;
//     return map;
//   }
//
// }

import 'dart:convert';

import '../../../../app/error/exceptions.dart';

class UserModel{
  int? id;
  int? points;
  int? credit;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  String? deviceToken;

  UserModel(
      {this.id,
        this.credit,
        this.points,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.token,
      this.deviceToken}
      );

  UserModel.fromMap(dynamic json){
    id = json['id'];
    points = json['points'];
    credit = json['credit'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
    image = json['image'];
    deviceToken = json["device_token"];
  }

  Map<String, dynamic>toJson(){
    final map = <String, dynamic>{};
    map['id']= id ;
    map['credit']= credit ;
    map['points']= points ;
    map['name']=name ;
    map['email']= email;
    map['phone']=  phone;
    map['token']=  token;
    map['image']=   image ;
    map["device_token"]=  deviceToken;
    return map;
  }

  factory UserModel.fromJson(String source) {
    try {
      return UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
    } catch (e) {
      throw DataParsingException(e.toString());
    }
  }


}