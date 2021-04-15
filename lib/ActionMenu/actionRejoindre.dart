import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';

class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {

  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.fromLTRB(20, 70, 20, 50),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0, 10),
            image: AssetImage("images/background.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'images/annecyGoTitle.png',
              fit: BoxFit.fitWidth,
            ),
        Padding(
          padding: const EdgeInsets.only(
            top: 50.0,
            left: 20.0,
            right: 10.0,
            bottom: 200.0,
          ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Message displayed over here
                  Text(
                    "Result",
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    qrCodeResult,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  //Button to scan QR code
                  ButtonTheme(
                    minWidth: 200.0,
                    child: new ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(20, 10, 20, 10)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white),
                          minimumSize: MaterialStateProperty.all(
                              Size(250.0, 20.0)),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.white),
                              )
                          )
                      ),
                      child: new Text(
                        'Open Scanner',
                        style:
                        TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                          fontSize: 40,
                        ),
                      ),
                      onPressed: () async {
                        String codeSanner = await BarcodeScanner
                            .scan(); //barcode scnner
                        setState(() {
                          qrCodeResult = codeSanner;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}