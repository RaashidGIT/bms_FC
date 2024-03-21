import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24), // Margin around the border
          padding: const EdgeInsets.all(16), // Padding inside the border
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Border around the content
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle_outlined, size: 64), // Login icon
              const SizedBox(height: 24),
              const Text('Account Login'),
              const SizedBox(height: 24),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading
                    ? null // Disable button while loading
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });

                        // Simulate authentication
                        final isAuthorized = await _authenticateUser(
                            _usernameController.text, _passwordController.text);

                        setState(() {
                          _isLoading = false;
                        });

                        if (isAuthorized) {
                          Navigator.pushNamed(context, '/content');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid Username or Password')),
                          );
                        }
                      },
                child: const Text('Login'),
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox
                      .shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _authenticateUser(String username, String password) async {
    return username == 'test' && password == 'password';
  }
}
