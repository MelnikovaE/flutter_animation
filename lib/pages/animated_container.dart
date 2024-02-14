import 'package:flutter/material.dart';

class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({super.key});

  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  late bool selected;

  @override
  void initState() {
    selected = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selected = !selected;
              });
            },
            child: Center(
              child: AnimatedContainer(
                width: selected ? mq.width : 130,
                height: selected ? mq.height : 30,
                color: selected ? Colors.red.shade200 : Colors.green,
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 300),
                //curve: Curves.fastOutSlowIn,
                child: selected
                    ? null
                    : const Text("Нажать",
                        style: TextStyle(
                          color: Colors.white,
                        )),
              ),
            ),
          ),
        ));
  }
}
