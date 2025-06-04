import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Bienvenido, ${state.name}!')),
            );
            context.go('/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/logo_labtrack.png'),
                  ),
                  const SizedBox(height: 50),
                  _buildInputLabel('Correo Electrónico:'),
                  _buildTextField(emailController, 'Correo electrónico', false),
                  const SizedBox(height: 20),
                  _buildInputLabel('Contraseña:'),
                  _buildTextField(passwordController, 'Contraseña', true),
                  const SizedBox(height: 40),
                  _buildButton(
                    'Entrar',
                    isLoading,
                    () {
                      context.read<AuthBloc>().add(
                            LoginEvent(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: const Text(
                      '¿No tienes cuenta? Regístrate',
                      style: TextStyle(
                        color: Color(0xFF219EBC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: hint,
        border: const UnderlineInputBorder(),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget _buildButton(String text, bool isLoading, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFF219EBC), width: 2),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF219EBC),
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}