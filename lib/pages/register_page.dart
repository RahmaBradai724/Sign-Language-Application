import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signrecognizer/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
   RegisterPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // You can add more code here to save the user profile in Firestore if needed.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to register: $e'),
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
              Text("Inscription", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 32),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nom complet", border: OutlineInputBorder()),
              ),
              SizedBox(height: 16),
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
                  onPressed: () => _register(context),
                  child: Text("Créer un compte"),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Déjà un compte ? Se connecter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
