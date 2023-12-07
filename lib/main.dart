import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guardian/controller/auth_provider.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/home_screen.dart';
import 'package:guardian/view/screens/landing_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthProvider authProvider = AuthProvider();
  //await authProvider.AuthenticateUser();

  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  MyApp({required this.authProvider, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) {
            switch (authProvider.authState) {
              case authStatus.authenticated:
                return const HomeScreen();
              default:
                return const HomeScreen();
            }
          },
        ),
        GoRoute(
          path: "/landing",
          builder: (context, state) => const LandingScreen(),
        ),
      ],
    );
    return ChangeNotifierProvider.value(
      value: authProvider, // Use the existing instance of AuthProvider
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        title: 'Guardian',
        theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            useMaterial3: false,
            fontFamily: "PT Sans",
            appBarTheme: AppBarTheme().copyWith(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )),
      ),
    );
  }
}
