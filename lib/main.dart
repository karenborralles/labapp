import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/auth/auth_event.dart';
import 'presentation/blocs/auth/auth_state.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/register_page.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'data/repositories_impl/auth_repository_impl.dart';
import 'domain/usecases/login.dart';
import 'domain/usecases/register_user.dart';

void main() {
  final authBloc = AuthBloc(
    loginUC: Login(AuthRepositoryImpl(AuthRemoteDataSource())),
    registerUC: RegisterUser(AuthRepositoryImpl(AuthRemoteDataSource())),
  );

  runApp(
    BlocProvider.value(
      value: authBloc,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LabApp',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        // '/home': (context) => const HomePage(), // <-- La defines tú después
      },
      home: const LoginPage(),
    );
  }
}