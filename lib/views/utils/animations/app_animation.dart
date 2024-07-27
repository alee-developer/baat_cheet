import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';

class AppAnimationsScreen extends StatefulWidget {
  const AppAnimationsScreen({super.key});

  @override
  State<AppAnimationsScreen> createState() => _AppAnimationsScreenState();
}

class _AppAnimationsScreenState extends State<AppAnimationsScreen> with SingleTickerProviderStateMixin  {

  @override
  Widget build(BuildContext context) {
    var controller = AnimationController(vsync: this,duration: 5.seconds);
    var animation = Tween(
      begin: 100.0,
      end: 500.0
    ).animate(controller.view);

    return Scaffold(
      body: Column(
        children: [
          AnimatedBuilder(animation: controller, builder: (c,w){
            return Container(
              width: animation.value,
              height: animation.value,
              color: Colors.red,
            );
          }),
          ElevatedButton(onPressed: (){
            controller.forward();
            setState(() {

            });
          }, child: const Text("Fade animation"))
        ],
      ),
    );
  }

  AnimationController animationController(){
    return AnimationController(vsync: this,duration: 5.seconds);
  }

  Animation<double> myAnimation(){
    return Tween<double>(
      begin: 100.0,
      end: 500.0
    ).animate(animationController().view);
  }
}
