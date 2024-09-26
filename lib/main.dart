import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:guardian/controller/auth_provider.dart';
import 'package:guardian/data/service/database_service.dart';
import 'package:guardian/services/encryption_service.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/home_screen.dart';
import 'package:guardian/view/screens/landing_screen.dart';
import 'package:guardian/view/screens/new_password_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthProvider authProvider = AuthProvider();
  //await authProvider.AuthenticateUser();
  final encryptionService = EncryptionService();
  await encryptionService.init();
  final databaseService = DatabaseService();
  await databaseService.db;
  runApp(MyApp(
    authProvider: authProvider,
    databaseService: databaseService,
  ));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;
  final DatabaseService databaseService;

  const MyApp({
    required this.authProvider,
    Key? key,
    required this.databaseService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final GoRouter router = GoRouter(
    //   initialLocation: "/",
    //   restorationScopeId: 'router', // Add this line to restore state
    //   routes: [
    //     GoRoute(
    //       path: "/",
    //       builder: (context, state) {
    //         switch (authProvider.authState) {
    //           case authStatus.authenticated:
    //             return const NewPasswordScreen();
    //           default:
    //             return const NewPasswordScreen();
    //         }
    //       },
    //     ),
    //     GoRoute(
    //       path: "/landing",
    //       builder: (context, state) => const LandingScreen(),
    //     ),
    //     GoRoute(
    //       path: "/add-password",
    //       builder: (context, state) => const NewPasswordScreen(),
    //     ),
    //   ],
    // );

    return ChangeNotifierProvider.value(
      value: authProvider,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        home: authProvider.authState == authStatus.authenticated
            ? HomeScreen(
                databaseService: databaseService,
              )
            : LandingScreen(
                databaseService: databaseService,
              ),
        title: 'Guardian',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
          useMaterial3: false,
          fontFamily: "PT Sans",
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
