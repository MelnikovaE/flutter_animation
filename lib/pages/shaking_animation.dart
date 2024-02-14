import 'dart:async';

import 'package:flutter/material.dart';

class ShakingAnimationDemo extends StatefulWidget {
  const ShakingAnimationDemo({super.key});

  @override
  State<ShakingAnimationDemo> createState() => _ShakingAnimationDemoState();
}

class _ShakingAnimationDemoState extends State<ShakingAnimationDemo>
    with SingleTickerProviderStateMixin {
  late String _message;
  late final GlobalKey<FormState> _formKey;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _animation = Tween(begin: 0.0, end: 5.0).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void sendMessage(context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$_message успешно отправлено"),
        backgroundColor: Colors.black87,
      ));
    } else {
      _controller.repeat(reverse: true);
      _animation.addListener(() {
        setState(() {});
      });
      Timer(const Duration(seconds: 1), () {
        setState(() {
          _controller.reset();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(_animation.value, 5.0),
                      child: TextFormField(
                          onSaved: (value) => _message = value!,
                          validator: (value) => value != null && value.isEmpty
                              ? "Поле не должно быть пустым"
                              : null,
                          decoration: formFieldDecoration(
                              label: "Ввод текста", hintText: "Введите текст")),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: styleOvalButton(backgroundColor: Colors.purple[50],foregroundColor: Colors.purple[900]),
                        onPressed: () => sendMessage(context),
                        child: const Text("Отправить"))
                  ])),
        ),
      ),
    );
  } 
}

InputDecoration formFieldDecoration(
        {required String label, required String hintText}) =>
    InputDecoration(
      border: InputBorder.none,
      label: Text(label),
      labelStyle: const TextStyle(color: Colors.black87),
      hintText: hintText,
      enabledBorder: inputBorder(color: Colors.blue),
      focusedBorder: inputBorder(color: Colors.green),
      errorBorder: inputBorder(color: Colors.red),
      focusedErrorBorder: inputBorder(color: Colors.red),
    );

OutlineInputBorder inputBorder({required Color color}) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1.5),
    borderRadius: const BorderRadius.all(Radius.circular(10.0)));

ButtonStyle styleOvalButton(
        {required Color? backgroundColor, required Color? foregroundColor}) =>
    ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor));
