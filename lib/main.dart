import 'package:animation/pages/animated_container.dart';
import 'package:animation/pages/animated_list.dart';
import 'package:animation/pages/radial_hero.dart';
import 'package:animation/pages/shaking_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        appBarTheme:  AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[50],
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 20)
      )
      ),
      home: const HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    List<String> topics = ["Эффект тряски","Увеличение","Стикеры и анимация списка","Увеличение картинки в карточку"];
    List<Widget> screens = const [ShakingAnimationDemo(), AnimatedContainerDemo(),AnimatedListDemo(), RadialExpansionDemo()];
    return Scaffold(
        appBar: AppBar(title: const Text("Тестовое задание"), centerTitle: true,),
        body: SafeArea(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topics.length,
            itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => screens[index]));
                },
                child: ListTile(
                   title: Text("${index+1}) ${topics[index]}"),
                ),
              );
            }),
        ),
      );
  }
}