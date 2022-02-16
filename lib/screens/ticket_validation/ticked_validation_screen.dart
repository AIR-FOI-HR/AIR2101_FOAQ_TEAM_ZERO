import 'dart:io';

import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:museum_app/widgets/app_bar.dart';
import 'package:museum_app/widgets/main_menu_drawer.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TicketValidationScreen extends StatefulWidget {
  static const routeName = '/ticketValidation';
  @override
  _TicketValidationScreenState createState() => _TicketValidationScreenState();
}

class _TicketValidationScreenState extends State<TicketValidationScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  Barcode result;
  bool scan = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    controller.resumeCamera();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    User appUser = Provider.of<Users>(context).getUser();
    final appBarProperty =
        appBar('Validate tickets', context, color.primaryColor, appUser);

    return Scaffold(
      appBar: appBarProperty,
      drawer: MainMenuDrawer(),
      body: Center(
          child: scan
              ? buildQrView(context)
              : result != null
                  ? Text(result.code)
                  : const Text('Scan')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).highlightColor,
        onPressed: () {
          setState(() {
            scan = !scan;
          });
        },
        child: const IconButton(
          icon: Icon(
            Icons.qr_code_scanner_sharp,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        overlay: QrScannerOverlayShape(
          borderRadius: 10,
          borderColor: Colors.red,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
        onQRViewCreated: _onQRViewCreated,
      );

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      print('DATAAAAAAAAAAAAAAAAAAAAAAAAAAAA ' + scanData.code);
      setState(() {
        result = scanData;
        this.controller.dispose();
        scan = !scan;
      });
    });
  }
}
