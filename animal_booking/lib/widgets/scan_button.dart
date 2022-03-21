
import 'package:animal_booking/providers/scan_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';



class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.filter_center_focus),
      onPressed: ()async {

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#3D8BEF", 
          'Cancelar', 
          false, 
          ScanMode.QR
        );
        

        
        // final barcodeScanRes= 'https://google.com';
        // final barcodeScanRes= 'geo:45.280089,-75.922405';
        // si el usuario me cancela
        if (barcodeScanRes =='-1'){
          return;
        }

        final scanListProvider= Provider.of<ScanListProvider>(context,listen:false);
        final nuevoScan=await scanListProvider.nuevoScan(barcodeScanRes);
        
        // inserto uno de geo para probar
        // scanListProvider.nuevoScan('geo:15.33,15.66');

        // launchURL(context, nuevoScan);

        print('------------------------------------------------------------------------------------------------------------------------------------');
        print(barcodeScanRes);
        print('------------------------------------------------------------------------------------------------------------------------------------');
      }
      );
  }
}