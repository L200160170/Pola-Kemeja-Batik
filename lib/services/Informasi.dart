import 'package:flutter/material.dart';

void informasi(context)=> showModalBottomSheet(context: context,
    backgroundColor: Colors.transparent,
    builder: (context)=>Container(
        decoration: const BoxDecoration(
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
              const Text('Informasi',
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
                child: const Text(
                  'Aplikasi pola kemeja batik ini bertujuan untuk menghasilkan '
                  'gambaran bagaimana desain kemeja dengan '
                  'batik motif sambung dari selembar kain batik.'
                      ''

                      ,
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


