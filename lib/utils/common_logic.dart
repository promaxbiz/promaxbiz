import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:promaxbiz/apps/createchain/models/chain_list.dart';
import 'package:promaxbiz/apps/createchain/screens/add_chain_screen.dart';
import 'package:promaxbiz/utils/menu_options.dart';
import 'package:provider/provider.dart';

import '../apps/createchain/models/chain.dart';

class CommonLogic {
  Future<void> handleMenuSelection(
      BuildContext context, MenuOptions value) async {
    switch (value) {
      case MenuOptions.addEditChain:
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

        break;
      case MenuOptions.createNewChain:
        Navigator.of(
          context,
        ).pushReplacementNamed(AddChainScreen.routename);
        break;
      case MenuOptions.playChain:
        Navigator.of(context).pushReplacementNamed("/");
        break;
    }
  }
}
