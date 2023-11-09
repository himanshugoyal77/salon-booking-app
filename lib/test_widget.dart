import 'package:flutter/material.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void get() async {
      const port = 80;
      final stream = NetworkAnalyzer.discover2(
        '192.168.0',
        port,
        timeout: Duration(milliseconds: 5000),
      );

      int found = 0;
      stream.listen((NetworkAddress addr) {
        // print('${addr.ip}:$port');
        if (addr.exists) {
          found++;
          print('Found device: ${addr.ip}:$port');
        }
      }).onDone(() => print('Finish. Found $found device(s)'));
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            get();
          },
          child: const Text('Ping'),
        ),
      ),
    );
  }
}
