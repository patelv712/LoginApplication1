import 'package:flutter/material.dart';
import 'package:practice_project/components/my_button.dart';
import 'package:practice_project/components/my_test_field.dart';
import 'package:practice_project/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class HomeScreen extends StatefulWidget {
  final Function()? onTap;
  const HomeScreen({super.key, required this.onTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user
  void signUserIn() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (exception) {
      Navigator.pop(context);
      if (exception.code == 'user-not-found') {
        wrongInputMessage();
      } else if (exception.code == 'wrong-password') {
        wrongInputMessage();
      }
    }
  }

  void wrongInputMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlutterLogo(size: 100), // Replace with your app's logo or icon
                SizedBox(height: 24),
                Text(
                  'Welcome back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 48),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Username', // Label text for username field
                    border: OutlineInputBorder(), // Add border to TextField
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password', // Label text for password field
                    border: OutlineInputBorder(), // Add border to TextField
                  ),
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password functionality
                    },
                    child: Text('Forgot Password?'),
                  ),
                ),
                SizedBox(height: 32),


                ElevatedButton(
                  onPressed: signUserIn,
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white, // Text color changed to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple, // Button background color changed to white
                    onPrimary: Colors.purple, // This will not have any effect as the text color is handled within the Text widget
                    side: BorderSide(color: Colors.purple, width: 2.0), // Purple border
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),






                SizedBox(height: 32),
                Divider(color: Colors.grey),
                SizedBox(height: 16),
                SignInButton(
                  Buttons.Google, // Pre-styled Google sign-in button
                  text: "Sign in with Google",
                  onPressed: () {
                    // TODO: Implement Google sign-in functionality
                  },
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member? '),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.blue, // Use a theme color for actions
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}