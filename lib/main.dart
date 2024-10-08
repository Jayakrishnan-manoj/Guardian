import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:guardian/controller/auth_provider.dart';
import 'package:guardian/controller/category_provider.dart';
import 'package:guardian/data/service/database_service.dart';
import 'package:guardian/services/encryption_service.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/home_screen.dart';
import 'package:guardian/view/screens/landing_screen.dart';
import 'package:guardian/view/screens/new_password_screen.dart';
import 'package:guardian/view/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/repositories/password_repository.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthProvider authProvider = AuthProvider();
  //await authProvider.AuthenticateUser();
  final encryptionService = EncryptionService();
  await encryptionService.init();
  final databaseService = DatabaseService();
  await databaseService.db;
  final categoryProvider = CategoryProvider(databaseService);
  final passwordRepository =
      PasswordRepository(databaseService, categoryProvider);
  runApp(MyApp(
    authProvider: authProvider,
    passwordRepository: passwordRepository,
    categoryProvider: categoryProvider,
  ));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;
  final PasswordRepository passwordRepository;
  final CategoryProvider categoryProvider;

  const MyApp({
    required this.authProvider,
    Key? key,
    required this.categoryProvider,
    required this.passwordRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
        ChangeNotifierProvider<CategoryProvider>.value(value: categoryProvider),
        Provider<PasswordRepository>.value(value: passwordRepository),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        home: authProvider.authState == authStatus.authenticated
            ? HomeScreen()
            : LandingScreen(),
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

    // return ChangeNotifierProvider.value(
    //   value: authProvider,
    //   child: MaterialApp(
    //     navigatorKey: navigatorKey,
    //     builder: FToastBuilder(),
    //     debugShowCheckedModeBanner: false,
    //     home: authProvider.authState == authStatus.authenticated
    //         ? HomeScreen(
    //             databaseService: databaseService,
    //           )
    //         : LandingScreen(
    //             databaseService: databaseService,
    //           ),
    //     title: 'Guardian',
    //     theme: ThemeData(
    //       scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    //       useMaterial3: false,
    //       fontFamily: "PT Sans",
    //       appBarTheme: const AppBarTheme().copyWith(
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //       ),
    //     ),
    //   ),
    // );
  }
}
