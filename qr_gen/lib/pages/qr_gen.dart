import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class GenerateQR extends StatefulWidget {
  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  String data = 'Privet';
  final dataController = TextEditingController();
  final nameController = TextEditingController();
  final qrKey = GlobalKey();

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<String> createQrPicture() async {
    final qrValidationResult = QrValidator.validate(
        data: data,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L);

    final qrCode = qrValidationResult.qrCode;

    final painter = QrPainter.withQr(
        qr: qrCode!,
        color: const Color(0xFF000000),
        embeddedImage: null,
        embeddedImageStyle: null);

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String name = nameController.text;
    String path = '$tempPath/$name.png';

    final picData =
        await painter.toImageData(2048, format: ImageByteFormat.png);
    await writeToFile(picData!, path);

    return path;
  }

  void takeScreenShot() async {
    final path = await createQrPicture();
    final success = await GallerySaver.saveImage(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner/Generator'),
        backgroundColor: Colors.green,
      ),
      body: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: QrImage(
                  key: qrKey,
                  data: data,
                  backgroundColor: Colors.white,
                  size: 300),
            ),
            SizedBox(height: 24),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter the text'),
                controller: dataController,
                onChanged: (value) {
                  setState(() {
                    data = value;
                  });
                },
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(hintText: 'Enter the filename'),
                controller: nameController,
              ),
            ),
            SizedBox(height: 24),
            TextButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))),
                onPressed: () {
                  takeScreenShot();
                },
                child: Text('Generate QR Code'))
          ],
        ),
      ),
    );
  }
}
