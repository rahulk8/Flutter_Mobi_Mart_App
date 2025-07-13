import 'dart:convert';
import 'package:bmdu_app/api_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyMartApp());
}

class MyMartApp extends StatelessWidget {
  const MyMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.green,
              height: 200,
              child: Center(
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDgX-z_osCCGv_YTSp5wemHM108KhH1bPERQ&s',
                  height: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sign Up', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Please Enter Details Below'),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                  ),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      const Text('I agree with Privacy and Policy'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                    onPressed: () async {
                      String name = nameController.text.trim();
                      String phone = phoneController.text.trim();
                      String password = passwordController.text.trim();

                      var response = await ApiService.signUp(name, phone, password);

                      print('Sign Up Status Code: ${response.statusCode}');
                      print('Sign Up Response Body: ${response.body}');

                      try {
                        var data = jsonDecode(response.body);

                        if (response.statusCode == 201) {
                          print("Sign Up Success: $data");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Sign Up Successful')),
                          );
                        } else {
                          print("Sign Up Error: $data");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Sign Up Failed')),
                          );
                        }
                      } catch (e) {
                        print('Sign Up JSON Parse Error: $e');
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 10),
                  const Center(child: Text('Or')),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.green,
              height: 200,
              child: Center(
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDgX-z_osCCGv_YTSp5wemHM108KhH1bPERQ&s',
                  height: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Log In', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Please Enter Details Below'),
                  const SizedBox(height: 16),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                    onPressed: () async {
                      String phone = phoneController.text.trim();
                      String password = passwordController.text.trim();

                      var response = await ApiService.login(phone, password);

                      print('Login Status Code: ${response.statusCode}');
                      print('Login Response Body: ${response.body}');

                      try {
                        var data = jsonDecode(response.body);

                        if (response.statusCode == 200) {
                          print("Login Success: $data");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login Successful')),
                          );

                          Navigator.pushReplacementNamed(context, '/home');  // ✅ To prevent back navigation
                        } else {
                          print("Login Error: $data");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login Failed')),
                          );
                        }
                      } catch (e) {
                        print('Login JSON Parse Error: $e');
                      }
                    },
                    child: const Text('Log In'),
                  ),
                  const SizedBox(height: 10),
                  const Center(child: Text('Or')),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: 'Don’t have an account? ',
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var response = await ApiService.logout();

            print('Logout Status Code: ${response.statusCode}');
            print('Logout Response Body: ${response.body}');

            try {
              var data = jsonDecode(response.body);

              if (response.statusCode == 200) {
                print("Logout Success: $data");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout Successful')),
                );

                Navigator.pushReplacementNamed(context, '/login');
              } else {
                print("Logout Error: $data");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout Failed: ${data['message'] ?? 'Unknown error'}')),
                );
              }
            } catch (e) {
              print('Logout JSON Parse Error: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout Failed: Invalid response format')),
              );
            }
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}

