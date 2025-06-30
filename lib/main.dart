import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/auth/auth.dart';
import 'package:canoptico_app/features/shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.init();
  await Environment.initEnvironment();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter router;
  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = AuthBloc(
      authTokenService: ServiceLocator.get<AuthTokenService>(),
      authRepository: ServiceLocator.get<AuthRepository>(),
    );
    router = createRouter(authBloc);
  }

  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: Builder(
        builder: (context) {
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
