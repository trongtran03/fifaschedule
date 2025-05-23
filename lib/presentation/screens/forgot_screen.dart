import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
     TextEditingController email= TextEditingController();
  reset() async{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("forget password"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
            ElevatedButton(onPressed: (){reset();}, child: Text('send link'))
          ],
        ),
      ),
    );
  }
}