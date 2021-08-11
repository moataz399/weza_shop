// @dart=2.9
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_shop/cubit/shop_states.dart';
import 'package:weza_shop/models/category_model.dart';
import 'package:weza_shop/models/change_favorites_model.dart';
import 'package:weza_shop/models/favorites_model.dart';

import 'package:weza_shop/models/home_model.dart';
import 'package:weza_shop/models/login_model.dart';
import 'package:weza_shop/network/dio_helper.dart';
import 'package:weza_shop/network/end_points.dart';
import 'package:weza_shop/screen/categories_screen.dart';
import 'package:weza_shop/screen/favorites.dart';
import 'package:weza_shop/screen/products_screen.dart';
import 'package:weza_shop/screen/settings_screen.dart';
import 'package:weza_shop/shared/constant.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static var banners;
  static var products;
  HomeModel homeModel;
  CategoriesModel categoryModel;

  Map<int, bool> favorites = {};

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;

  List<String> titles = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];

  void changeIndex(int index) {
    currentIndex = index;

    emit(ChangeBottomNav());
  }

  void getHomeData() async {
    emit(ShopLoadingHome());

    DioHelper.getData(url: HOME, token: token).then((value) async {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll(({
          element.id: element.inFavorites,
        }));
      });

      emit(ShopSuccessHome());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHome(error));
    });
  }

  void getCategoryData() async {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) async {
      categoryModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategory());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategory(error));
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(Toggled());

    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(changeFavoritesModel.message);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessFavorites(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      print(changeFavoritesModel.message);
      emit(ShopErrorFavorites(error));
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() async {
    emit(ShopLoadingFavorites());

    DioHelper.getData(url: FAVORITES, token: token).then((value) async {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavorites());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavorites(error));
    });
  }

  ShopLoginModel userModel;

  void getUserData() async {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) async {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error));
    });
  }


  void updateUserData({@required String name,@required String email,@required String phone }) async {
    emit(ShopLoadingUpdateUsrState());

    DioHelper.putData(url: UPDATE_PROFILE, token: token,data: {
      'name':name,
      'email':email,
      'phone':phone,
    }).then((value) async {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUsrState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUsrState(error));
    });
  }
}
