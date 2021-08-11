// @dart=2.9

import 'package:flutter/material.dart';
import 'package:weza_shop/models/change_favorites_model.dart';
abstract class ShopStates {}

class ShopInitialState extends ShopStates{}
class ChangeBottomNav extends ShopStates{}

class ShopLoadingHome extends ShopStates{}
class ShopSuccessHome extends ShopStates{}
class ShopErrorHome extends ShopStates{

  final error;

  ShopErrorHome(this.error);
}
class ShopLoadingCategory extends ShopStates{}
class ShopSuccessCategory  extends ShopStates{}
class ShopErrorCategory  extends ShopStates{

  final error;

  ShopErrorCategory (this.error);
}


class ShopSuccessFavorites  extends ShopStates{final ChangeFavoritesModel model ;

ShopSuccessFavorites(this.model);}
class ShopErrorFavorites  extends ShopStates{

  final error;

  ShopErrorFavorites  (this.error);
}


class Toggled  extends ShopStates{



}


class ShopSuccessGetFavorites  extends ShopStates{}
class ShopErrorGetFavorites  extends ShopStates{

  final error;

  ShopErrorGetFavorites  (this.error);
}
class ShopLoadingFavorites extends ShopStates{}


class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{}
class ShopErrorUserDataState extends ShopStates{

  final error;

  ShopErrorUserDataState(this.error);
}


class ShopLoadingUpdateUsrState extends ShopStates{}
class ShopSuccessUpdateUsrState extends ShopStates{}
class ShopErrorUpdateUsrState extends ShopStates{

  final error;

  ShopErrorUpdateUsrState(this.error);
}
