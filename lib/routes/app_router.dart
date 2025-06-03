import 'package:go_router/go_router.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/register_usage_page.dart';
import '../presentation/pages/history_page.dart';
import '../presentation/pages/alerts_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/add_product_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/add-product', builder: (context, state) => const AddProductPage()),
    GoRoute(path: '/register-usage', builder: (context, state) => const RegisterUsagePage()),
    GoRoute(path: '/history', builder: (context, state) => const HistoryPage()),
    GoRoute(path: '/alerts', builder: (context, state) => const AlertsPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
  ],
);