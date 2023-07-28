import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:learn_bloc_with_b28/lesson%20three/app.dart';
import 'package:learn_bloc_with_b28/lesson%20three/blocs/post_observer.dart';
import 'package:learn_bloc_with_b28/lesson%20three/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  Bloc.observer = SimpleBlocObserver();

  runApp(const PostApp());
}