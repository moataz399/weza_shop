// @dart=2.9

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_shop/cubit/login_states.dart';
import 'package:weza_shop/network/dio_helper.dart';
import 'package:weza_shop/network/end_points.dart';
import 'package:weza_shop/models/login_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  ShopLoginModel loginModel;
  static ShopLoginCubit get(context) => BlocProvider.of(context);



  void userLogin({@required String email, @required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel= ShopLoginModel.fromJson(value.data);


      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }


  Widget suffixIcon = Icon(Icons.remove_red_eye_outlined);
  bool isPasswordShown=false;
  void changeSuffixIcon()
  {
    isPasswordShown=! isPasswordShown;
    suffixIcon =isPasswordShown ?Icon(Icons.visibility_off) :Icon(Icons.remove_red_eye_outlined);
    emit(ChangeLoginPasswordMode());
  }
}
