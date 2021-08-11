
// @dart=2.9
import 'package:weza_shop/models/login_model.dart';

abstract class ShopLoginStates {}

 class ShopLoginInitialState extends ShopLoginStates{}
 class ShopLoginLoadingState extends ShopLoginStates{}
 class ShopLoginSuccessState extends ShopLoginStates{

  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
 class ShopLoginErrorState extends ShopLoginStates{

 final String error ;

 ShopLoginErrorState(this.error);
}

 class ChangeLoginPasswordMode extends ShopLoginStates{}
