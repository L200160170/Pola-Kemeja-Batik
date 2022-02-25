import 'package:flutter/material.dart';
import 'package:projectbatik/main.dart';


 late int _Panjang;
 late int _Lebar;
 late TextEditingController panjangController = new TextEditingController();
 late TextEditingController lebarController = new TextEditingController();

  Future ukuran(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Ukuran Batik'),
          content:Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Column(mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: panjangController,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Panjang Batik',
                      labelText:'Panjang',
                      labelStyle: TextStyle(
                        fontSize: 24,
                      ),
                      border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                ),
                TextField(
                  controller: lebarController,
                  decoration: InputDecoration(
                      hintText: 'Lebar Batik',
                      labelText:'Lebar',
                      labelStyle: TextStyle(
                        fontSize: 24,
                      ),
                      border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                ),
                TextButton(
                    onPressed: (){
                      _Lebar = lebarController.value as int;
                      _Panjang = panjangController.value as int;
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context)=>
                      //       _MyHomePageState(panjangController: _Panjang.bitLength, lebarController: _Lebar.bitLength)
                      // )
                      // );
                    },
                    child: const Text('Submit'))
              ],
            ),
          )
      )
  );

