
import 'package:eccommerce_app/features/cart_feature/data/models/favourites_models/add_or_delete_favourite_model.dart';
class GetAllFavouriteModel{
  num ? subTotal;
  num ? total;
  List<AddOrDeleteToFavouriteModel> favourites = [];

  GetAllFavouriteModel({this.subTotal, this.total, this.favourites= const []});

  GetAllFavouriteModel.fromJson(dynamic json){
    subTotal = json["sub_total"];
    total = json["total"];
    if(json["data"] != null){
      favourites = [];
      json['data'].forEach((v) {
        favourites.add(AddOrDeleteToFavouriteModel.fromJson(v));
      });
    }
  }
}