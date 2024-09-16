import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_list_screen.dart';
import 'package:provider/provider.dart';
import '../view_models/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Username'),
              onChanged: (value) => viewModel.username = value,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) => viewModel.password = value,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final currentContext = context; // Capture the context

                try {
                  // Log login attempt
                  // print('Attempting to login with username: ${viewModel.username}');

                  // Attempt login
                  final success = await viewModel.login();

                  // print('await viewModel.login() await passed');

                  // Check if the widget is still mounted
                  if (currentContext.mounted) {
                    if (success) {
                      // Log success and navigate on successful login
                      // print('Login successful. Navigating to ChecklistListScreen.');
                      Navigator.pushReplacement(
                        currentContext,
                        MaterialPageRoute(
                            builder: (context) => const ChecklistListScreen()),
                      );
                    } else {
                      // Log failure
                      // print('Login failed. Incorrect username or password.');
                      ScaffoldMessenger.of(currentContext).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Login failed. Incorrect username or password.'),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  // Log the error
                  print('An error occurred: ${e.toString()}');

                  // Show Snackbar for error
                  if (currentContext.mounted) {
                    ScaffoldMessenger.of(currentContext).showSnackBar(
                      SnackBar(
                        content: Text('An error occurred: ${e.toString()}'),
                      ),
                    );
                  }
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
