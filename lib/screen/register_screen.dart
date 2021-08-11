// @dart=2.9

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:weza_shop/cubit/register_cubit.dart';
import 'package:weza_shop/cubit/register_states.dart';
import 'package:weza_shop/layout/shop_layout.dart';

import 'package:weza_shop/shared/components.dart';
import 'package:weza_shop/shared/constant.dart';
import 'package:weza_shop/shared/pref.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (BuildContext context, state) {
            if (state is ShopRegisterSuccessState) {
              if (state.loginModel.status ) {
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                Pref.saveData(key: 'token', value: state.loginModel.data.token)
                    .then((value) {
                  print(state.loginModel.data.token);
                  token=state.loginModel.data.token;
                  navigateAndFinish(context, ShopLayout());
                });
              } else {
                Fluttertoast.showToast(
                    msg: state.loginModel.message,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          },
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Register',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.black)),
                          Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Text(
                              'register now to browse our hot offers',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          buildTextForm(controller: nameController,label: 'Name',icon: Icon(Icons.person)),
                          SizedBox(
                            height: 15,
                          ),
                          buildTextForm(controller: emailController,label: "Email Address",icon: Icon(Icons.email)),
                          SizedBox(
                            height: 30,
                          ),
                          buildTextForm(controller: passwordController,label: 'Password',icon: Icon(Icons.remove_red_eye_outlined)),
                          SizedBox(
                            height: 15,
                          ),
                          buildTextForm(controller: phoneController,label: 'Phone',icon: Icon(Icons.phone)),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition:state is! ShopRegisterLoadingState
                             ,
                            builder: (context) => defaultButton(
                                text: 'Register',
                                function: () {
                                  if (_formKey.currentState.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                }),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
