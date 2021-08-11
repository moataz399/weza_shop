// @dart=2.9

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weza_shop/cubit/login-cubit.dart';
import 'package:weza_shop/cubit/login_states.dart';
import 'package:weza_shop/layout/shop_layout.dart';
import 'package:weza_shop/screen/register_screen.dart';
import 'package:weza_shop/shared/components.dart';
import 'package:weza_shop/shared/constant.dart';
import 'package:weza_shop/shared/pref.dart';

class ShopLogin extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (BuildContext context, state) {
        if (state is ShopLoginSuccessState) {
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
                      Text('Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black)),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        autofocus: false,
                        validator: (value) =>
                            value.isEmpty ? 'please enter your email' : null,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText:
                            ShopLoginCubit.get(context).isPasswordShown,
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: ShopLoginCubit.get(context).suffixIcon,
                            onPressed: () {
                              ShopLoginCubit.get(context).changeSuffixIcon();
                            },
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        autofocus: false,
                        validator: (value) =>
                            value.isEmpty ? 'Password is too short ' : null,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                            text: 'LOGIN',
                            function: () {
                              if (_formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            }),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\' have an account ?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          FlatButton(
                              onPressed: () {

                                navigateAndFinish(context,RegisterScreen());
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
