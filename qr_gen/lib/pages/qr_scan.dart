import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';

class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String qrCodeResult = 'Not scanned';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('QR Scanner/Generator'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Result of scanning',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              child: Text(
                qrCodeResult,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: qrCodeResult));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
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
              onPressed: () async {
                String codeScanner = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666',
                    'Cancel',
                    false,
                    ScanMode.DEFAULT); //barcode scanner
                setState(() {
                  codeScanner == '-1' ? qrCodeResult = 'Not scanned': qrCodeResult = codeScanner; 
                });
              },
              child: Text(
                'Scan QR code',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
