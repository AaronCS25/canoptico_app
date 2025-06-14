import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/shared/presentation/blocs/blocs.dart';

void main() {
  runApp(BlocProvider(create: (_) => ThemeCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Material App',
      theme: context.watch<ThemeCubit>().state.themeData,
    );
  }
}
