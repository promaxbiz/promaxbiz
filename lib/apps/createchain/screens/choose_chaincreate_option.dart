import 'package:promaxbiz/apps/createchain/models/chain.dart';
import 'package:promaxbiz/apps/createchain/models/chain_list.dart';
import 'package:promaxbiz/apps/createchain/screens/add_chain_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseChainCreateOption extends StatelessWidget {
  static String routename = "/choose_chain_create_option";
  const ChooseChainCreateOption({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Action')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                NavigatorState nav = Navigator.of(context);
                ChainList chainList = Provider.of<ChainList>(
                  context,
                  listen: false,
                );
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ["json"],
                );

                if (result != null) {
                  Chain? chain = await chainList.uploadChain(
                    String.fromCharCodes(result.files.single.bytes!),
                  );
                  if (chain != null) {
                    chain.edit = true;
                    await nav.pushNamed(
                      AddChainScreen.routename,
                      arguments: chain,
                    );
                  }
                } else {
                  // User canceled the picker
                }
              },
              child: const Text('Upload Chain & Edit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushReplacementNamed(AddChainScreen.routename);
              },
              child: const Text('Create a New Chain'),
            ),
          ],
        ),
      ),
    );
  }
}
