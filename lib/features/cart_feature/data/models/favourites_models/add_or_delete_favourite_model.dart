import '../../../../categories_feature/data/models/product_details.dart';

class AddOrDeleteToFavouriteModel{
  num? id;
  num? quantity;
  ProductDetails? productDetails ;

  AddOrDeleteToFavouriteModel({this.id, this.quantity, this.productDetails});

  AddOrDeleteToFavouriteModel.fromJson(dynamic json){
    id = json["id"];
    quantity = json["quantity"];
    productDetails = ProductDetails.fromJson(json["product"]);
  }
}
