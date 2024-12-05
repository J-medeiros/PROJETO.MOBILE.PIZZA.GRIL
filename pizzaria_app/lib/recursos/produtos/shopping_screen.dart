import 'package:flutter/material.dart';
import 'package:pizzaria_app/recursos/produtos/product_details_screen.dart';
import '../../core/tema/colors.dart';
// ignore: unused_import
import '../../core/tema/estilos_texto.dart';
import '../../mock/mock_data.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  String? selectedCategory = "Todos";
  TextEditingController searchController = TextEditingController();

  // Função para simular a navegação até a tela de notificações
  void openNotifications() {
    // Navegue para a tela de notificações
  }

  // Função para filtrar produtos conforme a categoria
  List<Map<String, dynamic>> getFilteredProducts() {
    if (selectedCategory == "Todos") {
      return mockProducts;
    }
    return mockProducts
        .where((product) => product['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B4B4B), // Cor de fundo do AppBar
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Espaçamento entre os itens
          children: [
            // Texto de boas-vindas
            const Text(
              'Olá, João Vitor',
              style: TextStyle(
                color: Colors.white, // Cor do texto
                fontSize: 18, // Tamanho do texto
              ),
            ),
            // Ícone de notificações
            IconButton(
              icon: const Icon(
                Icons.notifications, // Ícone de notificações
                color: Colors.white, // Cor do ícone
              ),
              onPressed: openNotifications, // Ação ao pressionar o ícone
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filtro de busca
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Busque',
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 10),
            // Cards de categoria
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mockCategories.length,
                itemBuilder: (context, index) {
                  final category = mockCategories[index];
                  final isSelected = selectedCategory == category['name'];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category['name'];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF434343)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          category['name'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            // Cards de produto
            Expanded(
              child: ListView.builder(
                itemCount: getFilteredProducts().length,
                itemBuilder: (context, index) {
                  final product = getFilteredProducts()[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Card(
                      elevation: 4,
                      color: const Color(0xFFFFFFFF), // Cor de fundo do card
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        children: [
                          // Imagem do produto (40% width)
                          Image.asset(
                            product['image'],
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          // Descrição do produto
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.timer,
                                        size: 20, color: Color(0xFFB7B7B7)),
                                    const SizedBox(width: 5),
                                    Text(
                                      product['estimatedTime'],
                                      style: const TextStyle(
                                          color: Color(0xFFB7B7B7)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                      10.0), // Aplica um padding de 10px em todos os lados
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween, // Alinha os itens com espaçamento entre eles
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        'R\$ ${product['price'].toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Color(0xFF2FB300),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Navegar para a tela de detalhes do produto selecionado
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailsScreen(
                                                product:
                                                    product, // Passando o produto selecionado
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.buttonBackground,
                                        ),
                                        child: const Text('Pedir'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          bottom: 30.0, // Elevação de 30px acima da parte inferior
          left: 10.0, // Espaçamento lateral esquerdo
          right: 10.0, // Espaçamento lateral direito
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF343434), // Cor de fundo
          borderRadius: BorderRadius.circular(20), // Bordas arredondadas
        ),
        child: BottomAppBar(
          color: Colors
              .transparent, // Define como transparente para manter o design do Container
          elevation: 0, // Remove a elevação padrão do BottomAppBar
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0, // Espaçamento interno vertical
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Espaçamento uniforme
              children: [
                // Botão Home
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/shopping');
                  },
                  child: const Icon(
                    Icons.home,
                    color: Color(0xFFB7B7B7),
                  ),
                ),

                // Botão Favoritos
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/favorites');
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Color(0xFFB7B7B7),
                  ),
                ),

                // Botão Carrinho
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Color(0xFFB7B7B7),
                  ),
                ),

                // Botão Pedidos
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/orders');
                  },
                  child: const Icon(
                    Icons.list,
                    color: Color(0xFFB7B7B7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
