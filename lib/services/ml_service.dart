import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MLService{
  Dio dio = Dio();

  Future<Uint8List?> convertBatik (Uint8List imageData) async{
    try{
      print("A");
      var encodedData = await compute(base64Encode, imageData);
      print("B");
      Response response = await dio.post('http://127.0.0.1:5000/convert',
          data:{'image': encodedData }
      );

      print("C");

      String result = response.data['image'];
      print("D");
      return compute(base64Decode, result);


    } catch(e){
      print("E");
      return null;

    }
  }

}

// class MLService{
//   static Future<dynamic> uploadFile(filePath) async{
//     try{
//       FormData formData =
//           new FormData.fromMap({
//             "image":
//             await MultipartFile.fromFile(filePath,filename: "batik")
//           });
//       Response response =
//       await Dio().put(
//         "127.0.0.1:4000/convert",
//         data: formData
//       );
//       return response;
//     }
//     on DioError catch(e){
//       return e.response;
//     }
//   }
//
// }
