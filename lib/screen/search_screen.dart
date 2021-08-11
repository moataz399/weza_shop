// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_shop/cubit/search_cubit.dart';
import 'package:weza_shop/cubit/search_cubit.dart';

import 'package:weza_shop/cubit/search_states.dart';
import 'package:weza_shop/cubit/shop_cubit.dart';
import 'package:weza_shop/shared/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = new GlobalKey<FormState>();

    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                      children: [
                    buildTextForm(
                        controller: searchController,
                        label: 'search',
                        icon: Icon(Icons.search),
                        onSubmitted: (String text) {
                          SearchCubit.get(context).search(text);
                        }),
                    if(state is ShopSearchLoadingState)
                    LinearProgressIndicator(),
                    if(state is ShopSearchSuccessState)
                    Expanded(child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildProductItems(SearchCubit.get(context).model.data.data[index],context,isOldPrice: false),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: SearchCubit.get(context).model.data.data.length    ),)
                  ]),
                ),
              ));
        },
      ),
    );
  }
}
