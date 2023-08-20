import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/loading.dart';
import '../../../cart_feature/presentation/presentation_logic_holder/cart_cubit.dart';

class CustomAddToCard extends StatefulWidget {
  const CustomAddToCard({super.key, this.size, required this.id});
  final double? size;
  final int id;

  @override
  State<CustomAddToCard> createState() => _CustomAddToCardState();
}

class _CustomAddToCardState extends State<CustomAddToCard> {
  bool isLoading =false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size ?? 40.w,
      height: widget.size ?? 40.w,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.gery455.withOpacity(.05)
      ),
      child: InkWell(
        onTap: () async{
          setState(() {
            isLoading =true;
          });
         await CartCubit.get().addOrRemoveCart(id: widget.id);
          setState(() {
            isLoading =false;
          });
        },
        child: isLoading?
        const Loading()
            :
        const ImageWidget(
          imageUrl: AppAssets.card,
          color: AppColors.gery455,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
