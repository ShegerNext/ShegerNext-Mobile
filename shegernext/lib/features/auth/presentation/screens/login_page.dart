import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shegernext/core/config/route_names.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    // TODO: dispatch login bloc event
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF661AFF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Login',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Username'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            hintText: 'Enter username',
                          ),
                          validator: (String? v) =>
                              (v == null || v.trim().isEmpty)
                              ? 'Required'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Text('Password'),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            hintText: 'Enter password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (String? v) =>
                              (v == null || v.trim().isEmpty)
                              ? 'Required'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF661AFF),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Log In'),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () => context.goNamed(RouteNames.signup),
                          child: const Text("Don't have an account? Sign Up"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF3F5FF),
    );
  }
}


