import 'package:flutter/material.dart';
import 'package:simple_flutter_api/api/service_api.dart';
import 'package:simple_flutter_api/models/product_model.dart';

class UpdateProductPage extends StatefulWidget {
  final Product product;
  const UpdateProductPage({super.key, required this.product});

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  late int id;
  late String title;
  late double price;
  late String description;
  late String category;
  late String image;
  @override
  void initState() {
    super.initState();
    id = widget.product.id!;
    title = widget.product.title;
    description = widget.product.description;
    category = widget.product.category;
    price = widget.product.price;
    image = widget.product.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update product")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter valid title';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  title = newValue!;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                initialValue: price.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid price';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  price = double.parse(newValue!);
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                maxLines: 6,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                initialValue: description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid description';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  description = newValue!;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                initialValue: category,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please inter valid category';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  category = newValue!;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                maxLines: 2,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
                initialValue: image,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please inter valid image Url';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  image = newValue!;
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Product product = Product(
                          title: title,
                          price: price,
                          description: description,
                          image: image,
                          category: category,
                        );
                        try {
                          apiService
                              .editProduct(id, product)
                              .then((onValue) => Navigator.pop(context));
                        } catch (error) {
                          print('error on adding product: $error');
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
