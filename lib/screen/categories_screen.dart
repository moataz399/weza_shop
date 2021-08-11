// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_shop/cubit/shop_cubit.dart';
import 'package:weza_shop/cubit/shop_states.dart';
import 'package:weza_shop/models/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCategoryItems(ShopCubit.get(context).categoryModel.data.data[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: ShopCubit.get(context).categoryModel.data.data.length);
        });
  }
}

Widget buildCategoryItems(DataModel model) => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              model.image,
            ),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            model.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
