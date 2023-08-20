// import 'package:eccommerce_app/app/widgets/button_widget.dart';
// import 'package:eccommerce_app/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
// import 'package:eccommerce_app/features/categories_feature/presentation/presentation_logic_holder/categories_cubit.dart';
// import 'package:eccommerce_app/features/home_feature/presentation/presentation_logic_holder/home_cubit.dart';
// import 'package:eccommerce_app/features/home_feature/presentation/presentation_logic_holder/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         var cubit = HomeCubit.get();
//         return Scaffold(
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                  ButtonWidget(
//                    onPressed: () {
//                      cubit.getHomeData();
//                      //print(getIt<CacheService>().getUserData()?.name??"ENG MOHAMED KHALID");
//                    },
//                    text: "LogOut",
//                  )
//              ],
//           ),
//         );
//       },
//     );
//   }
// }
