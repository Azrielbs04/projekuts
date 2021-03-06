import 'package:flutter/material.dart';
import 'package:projekuts/bloc/ProdukBloc.dart';
import 'package:projekuts/model/ProdukModel.dart';
import 'package:projekuts/screen/widget/produk/ListProduk.dart';

class Produk extends StatefulWidget {
  String kategori;
  Produk({this.kategori});
  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: produkBloc.countProduk,
        builder: (context, AsyncSnapshot<List<ProdukModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return Center(
                child: Text('Tidak Ada Mobil'),
              );
            } else {
              return _buildListProduk(snapshot);
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildListProduk(AsyncSnapshot<List<ProdukModel>> snapshot) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.85,
        ),
        scrollDirection: Axis.vertical,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          final data = snapshot.data[index];
          return InkWell(
            onTap: () {},
            child: ListProduk(
              nama_produk: data.nama_produk,
              harga: data.harga,
              gambar: data.gambar,
              isFavorite: false,
            ),
          );
        });
  }
}
