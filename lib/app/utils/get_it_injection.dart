import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:eccommerce_app/features/auth_feature/domain/usecases/change_password_use_case.dart';
import 'package:eccommerce_app/features/auth_feature/domain/usecases/get_profile_use_case.dart';
import 'package:eccommerce_app/features/auth_feature/domain/usecases/log_out_use_case.dart';
import 'package:eccommerce_app/features/auth_feature/domain/usecases/login_use_case.dart';
import 'package:eccommerce_app/features/auth_feature/domain/usecases/register_use_case.dart';
import 'package:eccommerce_app/features/auth_feature/domain/usecases/update_profile_use_case.dart';
import 'package:eccommerce_app/features/cart_feature/domain/use_cases/add_or_delete_cart_use_case.dart';
import 'package:eccommerce_app/features/cart_feature/domain/use_cases/get_all_cart_use_case.dart';
import 'package:eccommerce_app/features/categories_feature/data/repo_impl/categories_repo_impl.dart';
import 'package:eccommerce_app/features/categories_feature/domain/repo/categories_repo.dart';
import 'package:eccommerce_app/features/categories_feature/domain/use_cases/get_category_products.dart';
import 'package:eccommerce_app/features/categories_feature/domain/use_cases/get_product_details_use_case.dart';
import 'package:eccommerce_app/features/home_feature/data/data_source/home_remote_data_source.dart';
import 'package:eccommerce_app/features/home_feature/data/repo_impl/home_repo_impl.dart';
import 'package:eccommerce_app/features/home_feature/domain/use_cases/get_home_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth_feature/data/data_source/auth_remote_data_source.dart';
import '../../features/auth_feature/data/repo_impl/auth_repo_impl.dart';
import '../../features/auth_feature/domain/repo/auth_repo.dart';
import '../../features/cart_feature/data/data_source/cart_remote_data_source.dart';
import '../../features/cart_feature/data/repo_impl/cart_repo_impl.dart';
import '../../features/cart_feature/domain/repo/cart_repo.dart';
import '../../features/categories_feature/data/data_sources/categories_remote_data_source.dart';
import '../../features/categories_feature/domain/use_cases/get_all_categories_use_case.dart';
import '../../features/home_feature/domain/repo/home_repo.dart';
import '../network/network_info.dart';
import '../network/network_manager.dart';
import '../services/cache_service.dart';
import 'navigation_helper.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // data sources
   getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImp(networkManager: getIt()),);
   getIt.registerLazySingleton<CategoriesRemoteDataSource>(() => CategoriesRemoteDataSourceImpl(networkManager: getIt()),);
   getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<SearchRemoteDataSource>(() => SearchRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<AccountRemoteDataSource>(() => AccountRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(networkManager: getIt()),);
  getIt.registerLazySingleton<CartRemoteDataSource>(() => CartRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<FavouriteRemoteDataSource>(() => FavouriteRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<OrderRemoteDataSource>(() => OrderRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<AddressesRemoteDataSource>(() => AddressesRemoteDataSourceImpl(networkManager: getIt()),);
  // getIt.registerLazySingleton<NotificationRemoteDataSource>(() => NotificationRemoteDataSourceImpl(networkManager: getIt()),);

  //* Repository
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authRemoteDataSource: getIt(), networkInfo: getIt()),);
  getIt.registerLazySingleton<CategoriesRepo>(() => CategoriesRepoImpl(categoriesRemoteDataSource: getIt(), networkInfo: getIt()),);
   getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(homeRemoteDataSource: getIt(), networkInfo: getIt(),),);
  // getIt.registerLazySingleton<SearchRepo>(() => SearchRepoImpl(searchRemoteDataSource: getIt(), networkInfo: getIt()),);
  // getIt.registerLazySingleton<AccountRepo>(() => AccountRepoImpl(accountRemoteDataSource: getIt(), networkInfo: getIt()),);
  // getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl( networkInfo: getIt(), homeRemoteDataSource: getIt()),);
  getIt.registerLazySingleton<CartRepo>(() => CartRepoImpl( networkInfo: getIt(), cartRemoteDataSource: getIt()),);
  // getIt.registerLazySingleton<FavouriteRepo>(() => FavouriteRepoImpl( networkInfo: getIt(), favouriteRemoteDataSource: getIt()),);
  // getIt.registerLazySingleton<OrderRepo>(() => OrderRepoImpl( networkInfo: getIt(), orderRemoteDataSource: getIt()),);
  // getIt.registerLazySingleton<AddressesRepo>(() => AddressesRepoImpl( networkInfo: getIt(), addressesRemoteDataSource: getIt()),);
  // getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepoImpl( networkInfo: getIt(), notificationRemoteDataSource: getIt()),);

  //* Use cases
  _authUseCases();
  _accountUseCases();
  _cartUseCases();
  _favouriteUseCases();
  _homeUseCase();
  _categoriesCase();
  _searchUseCase();
  _notificationsUseCases();
  _orderUseCases();
  _addressCases();


  //! ----------- app -----------
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<NetworkManager>(() => NetworkManager());
  getIt.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  // getIt.registerLazySingleton<FirebaseNotificationService>(() => FirebaseNotificationService(),);
  // getIt.registerLazySingleton<FlutterLocalNotificationService>(() => FlutterLocalNotificationService(),);
  getIt.registerSingleton<NavHelper>(NavHelper());
  getIt.registerSingleton<CacheService>(CacheService());
}

