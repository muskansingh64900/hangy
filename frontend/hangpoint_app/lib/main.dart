// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'screens/auth/login_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ),
//   );
//   runApp(const HangPointApp());
// }

// class HangPointApp extends StatelessWidget {
//   const HangPointApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'HangPoint',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: const Color(0xFF0A0C10),
//         primaryColor: const Color(0xFFFF6B35),
//         fontFamily: 'Roboto',
//         colorScheme: const ColorScheme.dark(
//           primary: Color(0xFFFF6B35),
//           background: Color(0xFF0A0C10),
//           surface: Color(0xFF131720),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: const Color(0xFF131720),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFF232C3D)),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFF232C3D)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 2),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: Color(0xFFFF4D6D)),
//           ),
//           labelStyle: const TextStyle(color: Color(0xFF7A8AA0)),
//           hintStyle: const TextStyle(color: Color(0xFF7A8AA0)),
//           prefixIconColor: const Color(0xFF7A8AA0),
//           suffixIconColor: const Color(0xFF7A8AA0),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16, vertical: 18),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFFF6B35),
//             foregroundColor: Colors.white,
//             minimumSize: const Size(double.infinity, 56),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14),
//             ),
//             elevation: 0,
//             textStyle: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w800,
//               letterSpacing: 1,
//             ),
//           ),
//         ),
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const DropItApp());
}

class DropItApp extends StatelessWidget {
  const DropItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DropIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111111),
        primaryColor: const Color(0xFFC8F135),
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC8F135),
          background: Color(0xFF111111),
          surface: Color(0xFF1A1A1A),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFC8F135), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF4D6D)),
          ),
          labelStyle: const TextStyle(color: Color(0xFF888888)),
          hintStyle: const TextStyle(color: Color(0xFF555555)),
          prefixIconColor: const Color(0xFF888888),
          suffixIconColor: const Color(0xFF888888),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 18),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC8F135),
            foregroundColor: const Color(0xFF111111),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}