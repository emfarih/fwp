import 'package:flutter/material.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false, // Prevent back button from showing
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Username'),
              onChanged: (value) {
                viewModel.username = value;
                print('Username entered: $value'); // Log username input
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) {
                viewModel.password = value;
                print('Password entered: $value'); // Log password input
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Colors.redAccent, // Text color when button is pressed
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12), // Padding for a better look
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              onPressed: () async {
                final currentContext = context; // Capture the context
                print('Login button pressed'); // Log button press

                try {
                  final roleId = await viewModel.login();
                  print(
                      'Login attempt completed. Role ID: $roleId'); // Log role ID after login attempt

                  // Check if the widget is still mounted
                  if (currentContext.mounted) {
                    if (roleId == 2 || roleId == 1) {
                      print(
                          'Login successful. Navigating to systems list.'); // Log successful login
                      Navigator.of(context).pushReplacementNamed(
                          AppRoutes.checklistTemplatesList);
                    } else {
                      print(
                          'Login failed. Invalid credentials or role.'); // Log failure
                      ScaffoldMessenger.of(currentContext).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Login failed. Incorrect username/password or Unauthorized Role.',
                          ),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  print(
                      'An error occurred during login: ${e.toString()}'); // Log error
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
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white, // Ensure text color is white
                  fontSize: 16, // Set font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
