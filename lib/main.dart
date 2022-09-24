import 'package:auth/data/shared/prefc.dart';
import 'package:auth/firebase%20service/auth/auth_service.dart';
import 'package:auth/firebase_options.dart';
import 'package:auth/ui/auth/SignUpScreen.dart';
import 'package:auth/ui/success.dart';
import 'package:auth/utils/controller/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isloading = true;

  @override
  void initState() {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    super.initState();
  }

  void _doSignUp() {
    String email = ControllerSign().emailAddress.text.toString().trim();
    String password = ControllerSign().nameController.text.toString().trim();
    String name = ControllerSign().nameController.text.toString().trim();

    setState(() {
      isloading = true;
    });

    AuthService.signInUser(context, email, password).then((value) => {
      _getFirebaseUser(value!)
    });
  }

  void _getFirebaseUser(User user) async {
    setState(() {
      isloading = false;
    });
    if (user != null) {
      await Prefs.saveUserId(user.uid);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Success()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error !"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Email address'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _doSignUp();
                    }, child: const Text('Sign In')),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Did\'t have account ? '),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
