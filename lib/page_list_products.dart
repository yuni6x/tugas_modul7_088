import 'package:flutter/material.dart';
import 'package:tugas_modul7_http/datasource.dart';
import 'package:tugas_modul7_http/model.dart';

class PageListProducts extends StatefulWidget {
  const PageListProducts({Key? key}) : super(key: key);

  @override
  State<PageListProducts> createState() => _PageListProductsState();
}

class _PageListProductsState extends State<PageListProducts> {
  late Future<List<ProductModel>> _futureProductsModel;

  @override
  void initState() {
    super.initState();
    _futureProductsModel = ApiDataSource.instance.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Products"),
      ),
      body: _buildListProductsBody(),
    );
  }

  Widget _buildListProductsBody() {
    return Container(
      child: FutureBuilder<List<ProductModel>>(
        future: _futureProductsModel,
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasError) {
            // If data has error, display the error message
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // If data is available and successful, display the data
            return _buildSuccessSection(snapshot.data!);
          }
          // If data is still loading, display a progress indicator
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Center(
      child: const Text("Error"),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<ProductModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemProduct(context, data[index]);
      },
    );
  }

  Widget _buildItemProduct(BuildContext context, ProductModel product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailProductPage(product)),
        );
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: Image.network(product.image!),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title!),
                  Text("\$${product.price!.toString()}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailProductPage extends StatelessWidget {
  final ProductModel product;

  const DetailProductPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(product.image!, width: 200,),
              ),
              const SizedBox(height: 16.0),
              Text("\$${product.price!.toString()}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Text(product.description!),
              const SizedBox(height: 16.0),
              Text("Category: ${product.category!}"),
            ],
          ),
        ),
      ),
    );
  }
}

