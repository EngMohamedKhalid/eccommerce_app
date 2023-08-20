import 'package:eccommerce_app/features/cart_feature/data/models/add_or_delete_cart_model.dart';

class GetAllCartModel{
  num ? subTotal;
  num ? total;
  List<AddOrDeleteToCartModel> carts = [];

  GetAllCartModel({this.subTotal, this.total, this.carts= const []});

  GetAllCartModel.fromJson(dynamic json){
    subTotal = json["sub_total"];
    total = json["total"];
    if(json["cart_items"] != null){
      carts = [];
      json['cart_items'].forEach((v) {
        carts.add(AddOrDeleteToCartModel.fromJson(v));
      });
    }
  }
}