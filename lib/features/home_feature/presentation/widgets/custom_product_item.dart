import 'package:eccommerce_app/features/categories_feature/data/models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/app_fonts.dart';
import '../../../../app/widgets/flutter_toast.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/text_widget.dart';
import '../../../cart_feature/presentation/presentation_logic_holder/cart_cubit.dart';
import 'custom_add_to_card.dart';

class CustomProductItemDetails extends StatelessWidget {
  const CustomProductItemDetails({super.key, required this.productDetails});
  final ProductDetails productDetails;
  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      child: Banner(
        message: "${productDetails.discount}% Off",
        location: BannerLocation.topStart,
        color: AppColors.red,
        textStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600
        ),
        child: Container(
          width: double.infinity,
          height: 130.h,
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsetsDirectional.all(12.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white
          ),
          child: Row(
            children: [
              ImageWidget(imageUrl: productDetails.image!,height: 75.h,width: 100.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.verticalSpace,
                    TextWidget(
                      title: productDetails.name!,
                      titleColor: AppColors.black3333,
                      titleSize: 14.sp,
                      titleMaxLines: 1,
                      fontFamily: AppFonts.bold,
                    ),
                    16.verticalSpace,
                    Row(
                      children: [
                    Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextWidget(
                                  title: "${productDetails.price}EGP",
                                  titleColor: AppColors.black3333,
                                  titleSize: 14.sp,
                                  fontFamily: AppFonts.bold,
                                ),
                                4.horizontalSpace,
                                TextWidget(
                                  title: "${productDetails.oldPrice}EGP",
                                  titleColor: AppColors.hint,
                                  textDecoration: TextDecoration.lineThrough,
                                  titleSize: 14.sp,
                                ),
                              ],
                            ),

                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: ()async {
                            await CartCubit.get().addOrRemoveFavourite(
                              id: productDetails.id!.toInt(),
                            ).then((value) {
                              showToast(msg: "Added To Favourites Successfully",);
                            });
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: AppColors.gery455,
                            size: 30.sp,
                          ),
                        ),
                        CustomAddToCard(
                          id: productDetails.id!.toInt(),
                          size: 40.w,
                        ),

                      ],
                    ),
                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
