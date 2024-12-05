import 'dart:async';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final String size;
  final int quantity;

  // ignore: use_super_parameters
  const CheckoutScreen({
    Key? key,
    required this.product,
    required this.size,
    required this.quantity,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? selectedPaymentMethod;
  final TextEditingController couponController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();

  void finalizeOrder() {
    if (selectedPaymentMethod == null ||
        streetController.text.isEmpty ||
        houseNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos obrigatórios!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          title: Text("Processando..."),
          content: Text("Seu pedido está sendo processado."),
        );
      },
    );

    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Pedido Confirmado"),
            content:
                const Text("Seu pedido foi confirmado e está sendo enviado."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizar Compra"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Produto: ${widget.product['name']}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Tamanho: ${widget.size}"),
            Text("Quantidade: ${widget.quantity}"),
            Text(
              "Total: R\$ ${(widget.product['price'] * widget.quantity).toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),
            const Text("Endereço de Entrega",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
                controller: streetController,
                decoration: const InputDecoration(labelText: "Rua")),
            TextField(
                controller: houseNumberController,
                decoration: const InputDecoration(labelText: "Número")),
            TextField(
                controller: complementController,
                decoration: const InputDecoration(labelText: "Complemento")),
            const Divider(height: 30),
            const Text("Forma de Pagamento",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Column(
              children: ["Cartão", "Dinheiro", "Pix"].map((method) {
                return RadioListTile(
                  title: Text(method),
                  value: method,
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value.toString();
                    });
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: finalizeOrder,
              child: const Text("Finalizar Pedido"),
            ),
          ],
        ),
      ),
    );
  }
}
