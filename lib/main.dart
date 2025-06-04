import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:labapp/presentation/pages/add_product_page.dart';
import 'package:labapp/presentation/pages/alerts_page.dart';
import 'package:labapp/presentation/pages/history_page.dart';
import 'package:labapp/presentation/pages/home_page.dart';
import 'package:labapp/presentation/pages/register_usage_page.dart';
import 'package:labapp/presentation/pages/login_page.dart'; 
import 'package:labapp/presentation/pages/register_page.dart'; 

import 'data/datasources/auth_remote_datasource.dart'; 
import 'data/datasources/product_remote_datasource.dart';
import 'data/datasources/usage_remote_datasource.dart';
import 'data/datasources/alert_remote_datasource.dart';
import 'data/repositories_impl/product_repository_impl.dart';
import 'data/repositories_impl/usage_repository_impl.dart';
import 'data/repositories_impl/alert_repository_impl.dart';
import 'data/repositories_impl/auth_repository_impl.dart'; 

import 'domain/usecases/get_products.dart';
import 'domain/usecases/add_product.dart';     
import 'domain/usecases/delete_product.dart';
import 'domain/usecases/add_usage.dart';
import 'domain/usecases/get_usages.dart';
import 'domain/usecases/get_alerts.dart';
import 'domain/usecases/login.dart'; 
import 'domain/usecases/register_user.dart'; 

import 'presentation/blocs/product/product_bloc.dart';
import 'presentation/blocs/usage/usage_bloc.dart';
import 'presentation/blocs/alert/alert_bloc.dart';
import 'presentation/blocs/auth/auth_bloc.dart'; 

import 'presentation/blocs/product/product_event.dart';
import 'presentation/blocs/usage/usage_event.dart';
import 'presentation/blocs/alert/alert_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LabApp());
}

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = ProductBloc(
      getProducts: GetProducts(ProductRepositoryImpl(ProductRemoteDataSource())),
      addProduct: AddProduct(ProductRepositoryImpl(ProductRemoteDataSource())),
      deleteProduct: DeleteProduct(ProductRepositoryImpl(ProductRemoteDataSource())),
    );

    final usageBloc = UsageBloc(
      AddUsage(UsageRepositoryImpl(UsageRemoteDataSource())),
      UsageRepositoryImpl(UsageRemoteDataSource()),
    );

    final alertBloc = AlertBloc(
      GetAlerts(AlertRepositoryImpl(AlertRemoteDataSource())),
    );

    final authRepository = AuthRepositoryImpl(AuthRemoteDataSource());

    final authBloc = AuthBloc(
      loginUC: Login(authRepository),
      registerUC: RegisterUser(authRepository),
    );

    final GoRouter router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/home', 
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/register-usage',
          builder: (context, state) => const RegisterUsagePage(),
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryPage(),
        ),
        GoRoute(
          path: '/alerts',
          builder: (context, state) => const AlertsPage(),
        ),
        GoRoute(
          path: '/add-product',
          builder: (context, state) => const AddProductPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
      ],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: productBloc..add(LoadProductsEvent())),
        BlocProvider.value(value: usageBloc..add(LoadUsagesEvent())),
        BlocProvider.value(value: alertBloc..add(LoadAlertsEvent())),
        BlocProvider.value(value: authBloc),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'LabApp',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        routerConfig: router,
      ),
    );
  }
}