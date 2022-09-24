import 'package:auth/firebase%20service/auth/auth_service.dart';
import 'package:auth/utils/controller/sign.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: ControllerSign().emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Email address'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: ControllerSign().nameController,
                decoration: const InputDecoration(
                    hintText: 'Name'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: ControllerSign().password,
                decoration: const InputDecoration(
                    hintText: 'Password'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Error !"),
                      ));
                      AuthService.signUpUser(context, ControllerSign().nameController.text, ControllerSign().emailAddress.text, ControllerSign().password.text).then((value) => {
                        print(value?.uid)
                      });
                    },
                    child: const Text('Sign In')),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('You an have account ? '),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Sign In',style: TextStyle(color: Colors.red),)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
