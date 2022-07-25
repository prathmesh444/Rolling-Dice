import 'dart:math';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var dice1 = 1;
  var dice2 = 1;
  var controller;
  var animation;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    animation.dispose();
  }

  void RollDice() {
    setState(() {
      controller.forward();
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          dice1 = Random().nextInt(6) + 1;
          dice2 = Random().nextInt(6) + 1;
          controller.reverse();
        }
      });
    });
  }

  void animate() {
    controller =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInCirc);
    animation.addListener(() {
      setState(() {});
      print(animation.value);
    });


  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dicee",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onDoubleTap: () {
                    RollDice();
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        "assets/images/dice-png-$dice1.png",
                        height: 300.0 - (animation.value * 200),
                      )
                  ),
                )
                ),
                Expanded(
                    child: GestureDetector(
                      onDoubleTap: RollDice,
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image(
                          image: AssetImage("assets/images/dice-png-$dice2.png"),
                          height: 300.0 - (animation.value * 200),
                      )
                      ),
                )
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => RollDice(),
              child: const Text("ROLL DICE",
                  style: TextStyle(fontSize: 16.0, color: Colors.black)
              ),
            )
          ],
        ),
      ),
    );
  }

}
