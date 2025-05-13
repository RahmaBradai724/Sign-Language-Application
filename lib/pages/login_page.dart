import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signrecognizer/pages/home_page.dart';
import 'package:signrecognizer/pages/register_page.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => StaticHomePage()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to sign in: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Connexion", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Mot de passe", border: OutlineInputBorder()),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _signIn(context),
                  child: Text("Se connecter"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage()));
                },
                child: Text("Pas encore de compte ? S'inscrire"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
