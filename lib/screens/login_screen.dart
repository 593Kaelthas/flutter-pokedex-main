import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deber LOGIN de Aplicaciones móviles - Quingatuña Jimmy'),
        centerTitle: true,
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      
      backgroundColor: Colors.amber[50],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 26, 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Log In from MyApp',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'User name'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 26),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 26),
            ElevatedButton(
              onPressed: () async {
                final loginProvider =
                    Provider.of<LoginProvider>(context, listen: false);
                await loginProvider
                    .signIn(
                  _emailController.text,
                  _passwordController.text,
                )
                    .catchError(
                  (error) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Error'),
                        
                        content: Text(
                            'An error has ocurred.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                );
                if (loginProvider.user != null) {
                  Navigator.pushReplacementNamed(context, MainWidget.routeName);
                }
              },
              
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
                backgroundColor: Colors.red,
                
              ),
              child: Text('Log In', style: TextStyle(fontSize: 18),),
              
              
            ),
          ],
        ),
      ),
    );
  }
}
