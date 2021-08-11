// @dart=2.9


import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_shop/cubit/search_states.dart';
import 'package:weza_shop/models/sarch-model.dart';
import 'package:weza_shop/network/dio_helper.dart';
import 'package:weza_shop/network/end_points.dart';
import 'package:weza_shop/shared/constant.dart';

class SearchCubit extends Cubit<ShopSearchStates>{
  SearchCubit() : super(SearchInitialState());

static SearchCubit get(context) =>BlocProvider.of(context);

SearchModel model;

  void search(String text){

    emit(ShopSearchLoadingState());
    DioHelper.postData(url: SEARCH, token:'token', data: {
      'text':text,


    }).then((value) {
   model=SearchModel.fromJson(value.data);


    emit(ShopSearchSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(ShopSearchErrorState(error));

    });
  }

}