void _authUseCases() {
  getIt.registerLazySingleton<LogInUseCase>(() => LogInUseCase(authRepo: getIt()));
  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(authRepo: getIt()));
  getIt.registerLazySingleton<ChangePasswordUseCase>(() => ChangePasswordUseCase(authRepo: getIt()));
  getIt.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(authRepo: getIt()));
  getIt.registerLazySingleton<LogOutUseCase>(() => LogOutUseCase(authRepo: getIt()));
  getIt.registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase(authRepo: getIt()));
}

void _homeUseCase(){
  getIt.registerLazySingleton<GetHomeDataUseCase>(() => GetHomeDataUseCase(repository: getIt()));
}


void _cartUseCases() {
  getIt.registerLazySingleton<AddOrDeleteCartUseCase>(() => AddOrDeleteCartUseCase(cartRepo: getIt()));
   getIt.registerLazySingleton<GetAllCartUseCase>(() => GetAllCartUseCase(cartRepo: getIt()));
  // getIt.registerLazySingleton<UpdateQuantityUseCase>(() => UpdateQuantityUseCase(repository: getIt()));
  // getIt.registerLazySingleton<RemoveItemFromCartUseCase>(() => RemoveItemFromCartUseCase(repository: getIt()));
  // getIt.registerLazySingleton<SaveItemForLaterUseCase>(() => SaveItemForLaterUseCase(repository: getIt()));
  // getIt.registerLazySingleton<CheckoutUseCase>(() => CheckoutUseCase(repository: getIt()));
  // getIt.registerLazySingleton<CheckCouponUseCase>(() => CheckCouponUseCase(repository: getIt()));
  // getIt.registerLazySingleton<PlaceOrderUseCase>(() => PlaceOrderUseCase(repository: getIt()));
}
void _favouriteUseCases() {
  // getIt.registerLazySingleton<AddItemToFavouriteUseCase>(() => AddItemToFavouriteUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetAllFavouriteItemsUseCase>(() => GetAllFavouriteItemsUseCase(repository: getIt()));
  // getIt.registerLazySingleton<RemoveItemFromFavouriteUseCase>(() => RemoveItemFromFavouriteUseCase(repository: getIt()));
  // getIt.registerLazySingleton<SaveItemToCartUseCase>(() => SaveItemToCartUseCase(repository: getIt()));
  // getIt.registerLazySingleton<UpdateFavouriteQuantityUseCase>(() => UpdateFavouriteQuantityUseCase(repository: getIt()));
}

void _accountUseCases() {
  // getIt.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(repository: getIt()));
  // getIt.registerLazySingleton<UpdatePasswordUseCase>(() => UpdatePasswordUseCase(repository: getIt()));
  // getIt.registerLazySingleton<ChangeLanguageUseCase>(() => ChangeLanguageUseCase(repository: getIt()));
  // getIt.registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase(repository: getIt()));
  // getIt.registerLazySingleton<ContactUsUseCase>(() => ContactUsUseCase(repository: getIt()));
}
void _searchUseCase(){
 // getIt.registerLazySingleton<SearchProductsUseCase>(() => SearchProductsUseCase(repository: getIt()));
}
void _categoriesCase(){
  getIt.registerLazySingleton<GetAllCategoriesUseCase>(() => GetAllCategoriesUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetAllCategoryProductsUseCase>(() => GetAllCategoryProductsUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetProductDetailsUseCase>(() => GetProductDetailsUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetAllBestSellingUseCase>(() => GetAllBestSellingUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetAllBestOffersUseCase>(() => GetAllBestOffersUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetAllNewCollectionsUseCase>(() => GetAllNewCollectionsUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetCategoryProductsUseCase>(() => GetCategoryProductsUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetProductDetailsUseCase>(() => GetProductDetailsUseCase(repository: getIt()));
}
void _notificationsUseCases() {
  // getIt.registerLazySingleton<GetNotificationCountUseCase>(() => GetNotificationCountUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetNotificationsUseCase>(() => GetNotificationsUseCase(repository: getIt()));
}

void _orderUseCases() {
  // getIt.registerLazySingleton<ReviewOrderItemUseCase>(() => ReviewOrderItemUseCase(repository: getIt()));
  // getIt.registerLazySingleton<CancelOrderItemUseCase>(() => CancelOrderItemUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetOrderDetailsUseCase>(() => GetOrderDetailsUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetCancelledOrdersUseCase>(() => GetCancelledOrdersUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetDeliveredOrdersUseCase>(() => GetDeliveredOrdersUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetInShippingOrdersUseCase>(() => GetInShippingOrdersUseCase(repository: getIt()));
  // getIt.registerLazySingleton<GetInProgressOrdersUseCase>(() => GetInProgressOrdersUseCase(repository: getIt()));
}

void _addressCases() {
  // getIt.registerLazySingleton<GetAddressesUseCase>(() => GetAddressesUseCase(repository: getIt()));
  // getIt.registerLazySingleton<AddAddressUseCase>(() => AddAddressUseCase(repository: getIt()));
  // getIt.registerLazySingleton<EditAddressUseCase>(() => EditAddressUseCase(repository: getIt()));
  // getIt.registerLazySingleton<DeleteAddressUseCase>(() => DeleteAddressUseCase(repository: getIt()));
}