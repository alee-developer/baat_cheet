import 'package:baat_cheet_app/views/eshop/auth/login_screen.dart';
import 'package:baat_cheet_app/views/eshop/controllers/product_controller.dart';
import 'package:baat_cheet_app/views/eshop/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("eShop"),
        actions: [
          IconButton(
              onPressed: () async {
                var auth = FirebaseAuth.instance;
                if (auth.currentUser != null) {
                  await auth.signOut().then((a) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (_) => false);
                  });
                }
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Consumer<ProductController>(
        builder: (BuildContext context, value, Widget? child) {
          return FutureBuilder(
              future: value.fetchAllProducts(),
              builder: (_, snap) {
                if (!snap.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GridView.builder(
                      itemCount: value.getProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,childAspectRatio: .85),
                      itemBuilder: (_, index) {
                        return productItemView(value.getProducts[index]);
                      });
                }
              });
        },
      ),
    );
  }

  Widget productItemView(ProductData data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child:  Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(data.thumbnail??"",height: 150,)),
            Text(
              data.title??"NA",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
            ),
            Text(
              data.description??"NA",
              style: TextStyle(
                color: Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  data.price.toString(),
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                Text(
                  "",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                Text(
                  "",
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.green),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
