import 'package:flutter/material.dart';
import 'package:learn_bloc_with_b28/lesson%20three/screens/home.dart';

class PostApp extends StatelessWidget {
  const PostApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: Home(),
    );
  }
}
