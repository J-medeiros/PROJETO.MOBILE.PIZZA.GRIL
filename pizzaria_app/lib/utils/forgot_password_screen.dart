// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:pizzaria_app/utils/validate_code_screen.dart';
import '../core/tema/colors.dart';
import '../core/tema/estilos_texto.dart';
import '../mock/mock_data.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  String? errorMessage;

  void sendCode() {
    final email = emailController.text.trim();

    // Verifica se o email está registrado.
    final user = mockUsers.firstWhere(
      (user) => user['email'] == email,
      orElse: () => {}, // Retorna um mapa vazio como fallback.
    );

    if (user.isNotEmpty) {
      // Gera um código fictício e exibe mensagem de sucesso.
      generatedCode = '123456'; // Código fixo para demonstração.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ValidateCodeScreen(email: email),
        ),
      );
    } else {
      // Exibe mensagem de erro se o email não estiver registrado.
      setState(() {
        errorMessage = 'Email não encontrado.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
        backgroundColor: AppColors.buttonBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Informe o email registrado:',
              style: TextStyles.titleHighlight,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                errorText: errorMessage,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBackground,
              ),
              child: const Text('Enviar Código'),
            ),
          ],
        ),
      ),
    );
  }
}
