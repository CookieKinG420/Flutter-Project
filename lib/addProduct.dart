import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_connect_api_app/service/DoingWithProductDetailsApi.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  AddProductPageStale createState() => AddProductPageStale();
}

class AddProductPageStale extends State<AddProductPage> {
  bool getSaveStatus = false;
  final nameCon = TextEditingController();
  final desCon = TextEditingController();
  final priCon = TextEditingController();
  final picker = ImagePicker();
  XFile? pickedImage;

  Future<void> summitSave() async {
    if (nameCon == null ||
        desCon == null ||
        priCon == null ||
        selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fildes'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    var prodName = nameCon.text;
    var prodDesc = desCon.text;
    var prodPrice = double.parse(priCon.text);
    var prodType = selectedType;

    var imageBytes = getImageByte();
    if (imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Upload image'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    var respone = await addProduct.postProduct(
      prodName,
      prodDesc,
      prodPrice,
      prodType!,
      imageBytes,
    );

    if (respone.statusCode == 200) {
      getSaveStatus = true;
      print('post product sucess');
    } else {
      getSaveStatus = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The image file is to large please use new image'),
          duration: Duration(seconds: 2),
        ),
      );
      print('post producct not good');
    }
  }

  BoxDecoration boxUploadImage = BoxDecoration(
      border: Border.all(
          color: const Color.fromARGB(255, 187, 187, 187), width: 8.0),
      borderRadius: BorderRadius.circular(20.0));
  final prodType = [
    'Smart Phone',
    'Desktop',
    'PC PART',
    'Tablet',
    'Smart Watch'
  ];
  String? selectedType;
  String? dialogMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Add Product',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameCon,
              decoration: InputDecoration(
                labelText: 'Product name',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: desCon,
              decoration: InputDecoration(
                labelText: 'Product Description',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: priCon,
              decoration: InputDecoration(
                labelText: 'Product Price',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              items: prodType.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              value: selectedType,
              decoration: InputDecoration(
                labelText: 'Product Type',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                decoration: boxUploadImage,
                height: 250,
                width: double.infinity,
                child: pickedImage != null
                    ? InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Image.file(File(pickedImage!.path)))
                    : Focus(
                        descendantsAreFocusable: false,
                        canRequestFocus: false,
                        child: IconButton(
                          iconSize: 60.0,
                          onPressed: pickImage,
                          color: Colors.grey,
                          highlightColor: Colors.transparent,
                          //splashColor: Colors.transparent,
                          // splashRadius: 0,
                          icon: const Icon(
                            Icons.photo_library_outlined,
                          ),
                        ),
                      )),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '*Please Use image with lower 50Kb file size',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final dialogShow = showDialog(
                  context: context,
                  builder: (context) => const Dialog(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Loading...'),
                        ],
                      ),
                    ),
                  ),
                );
                dialogShow;
                await summitSave();
                if (getSaveStatus) {
                  dialogMessage = 'Product Save!!';
                } else {
                  dialogMessage = 'Fails to save Product';
                }
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(dialogMessage!),
                      duration: const Duration(seconds: 4),
                    ),
                  );
                });
                // ignore: use_build_context_synchronously
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }

  void pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = pickedFile;
    });
  }

  String? getImageByte() {
    if (pickedImage != null) {
      File file = File(pickedImage!.path);
      return base64Encode(file.readAsBytesSync());
    }
    return null;
  }

  void showDialogWarrnig(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          child: Text('Please fill all the filds'),
        );
      },
    );
  }
}
