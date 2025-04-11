import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedUsername', _usernameController.text);
      await prefs.setString('savedPassword', _passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created! Please log in.")),
      );

      // Navigate back to the Login screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) =>
                value!.isEmpty ? 'Enter a username' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) => value!.length < 6
                    ? 'Minimum 6 characters required'
                    : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _signup,
                child: const Text('Create Account'),
              ),
              const SizedBox(height: 20),
              // Button to go back to Login screen
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the Login screen
                },
                child: const Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
