
import 'package:batchit/helper/helper_function.dart';
import 'package:batchit/pages/home_page.dart';
import 'package:batchit/pages/login_page.dart';
// import 'package:batchit/service/home_page.dart';
// import 'package:batchit/pages/auth/login_page.dart';
import 'package:batchit/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options:FirebaseOptions(
        apiKey:Constants.apiKey,
        appId: Constants.appId,
        messagingSenderId:Constants.messagingSenderId,
        projectId: Constants.projectId));
  } else{
      await Firebase.initializeApp();
  }

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStauts();
  }
  getUserLoggedInStauts() async{
    await HelperFunctions.getUserLoggedInStauts().then((value) {
      if (value != null) {
         setState(() {
           _isSignedIn = value;
         });
      }
    });
    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
        primaryColor:Constants().primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ) ,
      debugShowCheckedModeBanner: false,
      home: _isSignedIn?HomePage():LoginPage(),
    );
  }
}
