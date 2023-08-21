import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/app_fonts.dart';
import '../../../../app/widgets/button_widget.dart';
import '../../../../app/widgets/custom_alert_dialog.dart';
import '../../../../app/widgets/loading.dart';
import '../../../../app/widgets/text_widget.dart';
import '../presentation_logic_holder/cart_cubit.dart';
import 'custom_cart_item.dart';

class CustomCartBody extends StatefulWidget {
  const CustomCartBody({super.key});

  @override
  State<CustomCartBody> createState() => _CustomCartBodyState();
}

class _CustomCartBodyState extends State<CustomCartBody> {
  @override
  void initState() {
    super.initState();
    CartCubit.get().getAllCart();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var cubit = CartCubit.get();
        return state is CartLoading? const Loading():
        Column(
          children: [
            Expanded(
              child:ListView.builder(
                padding: const EdgeInsets.all(16),
                physics:const BouncingScrollPhysics(),
                itemCount: cubit.getAllCartModel?.carts.length??0,
                itemBuilder: (context, index) {
                  return
                    CustomCartItem(
                    deleteOnPressed: () {
                      globalAlertDialogue(
                        "Delete".tr(),
                        buttonText2: "yes".tr(),
                        buttonText: "No".tr(),
                        canCancel: true,
                        onOk: () {
                          cubit.addOrRemoveCart(
                              id:cubit.getAllCartModel?.carts[index].productDetails?.id?.toInt()??0,
                          );
                          Navigator.pop(context);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                      );
                      },
                    minusOnPressed: () {
                      // if((cubit.cartItems?.carItems[index].quantity?.toInt()??1)>1){
                      //   cubit.updateCartQuantity("${(cubit.cartItems?.carItems[index].quantity?.toInt()??1)-1}",
                      //       cubit.cartItems!.carItems[index].id.toString());
                      // }
                    },
                    addOnPressed: () {
                      // if((cubit.cartItems?.carItems[index].quantity?.toInt()??1)<
                      //     (cubit.cartItems?.carItems[index].product?.quantity?.toInt()??1)){
                      //   cubit.updateCartQuantity("${(cubit.cartItems?.carItems[index].quantity?.toInt()??1)+1}",
                      //       cubit.cartItems!.carItems[index].id.toString());
                      // }
                      },
                    saveOnPressed: ()async {
                      await cubit.addToFavourite(id: cubit.getAllCartModel?.carts[index].productDetails?.id?.toInt()??0);
                      // await cubit.addOrRemoveFavourite(
                      //     id: cubit.getAllCartModel?.carts[index].productDetails?.id?.toInt()??0
                      // );
                      // await CartCubit.get().addOrRemoveCart(
                      //     id: cubit.getAllCartModel?.carts[index].productDetails?.id?.toInt()??0
                      // );
                      },
                    //countNum:
                    //cubit.cartItems?.carItems[index].quantity?.toInt()??0,
                    isCart: true,
                   // title:  cubit.cartItems?.carItems[index].product?.name??"",
                    imageName: cubit.getAllCartModel?.carts[index].productDetails?.image??"",
                    price: cubit.getAllCartModel?.carts[index].productDetails?.price.toString()??"",
                    //piecesNum:cubit.cartItems?.carItems[index].product?.quantity?.toInt()??0,

                  );
                },
              )
            ),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     const TextWidget(
                          title: "Total Price",
                        titleColor: AppColors.gery455,
                        titleFontWeight: FontWeight.w600,
                      ),
                      5.verticalSpace,
                      TextWidget(
                          title: "${cubit.getAllCartModel?.total.toString()??"0"} EGP",
                        titleColor: AppColors.mainColor,
                        titleFontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: ButtonWidget(
                      //loading: state is CheckOutLoading,
                      onPressed: () {
                       // cubit.checkOut();
                      },
                      text: "ProceedBuy".tr(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}



