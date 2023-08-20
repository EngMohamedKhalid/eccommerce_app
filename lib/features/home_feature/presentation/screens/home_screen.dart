import 'package:easy_localization/easy_localization.dart';
import 'package:eccommerce_app/app/widgets/loading.dart';
import 'package:eccommerce_app/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:eccommerce_app/features/home_feature/presentation/presentation_logic_holder/home_cubit.dart';
import 'package:eccommerce_app/features/home_feature/presentation/presentation_logic_holder/home_state.dart';
import 'package:eccommerce_app/features/home_feature/presentation/widgets/custom_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/services/cache_service.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/widgets/carousel_widget/carousel_widget.dart';
import '../../../../app/widgets/default_app_bar_widget.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/text_widget.dart';
import '../../../categories_feature/presentation/screens/product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get().getHomeData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get();
        return Scaffold(
          appBar: DefaultAppBarWidget(
            actionsOnPressed: () {
              //navigateTo(const NotificationScreen());
            },
            onPop: () {},
            actions: true,
            leading: const ImageWidget(
              imageUrl: "assets/icons/splash.svg",
              color: AppColors.mainColor,
            ),
            titleWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  title: "HelloMr".tr(),
                  titleFontWeight: FontWeight.w400,
                  titleSize: 20.sp,
                  titleColor: AppColors.gery455,
                ),
                TextWidget(
                  title: getIt<CacheService>()
                      .getUserData()
                      ?.name ?? "",
                  titleFontWeight: FontWeight.bold,
                  titleSize: 22.sp,
                  titleColor: AppColors.gery455,
                ),
              ],
            ),
          ),
          body:state is LoadingState?
         const  Loading():
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.verticalSpace,
                //////////add Carousel /////
                CarouselWidget(
                  items: List<Widget>.generate(
                    cubit.homeModel?.banners.length ?? 0,
                        (index) =>
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: ImageWidget(
                            imageUrl: cubit.homeModel?.banners[index].image ?? "",
                            width: 396.w,
                            height: 180.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                  ),
                ),
                16.verticalSpace,
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 16.w),
                   child: TextWidget(
                     title: "Products",
                     titleColor: AppColors.black,
                     titleSize: 19.sp,
                     titleFontWeight: FontWeight.w600,
                   ),
                 ),
                16.verticalSpace,
                ListView.builder(
                  physics:const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.homeModel?.homeProducts.length??0,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        navigateTo(ProductDetailsScreen(cubit.homeModel!.homeProducts[index].id?.toInt()??0));
                      },
                      child: CustomProductItemDetails(
                          productDetails:cubit.homeModel!.homeProducts[index],
                      ),
                    );
                  },
                )

              ],
            ),
          ),
        );
      },
    );
  }
}
