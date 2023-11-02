import 'package:flutter/material.dart';
import 'package:guardian/controller/auth_provider.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/home_screen.dart';
import 'package:guardian/view/screens/landing_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthProvider authProvider = AuthProvider();
  await authProvider.AuthenticateUser();

  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MyApp({required this.authProvider, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: authProvider, // Use the existing instance of AuthProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Guardian',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          useMaterial3: false,
          fontFamily: "PT Sans",
        ),
        home: Builder(builder: (context) {
          switch (authProvider.authState) {
            case authStatus.authenticated:
              print(authProvider.authState);
              return HomeScreen();

            default:
              return HomeScreen();
          }
        }),
      ),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await AuthProvider()
//       .AuthenticateUser()
//       .then((value) => print(value));

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AuthProvider authProvider = AuthProvider();
//     return ChangeNotifierProvider(
//       create: (context) => AuthProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Guardian',
//         theme: ThemeData(
//           scaffoldBackgroundColor: scaffoldBackgroundColor,
//           useMaterial3: false,
//           fontFamily: "PT Sans",
//         ),
//         home: Builder(builder: (context) {
//           switch (authProvider.authState) {
//             case authStatus.authenticated:
//               print(authProvider.authState);
//               return HomeScreen();

//             default:
//               return LandingScreen();
//           }
//         }),
//       ),
//     );
//   }
// }
