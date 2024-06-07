// import 'package:bloc_project/features/auth/presentation/screens/login_screen.dart';
// import 'package:bloc_project/features/auth/presentation/screens/signup_screen.dart';
// import 'package:bloc_project/features/auth/presentation/screens/welcome_screen.dart';
// import 'package:flutter/material.dart';

// class MyHomePage extends StatelessWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           if (MediaQuery.of(context).size.width > 600)
//             Expanded(
//               flex: 2,
//               child: Image.asset(
//                 'assets/book-doctor-appointment.jpg',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           Expanded(
//             flex: 3,
//             child: Navigator(
//               initialRoute: MyWelcomePage.routeName,
//               onGenerateRoute: (settings) {
//                 WidgetBuilder builder;
//                 switch (settings.name) {
//                   case LoginScreen.routeName:
//                     builder = (BuildContext context) => const LoginScreen();
//                     break;
//                   case SignupScreen.routeName:
//                     builder = (BuildContext context) => const SignupScreen();
//                     break;
//                   default:
//                     builder = (BuildContext context) => const MyWelcomePage();
//                     break;
//                 }
//                 return MaterialPageRoute(builder: builder);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
