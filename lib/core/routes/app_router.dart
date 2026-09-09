import 'package:feedback_loop/presentation/screens/home_screen.dart';
import 'package:feedback_loop/presentation/widgets/scaffold_nav_bar.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    ShellRoute(
      builder: (context, state, screen) => ScaffoldNavBar(screen: screen),
      routes: [

        GoRoute(
          path: "/",
          builder: (context, state) => const HomeScreen(),
        ),
        
      ]
    )
  ]
);