import 'package:flutter/material.dart';
import '../core/tema/colors.dart';
import '../core/tema/estilos_texto.dart';
import '../mock/mock_data.dart';

class ValidateCodeScreen extends StatefulWidget {
  final String email;

  const ValidateCodeScreen({required this.email, super.key});

  @override
  State<ValidateCodeScreen> createState() => _ValidateCodeScreenState();
}

class _ValidateCodeScreenState extends State<ValidateCodeScreen> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? errorMessage;

  void validateAndChangePassword() {
    final code = codeController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (code != generatedCode) {
      setState(() {
        errorMessage = 'Código inválido.';
      });
      return;
    }

    if (newPassword.length < 8 ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPassword)) {
      setState(() {
        errorMessage =
            'A senha deve ter pelo menos 8 caracteres e um caractere especial.';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        errorMessage = 'As senhas não coincidem.';
      });
      return;
    }

    setState(() {
      errorMessage = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Senha alterada com sucesso!')),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validar Código'),
        backgroundColor: AppColors.buttonBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Digite o código enviado para ${widget.email}',
              style: TextStyles.titleHighlight,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Código',
                border: const OutlineInputBorder(),
                errorText: errorMessage,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(
                labelText: 'Nova Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirmar Nova Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: validateAndChangePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBackground,
              ),
              child: const Text('Redefinir Senha'),
            ),
          ],
        ),
      ),
    );
  }
}
