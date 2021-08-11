// @dart=2.9

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_shop/cubit/register_states.dart';

import 'package:weza_shop/models/login_model.dart';
import 'package:weza_shop/network/dio_helper.dart';
import 'package:weza_shop/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  ShopLoginModel loginModel;
  static ShopRegisterCubit get(context) => BlocProvider.of(context);



  void userRegister({@required String email, @required String password,@required String name, @required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone':phone,
        }).then((value) {
      loginModel= ShopLoginModel.fromJson(value.data);


      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error));
    });
  }


  Widget suffixIcon = Icon(Icons.remove_red_eye_outlined);
  bool isPasswordShown=false;
  void changeSuffixIcon()
  {
    isPasswordShown=! isPasswordShown;
    suffixIcon =isPasswordShown ?Icon(Icons.visibility_off) :Icon(Icons.remove_red_eye_outlined);
    emit(ChangeRegisterPasswordMode());
  }
}
