import 'package:flutter/material.dart';
import 'package:mni_tender_flow/Repo/top_management_services.dart';

import 'package:mni_tender_flow/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'View Model/admin_view_model.dart';
import 'View Model/user_view_model.dart';
import 'View/screens/SplashScreen/splash_screen.dart';
import 'config/AppColors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
      providers: [
        Provider(create: (context)=>AdminViewModel(),),
        Provider(create: (context)=>UserViewModel()),
        Provider(create: (context)=>TopManagementServices())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // Provider.of<AdminViewModel>(context,listen: false).updateUsers();
    // Provider.of<TopManagementServices>(context,listen: false).fetchTopManagement();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: AppColors.LIME_GREEN,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black)),
        //scaffoldBackgroundColor: Colors.white,
        // scaffoldBackgroundColor: Color(0xFFF9F6F6).withOpacity(0.97),
        colorScheme: const ColorScheme.light(primary: Colors.cyanAccent),
      ),
      home: const SplashScreen(),
    );
  }
}
