import 'package:clone_amazon/layout/screen_layout.dart';
import 'package:clone_amazon/providers/user_details_provider.dart';
import 'package:clone_amazon/screens/signIn.dart';
import 'package:clone_amazon/utils/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDp_Y8yGtw_F8Vp4o3xTlsEPhW7LqToioA",
      authDomain: "clone-cb58f.firebaseapp.com",
      projectId: "clone-cb58f",
      storageBucket: "clone-cb58f.appspot.com",
      messagingSenderId: "637941856879",
      appId: "1:637941856879:web:5aa135c3c7be31ccafeb9a",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        title: "Amazon Clone",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else if (user.hasData) {
              return const ScreenLayout();
            } else {
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}