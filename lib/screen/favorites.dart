// @dart=2.9


import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_shop/cubit/shop_cubit.dart';
import 'package:weza_shop/cubit/shop_states.dart';
import 'package:weza_shop/models/favorites_model.dart';


class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return ConditionalBuilder(
         condition:state is!ShopLoadingFavorites ,
            builder: (context)=>ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavorites(ShopCubit.get(context).favoritesModel.data.data[index],context),
                separatorBuilder: (context, index) => Divider(),
                itemCount: ShopCubit.get(context).favoritesModel.data.data.length    ),
            fallback: (context)=> Center(
              child: CircularProgressIndicator(),
            ),

          );
        }
    );
  }
}


Widget buildFavorites(FavoritesData model,context )=> Padding(
  padding: EdgeInsets.all(20 ),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          child: Stack(
              alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage(
                  model.product.image),
              width: 120,
              height: 120,

            ),
            if ( model.product.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.red,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              )
          ]),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.3),
              ),
              Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    '${ model.product.price.toString()}',
                    maxLines: 2,
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.product.discount != 0)
                    Text(
                      '${model.product.oldPrice.toString()}',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: ShopCubit.get(context).favorites[model.product.id]?  Colors.blue :Colors.grey,
                    child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                           ShopCubit.get(context).changeFavorites(model.product.id);
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          size: 12,color: Colors.white,
                        )),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);

