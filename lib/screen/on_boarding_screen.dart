// @dart=2.9

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weza_shop/screen/login_screen.dart';
import 'package:weza_shop/shared/components.dart';
import 'package:weza_shop/shared/pref.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(this.image, this.title, this.body);
}

class ONBoardingScreen extends StatefulWidget {
  @override
  _ONBoardingScreenState createState() => _ONBoardingScreenState();
}

class _ONBoardingScreenState extends State<ONBoardingScreen> {
  void onSubmit(context) {
    Pref.saveData(key: "OnBoarding", value: true).then((value) {
      if(value){
        navigateAndFinish(context , ShopLogin());
      }
    });

  }

  List<BoardingModel> boarding = [
    BoardingModel(
        'assets/images/shop1.png', 'Welcome to Weza Shop', 'We Have Many Choices For You Go And Select What You Want'),
    BoardingModel(
        'assets/images/shop2.png', 'Browse App And Order Now', 'We Provide The best Product to our customers '),
    BoardingModel(
        'assets/images/on.png', 'You Can Order From Any Where', 'Don\'t Forget To Check our Discounts'),
  ];
  bool isLast = false;

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              Builder(
                builder: (context)=>
               TextButton(
                    onPressed: (){
                      onSubmit(context);} ,
                    child: Text('skip',style: TextStyle(color: Colors.blue),)),
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Expanded(
                    child: PageView.builder(
                  onPageChanged: (int index) {
                    setState(() {
                      if (index == boarding.length - 1) {
                        isLast = true;
                      } else
                        setState(() {
                          isLast = false;
                        });
                    });
                  },
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardItem(boarding[index]),
                  itemCount: boarding.length,
                )),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: boardController,
                      count: boarding.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5,
                      ),
                    ),
                    Spacer(),
                    Builder(
                      builder: (context) => FloatingActionButton(
                        onPressed: () {
                          if (isLast == true) {
                            onSubmit(context);
                          } else {
                            boardController.nextPage(
                                duration: Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        },
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
    );
  }

  Widget buildBoardItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          )
        ],
      );
}
