import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/screens/checklists_list_screen.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

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
                  final roleId = await viewModel.login();

                  // print('await viewModel.login() await passed');

                  // Check if the widget is still mounted
                  if (currentContext.mounted) {
                    if (roleId == 2 || roleId == 1) {
                      // Log success and navigate on successful login
                      // print('Login successful. Navigating to ChecklistListScreen.');
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacementNamed(
                          AppRoutes.systemsList,
                        );
                      });
                    } else {
                      // Log failure
                      // print('Login failed. Incorrect username or password.');
                      ScaffoldMessenger.of(currentContext).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Login failed. Incorrect username/password or Unauthorized Role.'),
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
