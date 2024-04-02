import 'dart:math';
import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {

  //for image
  var activeDiceImage = 'assets/images/dice-1.png';

  //for wishMessage
  String wishMessage ='';

  //for score
  int scoreNumber= 0;

  void rollDice() {
    setState(() {
      Random random = Random();
      int imageRandom = random.nextInt(7);
      scoreNumber = scoreNumber+imageRandom; //calculate the points

      activeDiceImage = 'assets/images/dice-$imageRandom.png';
      if(imageRandom==0){
        //we will replace 0 with 1, because we don't have  any file with 0 name
        activeDiceImage = 'assets/images/dice-1.png';
      }
      if (imageRandom == 6) {
        //we will show an congrats message if the value is highest
        wishMessage='hurry you got the highest value';

        //show the congrats message into bottomSheet
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return BottomSheetWidget(wishMessage: wishMessage,);
          },
        );
      }else{
        //if the number is not highest then clear the message
        wishMessage='';
      }
    });
  }


  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:Colors.white ,
        appBar: AppBar(
          title: Text('Dice Roller',style: TextStyle(
            fontWeight: FontWeight.w600
          ),),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,

        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Your Score:'),
                  Text('$scoreNumber',style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.red
                  ),),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black12,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      activeDiceImage,
                      width: 200,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: MyButton(
                        onTap: rollDice,
                        buttonText: 'Roll Now',
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//BottomSheet
class BottomSheetWidget extends StatelessWidget {
  final String wishMessage;

  const BottomSheetWidget({super.key, required this.wishMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 60,
              height: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Image.asset('assets/images/congrats.png', height: 100),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                wishMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: MyButton(
                onTap: () {
                  //close the bottomSheet
                  Navigator.pop(context);
                },
                buttonText: 'Let\'s get it again',

              )
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

//CustomWidgetButton
class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;

  const MyButton({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
            child: Text(buttonText,style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),)),
      ),
    );
  }
}
