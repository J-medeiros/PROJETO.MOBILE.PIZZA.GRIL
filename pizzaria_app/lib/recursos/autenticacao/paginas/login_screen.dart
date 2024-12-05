// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pizzaria_app/recursos/autenticacao/paginas/registration_screen.dart';
import 'package:pizzaria_app/mock/mock_data.dart';
import '../../../core/tema/colors.dart';
import '../../../core/tema/estilos_texto.dart';
import '../../produtos/shopping_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Verifica se o email e senha estão corretos.
    final user = mockUsers.firstWhere(
      (user) => user['email'] == email && user['senha'] == password,
      orElse: () => {}, // Retorna um mapa vazio (do tipo Map<String, dynamic>)
    );

    if (user.isNotEmpty) {
      // Navega para a tela de compras.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ShoppingScreen(),
        ),
      );
    } else {
      // Exibe mensagem de erro.
      setState(() {
        errorMessage = 'Usuário ou senha incorretos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagem no topo
            Center(
              child: Image.asset(
                'assets/img/logo.jpg',
                height: 220,
                width: 220,
              ),
            ),
            const SizedBox(height: 10),

            // Título destacado
            const Text(
              'Gril',
              style: TextStyles.titleHighlight,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Subtítulo
            Text(
              'Entre na sua conta',
              style: TextStyles.regularText.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Linha de separação
            Divider(
              color: AppColors.border,
              thickness: 1,
              indent: MediaQuery.of(context).size.width * 0.1,
              endIndent: MediaQuery.of(context).size.width * 0.1,
            ),
            const SizedBox(height: 20),

            // Campo de email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                errorText: errorMessage,
              ),
            ),
            const SizedBox(height: 10),

            // Campo de senha
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            // Botão Entrar
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 40,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyles.button,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegistrationScreen()),
                  ).then((message) {
                    if (message != null) {
                      setState(() {
                        errorMessage = message as String?;
                      });
                    }
                  });
                },
                child: const Text(
                  'Não tem uma conta? Registre-se',
                  style: TextStyle(color: AppColors.buttonBackground),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
