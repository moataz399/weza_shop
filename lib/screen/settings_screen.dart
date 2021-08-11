// @dart=2.9

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weza_shop/cubit/register_states.dart';
import 'package:weza_shop/cubit/shop_cubit.dart';
import 'package:weza_shop/cubit/shop_states.dart';
import 'package:weza_shop/shared/components.dart';

var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
final _formKey = new GlobalKey<FormState>();

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                  if(state is ShopRegisterLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    buildTextForm(
                        label: 'Name',
                        controller: nameController,
                        icon: Icon(Icons.person)),
                    SizedBox(
                      height: 20,
                    ),
                    buildTextForm(
                        label: 'Email Address',
                        controller: emailController,
                        icon: Icon(Icons.email)),
                    SizedBox(
                      height: 20,
                    ),

                    buildTextForm(
                        label: 'Phone',
                        controller: phoneController,
                        icon: Icon(Icons.phone)),
                    TextButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        child: Text('Update')),
                    signOutButton(context),
                  ],
                ),
              ),
            ),
          ),
          fallback: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
