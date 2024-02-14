import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedListDemo extends StatefulWidget {
  const AnimatedListDemo({super.key});

  @override
  State<AnimatedListDemo> createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  final List<(int, String)> images = [
    (1, "assets/images/one.jpg"),
    (2, "assets/images/two.jpg"),
    (3, "assets/images/three.jpg"),
    (4, "assets/images/four.jpg")
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Стикеры и анимация списка",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: Key(images[index].$2),
                  onDismissed: (direction) => setState(() {
                        images.removeAt(index);
                      }),
                  confirmDismiss: (direction) async =>
                      await _showConfirmationDialog(index),
                  dismissThresholds:const {DismissDirection.endToStart: 0.8},
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 5),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child:
                        const Icon(Icons.delete_outline, color: Colors.white),
                  ),
                  child: listCard(image: images[index]));
            },
          ),
        ),
      ),
    );
  }

  _showConfirmationDialog(index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Удалить элемент?'),
        content: const Text("Вы уверены?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Отменить",
                style: TextStyle(color: Colors.purple[900], fontSize: 15)),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Удалить",
                style: TextStyle(color: Colors.red, fontSize: 15)),
          ),
        ],
      ),
    );
  }
}

Widget listCard({required (int, String) image}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border

              child: Image.asset(image.$2, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            left: 10,
            top: 15,
            child: Text("Место ${image.$1}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          Positioned.fill(
            bottom: 0,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(235, 27, 114, 164),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        description(
                            icon: Icons.downloading_outlined, text: "2 MB"),
                        description(
                            icon: Icons.calendar_month, text: "15.05.2025"),
                        description(
                            icon: Icons.watch_later_outlined, text: "10 ч.")
                      ]),
                )),
          )
        ],
      ),
    );

Row description({required IconData icon, required String text}) => Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
