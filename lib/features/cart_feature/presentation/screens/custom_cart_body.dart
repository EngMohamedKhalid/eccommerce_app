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
import '../widgets/custom_cart_item.dart';

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
        return state is CartLoading?Loading():
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
                          //cubit.removeCartItem(cubit.cartItems!.carItems[index].id.toString());
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
                    saveOnPressed: () {
                    //   cubit.saveCartItemForLater(
                    //     cubit.cartItems!.carItems[index].id.toString()
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
            Divider(color: const Color(0xFFE0E0E0),),
            16.verticalSpace,
            TextWidget(
              title:"",
              //"${"Sub-Total".tr()} (${cubit.cartItems?.carItems.length??0} Items): ${cubit.cartItems?.totalPrice??"0"} EGP",
              fontFamily: AppFonts.semiBold,
              titleSize: 16.sp,
              titleColor: AppColors.black3333,
            ),
            16.verticalSpace,
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 16),
              child: ButtonWidget(
                //loading: state is CheckOutLoading,
                onPressed: () {
                 // cubit.checkOut();
                },
                text: "ProceedBuy".tr(),
              ),
            ),
          ],
        );
      },
    );
  }
}



