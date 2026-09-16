import 'package:flutter/material.dart';
import 'package:simple_flutter_api/api/service_api.dart';
import 'package:simple_flutter_api/models/product_model.dart';
import 'package:simple_flutter_api/screens/add_new_products.dart';
import 'package:simple_flutter_api/screens/single_product_page.dart';

class AllProductPage extends StatefulWidget {
  const new({super.key});

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Products")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewProducts()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Product>>(
        future: apiService.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Products'));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Product product = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      // color: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      focusColor: Colors.grey.withValues(alpha: 0.2),
                      tileColor: Colors.grey.withValues(alpha: 0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text(product.title),
                      subtitle: Text('\$ ${product.price.toStringAsFixed(2)}'),
                      leading: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SingleProductPage(id: product.id!),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
