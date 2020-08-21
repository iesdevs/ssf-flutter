import 'dart:io';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:android_intent/android_intent.dart';

class BlueMan {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<void> blueCheck() async {
    final btState =
        await flutterBlue.state.handleError((e) => BluetoothState.unavailable);
    if (btState == BluetoothState.unavailable) {
      return;
    }
    if (btState != BluetoothState.on) {
      if (Platform.isAndroid) {
        // This will trigger a dialog ("Application wants to turn on Bluetooth, do you want to allow it?")
        const intent = AndroidIntent(
          action: 'android.bluetooth.adapter.action.REQUEST_ENABLE',
        );
        await intent.launch();

        // We wait 5 seconds - fixed.
        // This is a tricky bit, because if the user waits on the aforementioned dialog for more than 5 seconds, we still have a disabled bluetooth adapter below.
        // Also can not wait forever, so prepare your UI to switch back to a "un-connected" status.
        await Future.delayed(Duration(seconds: 5));
      }

      if (await flutterBlue.state != BluetoothState.on) {
        // Switch UI back to "not connected".
        return;
      }
    } else {
      blueScan();
    }
  }

  void blueScan() {
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

    print(subscription);
    flutterBlue.stopScan();
  }
}
