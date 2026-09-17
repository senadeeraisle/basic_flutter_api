import 'package:flutter/material.dart';
import 'package:simple_flutter_api/api/service_api.dart';
import 'package:simple_flutter_api/models/product_model.dart';
import 'package:simple_flutter_api/screens/update_product_page.dart';

class SingleProductPage extends StatelessWidget {
  final int id;
  const SingleProductPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Single Product Page",
          style: TextStyle(color: Colors.teal),
        ),
      ),
      body: FutureBuilder<Product>(
        future: apiService.getSingleProduct(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('The product is not found'));
          } else {
            Product product = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(product.title, style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 20),
                    Image.network(product.image, width: 200, height: 300),
                    const SizedBox(height: 20),
                    Text(
                      '\$ ${product.price.toString()}',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),

                    Text(product.description, style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateProductPage(product: product),
                              ),
                            );
                          },
                          child: Text('Update'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await apiService.deleteProduct(
                              product.id!,
                              context,
                            );
                            Navigator.pop(context);
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
