

import 'package:eccommerce_app/features/cart_feature/presentation/screens/cart_screen.dart';
import 'package:eccommerce_app/features/cart_feature/presentation/widgets/custom_cart_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../categories_feature/presentation/screens/categories_screen.dart';
import '../../../home_feature/presentation/screens/home_screen.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationStats> {
  BottomNavigationCubit() : super(BottomNavigationInitial());
  static BottomNavigationCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens =const  [
     HomeScreen(),
    CategoriesScreen(),
    CartScreen()
    // CartScreen(),
    // ProfileScreen()
  ];
  void changeCurrent(int index)
  {
    currentIndex = index;
    emit(ChangeBottomNavigationIndex());
  }
}
