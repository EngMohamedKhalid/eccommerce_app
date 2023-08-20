import 'package:easy_localization/easy_localization.dart';
import 'package:eccommerce_app/features/auth_feature/presentation/screens/auth_screen.dart';
import 'package:eccommerce_app/features/cart_feature/presentation/presentation_logic_holder/cart_cubit.dart';
import 'package:eccommerce_app/features/categories_feature/presentation/presentation_logic_holder/categories_cubit.dart';
import 'package:eccommerce_app/features/home_feature/presentation/presentation_logic_holder/home_cubit.dart';
import 'package:eccommerce_app/features/onboarding_feature/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'app/services/cache_service.dart';
import 'app/themes/get_theme.dart';
import 'app/utils/bloc_observer.dart';
import 'app/utils/get_it_injection.dart';
import 'app/utils/language_manager.dart';
import 'app/utils/navigation_helper.dart';
import 'app/widgets/carousel_widget/carousel_cubit/carousel_cubit.dart';
import 'features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await init();
  late Widget widget ;
  // if(CacheService().getOnBoarding()!=null){
  //   if(getIt<CacheService>().getUserData() != null ){
  //     if(getIt<CacheService>().getUserData()?.type=="company"){
  //       widget = const BNBScreen();
  //     }else {
  //       const UserCategoriesScreen();
  //     }
  //   }else{
  //     widget = const LoginScreen();
  //   }
  // }else{
  //   widget = const OnBoardingScreen();
  // }
  runApp(  MultiBlocProvider(
    providers: [
      BlocProvider<AuthCubit>(
        create: (BuildContext context) => AuthCubit(),
      ),
      BlocProvider<CategoriesCubit>(
        create: (BuildContext context) => CategoriesCubit(),
      ),
      BlocProvider<HomeCubit>(
        create: (BuildContext context) => HomeCubit(),
      ),
      BlocProvider<CarouselCubit>(
        create: (BuildContext context) => CarouselCubit(),
      ),
      BlocProvider<CartCubit>(
        create: (BuildContext context) => CartCubit(),
      ),
    ],
    child:  MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        english_local,
        arabic_local,
      ],
      path: assets_path_localisations,
      fallbackLocale: english_local,
      saveLocale: true,
      startLocale:english_local ,
      //
      //* OverlaySupport
      //
      child: OverlaySupport.global(
        //
        //* ScreenUtilInit
        //
        child: ScreenUtilInit(
          designSize: const Size(428, 926),
          minTextAdapt: true,
          splitScreenMode: true,
          //
          //* MaterialApp
          //
          builder: (context, child) => MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              // locale: CookieManagerService.getLocale,
              locale: context.locale,
              title: 'ECM',
              theme: waradlyTheme(),
              debugShowCheckedModeBanner: false,
              navigatorKey: getIt<NavHelper>().navigatorKey,
              //
              //* EasyLoading
              //
              builder: EasyLoading.init(
                builder: (context, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget!,
                  );
                },
              ),
              home: SplashScreen()
            // getIt<CacheService>().getUserToken() == null
            //     ?
            // const LoginScreen()
            //     :
            // getIt<CacheService>().getUserData()?.type=="company"
            //   ?
            // const BNBScreen()
            //     :
            // const UserCategoriesScreen(),
          ),
        ),
      ),
    );
  }
}
