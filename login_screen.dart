  import 'package:flutter/material.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'home_screen.dart';

  class LoginScreen extends StatefulWidget {
    const LoginScreen({Key? key}) : super(key: key);

    @override
    State<LoginScreen> createState() => _LoginScreenState();
  }

  class _LoginScreenState extends State<LoginScreen> {
    final _formKey = GlobalKey<FormState>();
    bool isSignup = false;
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();

    void _toggleForm() {
      setState(() => isSignup = !isSignup);
    }

    Future<void> _submit() async {
      if (_formKey.currentState!.validate()) {
        final prefs = await SharedPreferences.getInstance();

        if (isSignup) {
          await prefs.setString('email', _email.text);
          await prefs.setString('password', _password.text);
          await prefs.setBool('isLoggedIn', true);
        } else {
          final savedEmail = prefs.getString('email');
          final savedPassword = prefs.getString('password');

          if (_email.text == savedEmail && _password.text == savedPassword) {
            await prefs.setBool('isLoggedIn', true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid credentials')),
            );
            return;
          }
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  isSignup ? 'Sign Up' : 'Login',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        decoration: _inputDecoration("Email"),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) => value!.isEmpty ? 'Enter email' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _password,
                        decoration: _inputDecoration("Password"),
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) => value!.isEmpty ? 'Enter password' : null,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(isSignup ? 'Sign Up' : 'Login'),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _toggleForm,
                        child: Text(
                          isSignup ? 'Already have an account? Login' : 'Don’t have an account? Sign up',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    InputDecoration _inputDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange)),
      );
    }
  }
