import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi_0039/data/repositories/auth_repository.dart';
import 'package:restapi_0039/logic/bloc/auth/auth_bloc.dart';
import 'package:restapi_0039/logic/bloc/auth/auth_event.dart';
import 'package:restapi_0039/logic/bloc/auth/auth_state.dart';
import 'package:restapi_0039/logic/debug/bloc_observer.dart';
import 'package:restapi_0039/ui/pages/dashboard_page.dart';
import 'package:restapi_0039/ui/pages/login_page.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          repository: RepositoryProvider.of<AuthRepository>(context),
        )..add(AppStarted()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ternak App',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            fontFamily: 'Roboto', // Ganti jika ada font kustom
          ),
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return const DashboardPage();
              }
              return const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
