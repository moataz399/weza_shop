// @dart=2.9
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weza_shop/cubit/app_cubit.dart';
import 'package:weza_shop/cubit/app_states.dart';
import 'package:weza_shop/cubit/shop_cubit.dart';
import 'package:weza_shop/layout/shop_layout.dart';
import 'package:weza_shop/screen/login_screen.dart';
import 'package:weza_shop/screen/on_boarding_screen.dart';
import 'package:weza_shop/shared/constant.dart';
import 'package:weza_shop/shared/pref.dart';

import 'cubit/login-cubit.dart';
import 'network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await Pref.init();
  bool onBoarding = Pref.getData(key: 'OnBoarding');
  token = Pref.getData(key: 'token');
  print(onBoarding);
 Widget startWidget;


if(onBoarding != null){
  if(token != null) {
    startWidget =ShopLayout();

  }else {
    startWidget =ShopLogin();
  }

}else{
  startWidget =ONBoardingScreen();
}

  runApp(MyApp(
      onBoarding: onBoarding,
      startWidget:startWidget,
  )
  );
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
 final  Widget startWidget;
  MyApp({this.onBoarding,this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopLoginCubit(),
    ),
         BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoryData()..getFavorites()..getUserData(),
          ),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            darkTheme: ThemeData(
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.black26,
                  elevation: 20,
                  type: BottomNavigationBarType.fixed),
              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  backgroundColor: Colors.black26,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.grey,
                    statusBarBrightness: Brightness.light,
                  ),
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  iconTheme: IconThemeData(color: Colors.white)),
              scaffoldBackgroundColor: Colors.black26,
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
            theme: ThemeData(
                appBarTheme: AppBarTheme(
                    elevation: 0.0,
                    backwardsCompatibility: false,
                    backgroundColor: Colors.white,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarBrightness: Brightness.dark,
                    ),
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    iconTheme: IconThemeData(color: Colors.black)),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  //   backgroundColor: Colors.black26,
                    elevation: 20,
                    type: BottomNavigationBarType.fixed)),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body:startWidget,
            ),
          );
        },
      ),
    );
  }
}
