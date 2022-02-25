import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_utilities/flutter_image_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:projectbatik/services/Informasi.dart';
import 'package:projectbatik/services/ml_service.dart';
import 'package:projectbatik/services/Bantuan.dart';
import 'package:photo_view/photo_view.dart';
//import 'package:projectbatik/services/Ukuran.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  runApp(const MyApp());
}
Future initialization(BuildContext? context) async{
  // Load resource
  await Future.delayed(Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pola Kemeja Batik',
      theme: ThemeData(

        //primarySwatch: Colors.orangeAccent,
      ),
      home:  MyHomePage(title: 'Pola Kemeja Batik'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isVisible = false;
  String? message="";
  int? _panjang,_lebar ;
  var imageURL = '';
  File? imageFile;
  late TextEditingController panjangController = new TextEditingController();
  late TextEditingController lebarController = new TextEditingController();


  //_MyHomePageState(this._panjang, this._lebar);

  MLService _mlService = MLService();
  //ukuranBatik _ukuran = ukuranBatik();
  Uint8List? resultImage;



  Widget LoadingImage(Uint8List? imageData) {
    if (imageData == null) {
      return Center(
        child: Container(
          child: Text(
            ' ',
            style: TextStyle(
              fontSize: 18,
            ),
          ),

        ),
      );
    } else if (imageData.length == 0) {
      return Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 5,
            ),
            Text('Loading'),
          ],
        ),
      );
    } else {
      return Image.memory(
        imageData,
        fit: BoxFit.fitWidth,
      );
    }
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Pilih Opsi Pengambilan',
                style: TextStyle(color: Color.fromRGBO(255, 126, 54, 1.0))),
            content: Column(mainAxisSize: MainAxisSize.min,
                children: [
              InkWell(
                onTap: () {
                  _getFromCamera();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.camera,
                        color: Color.fromRGBO(255, 126, 54, 1.0),

                      ),
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(color: Color.fromRGBO(255, 126, 54, 1.0,),fontSize: 15,),
                    ),
                  ],
                ),
              ),
              InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,
                          color: Color.fromRGBO(255, 126, 54, 1.0),
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Color.fromRGBO(255, 126, 54, 1.0),fontSize: 15,),
                      ),
                    ],
                  )),
            ]),
          );
        });
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        androidUiSettings: AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false));
    if (croppedImage != null) {
      setState(() async {
        imageFile = croppedImage;
        isVisible = true;

        setState(() {
          ukuran();
        });
        //Save Image'
        // var bytes = await imageFile!.readAsBytes();
        // var result = await ImageGallerySaver.saveImage(bytes,
        //     quality: 100, name: "Batik.jpg");
        //
        //
        // if (result["isSuccess"] == true) {
        //   setState(() {
        //     print("Image saved successfully.");
        //   });
        //
        // } else {
        //   setState(() {
        //     print(result["errorMessage"]);
        //   });
        //
        // }
        // setState(() {});
      });

    }
  }


  void Showresult() async{
    setState(() {
      resultImage  = Uint8List(0);
      print("1");
    });

    var img = await imageFile!.readAsBytes();
    print("2");

    if (imageFile != null){
      print("3");
      var resultimageData = await _mlService.convertBatik(img);


      setState(() {

        print("4");
        if(resultimageData == null){
          resultImage == null;
          print("5");
        } else {
          print("6");
          resultImage = resultimageData;
        }
      });

    } else{
      print("7");
      setState(() {
        print("8");
        resultImage == null;
      });
    }

  }

  // void uploadimage () async{
  //   //var imagePath =
  //
  //   if (imageFile != null){
  //     var response = await MLService.uploadFile(imageFile!.path);
  //     if (response.statusCode == 200){
  //       //get image url from api response
  //       imageURL = response.data["image"];
  //       print( 'Image uploaded successfully');
  //
  //     } else {
  //       print( 'Failed');
  //     }
  //   } else {
  //     print('image empty');
  //   }
  // }

  Future ukuran() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text('Ukuran Batik'),
            content:Padding(
              padding: const EdgeInsets.all(2.0),
              child:
              Column(mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height:15,),
                  TextField(
                    controller: panjangController,
                    autofocus: true,
                    decoration: InputDecoration(
                        hintText: 'Panjang Batik',
                        labelText:'Panjang',
                        isDense: true,
                        labelStyle: TextStyle(
                          fontSize: 18,
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
                          fontSize: 18
                          ,
                        ),
                        border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                  ),
                  SizedBox(height:15,),

                  Text("* Ukuran dalam satuan Centimeter (CM)",
                    style:TextStyle(fontSize: 15,color: Colors.deepOrangeAccent) ,
                  ),
                  SizedBox(height:18,),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 126, 54, 1.0)),
                      ),
                      onPressed: (){
                        setState(() {

                          Navigator.of(context).pop({panjangController,lebarController});
                          //Navigator.of(context).pop(lebarController.text);


                        });

                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (context)=>
                        //       _MyHomePageState(panjangController: _Panjang.bitLength, lebarController: _Lebar.bitLength)
                        // )
                        // );
                      },
                      child: const Text('Submit',
                          style:TextStyle(color: Color.fromRGBO(255, 239, 217, 1.0))
                      ),
                  )
                ],
              ),
            )
        )
    );

  // uploadImage() async{
  //   final request = http.MultipartRequest(
  //     "POST", Uri.parse('127.0.0.1:4000/convert'));
  //
  //   final headers = {"Content-type": "multipart/form-data"};
  //
  //   request.files.add(http.MultipartFile('image',
  //     imageFile!.readAsBytes().asStream(),imageFile!.lengthSync(),));
  //
  //   request.headers.addAll(headers);
  //   final response = await request.send();
  //   http.Response res= await http.Response.fromStream(response);
  //   final resJon = jsonDecode(res.body);
  //   message = resJon['message'];
  //   setState(() {
  //
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromRGBO(255, 126, 54, 1.0),
      ),
      body:
          Container(
            color: Color.fromRGBO(255, 239, 217, 1.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Stack(
                  children: [
                    imageFile == null
                        ? Text("Silahkan Ambil Gambar", style:TextStyle(fontSize: 30,color: Colors.deepOrangeAccent) ,)
                        : Image.file(imageFile!,

                    ),
                    Visibility(
                      visible: isVisible,
                      child:Positioned.fill(child: Align(
                        alignment: Alignment.bottomRight,
                        child:
                        Text("${panjangController.text} x ${lebarController.text}   CM ",
                          style: TextStyle(fontSize: 18,color: Colors.white,),),
                      ),),),



                  ],
                ),

                SizedBox(height:18,),
                Visibility(
                  visible: isVisible,
                  child:
                    TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                      ),
                      onPressed:
                          (){Showresult();} ,
                          //     (){uploadimage();},
                      icon: Icon(Icons.wallpaper_rounded, color: Colors.white),
                      label: Text("Process",
                          style: TextStyle(
                            color: Colors.white,
                          )
                      )
                  ),



                ),
                SizedBox(height:12,),
                //resultImage == null ? Container() : Image.memory(resultImage!),


                LoadingImage(resultImage),





              ],
            ),
            //tabs[_currentIndex],
          ),



      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(255, 126, 54, 1.0) ,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Builder(
                  builder: (context) => TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 126, 54, 1.0)),
                      ),
                      onPressed: () => informasi(context),
                      icon: Icon(Icons.info_outline, color: Color.fromRGBO(255, 239, 217, 1.0)),
                      label: Text("Informasi",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 239, 217, 1.0),
                          )))
              ),
              Builder(
                  builder: (context) => TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 126, 54, 1.0)),
                      ),
                      onPressed: () => bantuan(context),
                      icon: Icon(Icons.help_outline, color: Color.fromRGBO(255, 239, 217, 1.0)),
                      label: Text("Bantuan",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 239, 217, 1.0),
                          )
                      )
                  )
              ),
        ]
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: _showImageDialog,
        child: const Icon(Icons.add,color: Colors.white ,),
      ),
    );
  }
}
