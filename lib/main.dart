import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_mobdev/ui/cubit/list_user_cubit.dart';
import 'package:suitmedia_mobdev/ui/screen/Screen1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListUserCubit>(
          create: (context) => ListUserCubit(),
        ),
      ],
      child: const MaterialApp(
        home: Screen1(title: 'First Screen'),
      ),
    );
  }
}