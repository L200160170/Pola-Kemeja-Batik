import 'package:flutter/material.dart';

  void bantuan(context)=> showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=>Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 239, 217, 1.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )
        ),
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(255, 239, 217, 1.0),
              padding: EdgeInsets.all(12),
              child:
                Text('Bantuan',
                  style: TextStyle(
                  color: Color.fromRGBO(255, 126, 54, 1.0),
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  ),
                ),
            ),
            Container(
              color: Color.fromRGBO(255, 239, 217, 1.0),
              padding: EdgeInsets.all(20),
                   child: Text(
                     'Cara Menggunakan Aplikasi :'
                     '\n\n 1. Tekan tombol Add untuk mengambil gambar'
                     '\n 2. Pilih cara pengambilan gambar dari Camera/Gallery'
                     '\n 3. Crop gambar sesuai dengan kebutuhan'
                     '\n 4. Masukkan ukuran batik'
                     '\n 5. Tekan tombol Proses untuk memproses gambar'
                     '\n 6. Tunggu Beberapa saat'
                     '\n 7. Setelah itu menampilkan Hasil proses'
                     '\n 8. Slide ke kiri pada gambar untuk melihat pola batik '
                     '\n\n\n'
                     'NB : Untuk mendapatkan Informasi lebih lanjut tekan tombol Informasi',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color.fromRGBO(255, 126, 54, 1.0),
                  ),
                   )

            ),



        ],
      )
      )
  );


