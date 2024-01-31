import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice_project/components/my_button.dart';
import 'package:practice_project/components/my_test_field.dart';
import 'package:practice_project/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_project/services/aut_services.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  //sign user
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    Navigator.pop(context);

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        //show error message that passwords aren't the same
        wrongInputMessage("Passwords don't match");
      }
    } on FirebaseAuthException catch (exception) {
      //Navigator.pop(context);
      if (exception.code == 'auth/user-not-found') {
        //print('No user found/ wrong email');

        wrongInputMessage("Wrong email");
      } else if (exception.code == 'auth/wrong-password') {
        //print('Wrong password');

        wrongInputMessage("Wrong password");
      }
      else{
        wrongInputMessage("Wrong email or password");
      }
    }
  }

  void wrongInputMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white, // Background color set to white
    body: SafeArea(
      child: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),

            FlutterLogo(size: 100), // Replace with your app's logo or icon

            const SizedBox(height: 50),

            Text(
              'Let\'s create an account',
              style: TextStyle(
                color: Colors.black87, // Text color set to a standard black for better contrast
                fontSize: 24, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Bold font weight
              ),
            ),

            const SizedBox(height: 25),

            // Email TextField
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(), // Add border to TextField
              ),
            ),

            const SizedBox(height: 10),

            // Password TextField
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(), // Add border to TextField
              ),
            ),

            const SizedBox(height: 10),

            // Confirm Password TextField
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(), // Add border to TextField
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: signUserUp,
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, // Button color set to dark purple
                onPrimary: Colors.white, // Text color set to white
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ... other widgets remain unchanged ...

          ],
        ),
      )),
    ),
  );
}

}
