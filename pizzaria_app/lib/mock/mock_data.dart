// mock/mock_data.dart

// Lista de usuários fictícios
List<Map<String, dynamic>> mockUsers = [
  {
    "nome": "João Vitor Medeiros Dos Santos",
    "teleforne": "(64) 99205-2085",
    "cpf": "041.532.791-10",
    'email': 'joaovitor.m581@gmail.com',
    "senha": "jv1234"
  },
];
// mock/mock_data.dart

List<Map<String, dynamic>> mockCategories = [
  {"name": "Todos", "id": 1},
  {"name": "Pizza", "id": 2},
  {"name": "Bebida", "id": 3},
  {"name": "Pizza Vegana", "id": 4},
  {"name": "Pizza Doce", "id": 5},
];

List<Map<String, dynamic>> mockProducts = [
  {
    "name": "Pizza de Cogumelos",
    "category": "Pizza",
    "price": 120.00,
    "image":
        "assets/img/pizza_cogumelos_grande.jpg", // Substitua com sua imagem
    "estimatedTime": "40-50 min",
  },
  {
    "name": "Pizza Marguerita",
    "category": "Pizza",
    "price": 100.00,
    "image": "assets/img/pizza_marguerita.jpg", // Substitua com sua imagem
    "estimatedTime": "30-40 min",
  },
  // Adicione mais produtos conforme necessário
];

// Código gerado fictício (inicialmente nulo)
String? generatedCode;
