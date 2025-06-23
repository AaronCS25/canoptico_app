import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/auth/auth.dart';
import 'package:canoptico_app/features/shared/shared.dart';

void main() async {
  await ServiceLocator.init();
  await Environment.initEnvironment();
  runApp(BlocProvider(create: (_) => ThemeCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        dictStorageService: DictStorageServiceImpl(),
        authRepository: ServiceLocator.get<AuthRepositoryImpl>(),
      ),
      child: Builder(
        builder: (context) {
          final router = createRouter(context.read<AuthBloc>());

          return MaterialApp.router(
            routerConfig: router,
            title: 'Material App',
            theme: context.watch<ThemeCubit>().state.themeData,
          );
        },
      ),
    );
  }
}
