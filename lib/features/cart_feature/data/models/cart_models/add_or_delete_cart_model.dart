import '../../../../categories_feature/data/models/product_details.dart';

class AddOrDeleteToCartModel{
  num? id;
  num? quantity;
  ProductDetails? productDetails ;

  AddOrDeleteToCartModel({this.id, this.quantity, this.productDetails});

  AddOrDeleteToCartModel.fromJson(dynamic json){
    id = json["id"];
    quantity = json["quantity"];
    productDetails = ProductDetails.fromJson(json["product"]);
  }
}
