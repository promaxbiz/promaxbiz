// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:html' hide File;

import 'package:promaxbiz/apps/createchain/models/chain_activity.dart';
import 'package:flutter/material.dart';
import 'package:promaxbiz/apps/createchain/helpers/constants.dart';
import 'package:promaxbiz/apps/createchain/models/activity.dart';
import 'package:promaxbiz/apps/createchain/models/chain.dart';
import 'package:intl/intl.dart';

import 'package:share_plus/share_plus.dart';
//import 'package:promaxbiz/apps/createchain/screens/play_chain_screen.dart';

/*

Table of Content for Functions defined in this class
Chain:
	addChain
	removeChain
	-> updateSchdule
	rearrangeChains
	pinChain
	fetchChains

Activity:
	-> addActivity .. no need as of now.
	removeActivity
	updateActivity
	rearrangeActivites
	updateActivityIndex
	flipDoneActivity
	loadActivities
	fetchActivities

Util:
	clearDataBase
	disposeAds

*/

class ChainList with ChangeNotifier {
  bool loaded = false, configUpdated = false, configUpdateStarted = false;
  String catClockMode = "HH:MM:SS"; // ["HH:MM:SS","HH:MM","AM/PM"];
  List<Chain> chains = [];
  List<Activity> activities = [];
  Map<String, dynamic>? notificationCameAs;
  List<int> notificationIdsInDB = [];
  // Chain? notificationCameForChain;
  // String? notificaitonCameForUrl;
  //List<int> adIndexInChains = [];
  //final AdState adState;
  final BuildContext context;
  StreamSubscription? intentDataStreamSubscription;

  ChainList(
    this.context,
    //this.notificationHelper,
    //this.adState,
  );

  Future<void> addChain(Chain chain, ChainActivity chainActivity) async {
    chain.lastUpdatedAt = DateTime.now();
    int chainIndex = chains.indexWhere((sch) => sch.title == chain.title);

    if (chainIndex == -1) {
      chain.index = chains.length;
      chains.add(chain);
    } else {
      chain.index = chainIndex;
      chains[chainIndex] = chain;
    }

    int activityIndex = activities.indexWhere(
      (act) => act.title == chainActivity.activity.title,
    );

    if (chainActivity.index == -1) {
      chainActivity.index = chain.activities.length;
    }

    if (activityIndex == -1) {
      activities.add(chainActivity.activity);
      chainActivity.activity.lastUpdatedAt = DateTime.now();
    } else {
      chainActivity.activity = activities[activityIndex];
    }

    notifyListeners();
  }

  Future<void> removeChain(Chain chain) async {
    chains.removeWhere((sch) => sch.title == chain.title);

    await removeAllUnusedActivities(
      activities
          .where((activity) => activity.type == waitActivityInDB)
          .toList(),
    );

    notifyListeners();
  }

  Future<void> updateChain(
    Chain chain, [
    bool updateLastUpdateDate = true,
  ]) async {
    int chainIndex = chains.indexWhere((sch) => sch.title == chain.title);

    if (chainIndex == -1) {
      return;
    }

    chain.lastUpdatedAt =
        updateLastUpdateDate ? DateTime.now() : chain.lastUpdatedAt;
    chains[chainIndex] = chain;

    notifyListeners();
  }

  Future<void> updatChainActivityByChainName(
    Chain chain, [
    bool editChainActivity = false,
  ]) async {
    for (int i = 0; i < chain.activities.length; i++) {
      chain.activities[i].edit = false;
    }

    notifyListeners();
  }

  Future<void> resetChain(Chain chain, [bool storeInDb = true]) async {
    for (ChainActivity activity in chain.activities) {
      activity.edit = false;
      activity.activityDone = false;
      activity.isInterrupted = false;
      activity.at = null;
      activity.endedAt = null;
    }

    chain.at = chain.endedAt = chain.pivotDate = null;
    chain.notificationId = noValueInDB;
    chain.chainStatus = statusNotStarted;
    chain.repeatType = repeatTypeDoesNotRepeat;
    chain.repeatTypeGap = repeatTypeDefaultGap;
    chain.repeatCount = repeatTypeDefaultCount;
    chain.lastUpdatedAt = DateTime.now();
    if (storeInDb) {
      await updateChain(chain);
    }
    notifyListeners();
  }

  Future<void> removeActivityFromChain(
    Chain chain,
    ChainActivity chainActivity,
  ) async {
    int indexOfChainActivity = chain.activities.indexWhere(
      (activityArg) =>
          activityArg.activity.activityId == chainActivity.activity.activityId,
    );

    chain.activities.removeAt(indexOfChainActivity);
    chain.activities.removeAt(indexOfChainActivity);

    if (chain.activities.length == 1) {
      chain.activities = [];
      await removeChain(chain);
    }

    updateActivityIndex(chain);
    chain.lastUpdatedAt = DateTime.now();
    await updateChain(chain);

    //workaround to avoid leftover activities
    await removeAllUnusedActivities(
      activities
          .where((activity) => activity.type == waitActivityInDB)
          .toList(),
    );

    notifyListeners();
  }

  Future<bool> removeAllUnusedActivities(
    List<Activity> activitiesToBeRemoved,
  ) async {
    try {
      for (Activity activity in activitiesToBeRemoved) {
        List<Chain> chainsUsingThisActivity = getChainsUsingThisActivity(
          activity,
        );
        if (chainsUsingThisActivity.isEmpty) {
          await removeActivity(activity);
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, int> getCountForActivities() {
    int inUseCount = 0, notInUseCount = 0;

    for (Activity activity in activities) {
      if (activity.type != waitActivityInDB) {
        continue;
      }
      bool activityFound = false;
      for (Chain chain in chains) {
        for (ChainActivity chainActivity in chain.activities) {
          if (chainActivity.activity.title == activity.title) {
            activityFound = true;
          }
        }
      }
      if (activityFound) {
        inUseCount++;
      } else {
        notInUseCount++;
      }
    }

    return {inUse: inUseCount, notInUse: notInUseCount};
  }

  List<Chain> getChainsUsingThisActivity(Activity activity) {
    List<Chain> chainsUsingThisActivity = [];

    for (Chain chain in chains) {
      for (ChainActivity chainActivity in chain.activities) {
        if (chainActivity.activity.title == activity.title) {
          chainsUsingThisActivity.add(chain);
        }
      }
    }

    return chainsUsingThisActivity;
  }

  Future<void> removeActivity(Activity activity) async {
    activities.removeWhere((act) => act.title == activity.title);
    notifyListeners();
  }

  Future<void> updateActivity(Activity activity) async {
    activity.lastUpdatedAt = DateTime.now();
    notifyListeners();
  }

  Future<void> rearrangeChains(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var itemAtOldIndex = chains.removeAt(oldIndex);
    chains.insert(newIndex, itemAtOldIndex);

    notifyListeners();
  }

  Future<void> rearrangeActivites(
    Chain chain,
    int oldIndex,
    int newIndex,
  ) async {
    // if (oldIndex == newIndex) {
    //   return;
    // }

    if (oldIndex > newIndex) {
      newIndex += 1;
    }

    if (chain.activities[newIndex].activity.title == systemWaitActivityTitle ||
        chain.activities[newIndex].activity.title ==
            systemStartActivityInTitle) {
      if (oldIndex > newIndex) {
        newIndex += 1;
      } else {
        newIndex -= 1;
      }
    }

    if (oldIndex < newIndex) {
      ChainActivity tempActivity = chain.activities[oldIndex];
      for (int i = oldIndex; i < newIndex; i += 2) {
        chain.activities[i] = chain.activities[i + 2];
      }
      chain.activities[newIndex] = tempActivity;
    } else {
      ChainActivity tempActivity = chain.activities[oldIndex];
      for (int i = oldIndex; i > newIndex; i -= 2) {
        chain.activities[i] = chain.activities[i - 2];
      }
      chain.activities[newIndex] = tempActivity;
    }

    // if (chain.activities[newIndex].activity.title ==
    //     systemWaitActivityTitle) {
    //   if (oldIndex > newIndex) {
    //     newIndex += 1;
    //   } else {
    //     newIndex -= 1;
    //   }
    // }

    // if (chain.activities[oldIndex].activity.title ==
    //     systemWaitActivityTitle) {
    //   if (oldIndex > newIndex) {
    //     oldIndex -= 1;
    //   } else {
    //     oldIndex += 1;
    //   }
    // }

    // var itemAtOldIndex = chain.activities.removeAt(oldIndex);
    // chain.activities.insert(newIndex, itemAtOldIndex);

    await updateActivityIndex(chain);
    chain.lastUpdatedAt = DateTime.now();
    await updateChain(chain);
    notifyListeners();
  }

  //helper function
  Future<void> updateActivityIndex(Chain chain) async {
    int dbIndex = 0;
    for (ChainActivity chainActivity in chain.activities) {
      // if (chainActivity.activity.title == systemWaitActivityTitle) {
      //   continue;
      // }
      chainActivity.index = dbIndex;
      dbIndex += 1;
    }
  }

  //helper function
  bool allActivitiesDone(Chain chain) {
    bool allDone = true;
    for (int i = 0; i < chain.activities.length; i++) {
      if (chain.activities[i].endedAt != null ||
          chain.activities[i].isInterrupted == false) {
        allDone = false;
        break;
      }
    }
    //chain.activities = [];
    return allDone;
  }

  //helper function
  String getFormattedTimeBySetting(String catClockMode) {
    String time = "";
    switch (catClockMode) {
      case "HH:MM:SS":
        time = DateFormat('kk:mm:ss').format(DateTime.now());
        break;
      case "HH:MM":
        time = DateFormat('kk:mm').format(DateTime.now());
        break;
      case "AM/PM":
        time = DateFormat.jm().format(DateTime.now());
        break;
    }
    return time;
  }

  bool nameExistInMemory(String title) {
    int foundChainAtIndex = chains.indexWhere((chain) => chain.title == title);
    return foundChainAtIndex != -1;
  }

  String getValidTitle(String titleProposed) {
    String validTitle = titleProposed;
    int suffixNumber = 0;
    bool nameExist = nameExistInMemory(validTitle);
    while (nameExist) {
      suffixNumber++;
      validTitle = "${titleProposed}_$suffixNumber";
      nameExist = nameExistInMemory(validTitle);
    }
    return validTitle;
  }

  Future<void> flipDoneActivity(
    Chain chain,
    ChainActivity chainActivity,
  ) async {
    chainActivity.activityDone = !chainActivity.activityDone;
    if (chainActivity.endedAt == null) {
      chainActivity.endedAt = DateTime.now();
      chainActivity.activityDurationLeft = null;
    } else {
      chainActivity.endedAt = null;
    }

    notifyListeners();
  }

  Future<void> flipDoneRestAfterActivity(
    Chain chain,
    ChainActivity chainActivity,
  ) async {
    chainActivity.isInterrupted = !chainActivity.isInterrupted;
    if (chainActivity.endedAt == null) {
      chainActivity.endedAt = DateTime.now();
    } else {
      chainActivity.endedAt = null;
    }

    notifyListeners();
  }

  DateTime? getDateValueFromDB(int? dateColumnValue) {
    if (dateColumnValue != null && dateColumnValue != -1) {
      return DateTime.fromMillisecondsSinceEpoch(dateColumnValue);
    } else {
      return null;
    }
  }

  List<Chain> getChainsByFilters(
    String filter,
    bool showFavorites,
    bool showRunning,
  ) {
    List<Chain> resultWithPredefinedFilters = showFavorites || showRunning
        ? chains
            .where(
              (chain) =>
                  (showFavorites && chain.pinned == true) ||
                  (showRunning && chain.chainStatus == statusExecuting),
            )
            .toList()
        : chains;

    List<Chain> resultWithTitleFilter = (filter.isNotEmpty && filter != '')
        ? resultWithPredefinedFilters
            .where(
              (chain) =>
                  filter.isNotEmpty &&
                  filter != '' &&
                  (chain.title.toLowerCase().contains(
                            filter.toString().toLowerCase(),
                          ) ||
                      chain.activities.indexWhere(
                            (act) => act.activity.title
                                .toLowerCase()
                                .contains(filter.toString().toLowerCase()),
                          ) !=
                          -1),
            )
            .toList()
        : resultWithPredefinedFilters;
    return resultWithTitleFilter;
  }

  List<Activity> getActivitiesByFilters(
    String filter,
    bool showWithImage,
    bool showWithoutImage,
    bool showInUse,
    bool showNotInUse,
  ) {
    List<Activity> userDefinedActivities = activities
        .where((activity) => activity.type == waitActivityInDB)
        .toList();
    List<Activity> resultWithPredefinedFilters = showWithImage ||
            showWithoutImage ||
            showInUse ||
            showNotInUse
        ? userDefinedActivities
            .where(
              (activity) =>
                  (showWithImage &&
                      activity.specification != null &&
                      activity.specification![activitySpecImagePath] != null) ||
                  (showWithoutImage &&
                      (activity.specification == null ||
                          activity.specification![activitySpecImagePath] ==
                              null ||
                          activity.specification![activitySpecImagePath] ==
                              "")) ||
                  (showInUse &&
                      getChainsUsingThisActivity(activity).isNotEmpty) ||
                  (showNotInUse &&
                      getChainsUsingThisActivity(activity).isEmpty),
            )
            .toList()
        : userDefinedActivities;
    List<Activity> resultWithTitleFilter = (filter.isNotEmpty && filter != '')
        ? resultWithPredefinedFilters
            .where(
              (activity) =>
                  filter.isNotEmpty &&
                  filter != '' &&
                  activity.title.toLowerCase().contains(
                        filter.toString().toLowerCase(),
                      ),
            )
            .toList()
        : resultWithPredefinedFilters;
    // notifyListeners();
    return resultWithTitleFilter;
  }

  bool chainHasLocalReferences(Chain chain) {
    for (ChainActivity chainActivity in chain.activities) {
      if (chainActivity.activity.specification != null) {
        dynamic image =
            chainActivity.activity.specification![activitySpecImagePath];
        if (image != null) {
          if (image.toString().startsWith("/data")) {
            return true;
          }
        }
      }
    }
    return false;
  }

  Future<String> downloadChain(Chain chain) async {
    try {
      File chainFile = File('${chain.title}.json');
      await chainFile.writeAsString(jsonEncode(chain));
      return "${chain.title}.json is saved under Downloads";
    } on Exception {
      return "Cannot download the Chain on this Platform. Try sharing the chain instead.";
    }
  }

  Future<String> downloadJsonFile(Chain chain) async {
    String fileName = '${chain.title}.json';
    // Step 1: Convert the Chain object to a JSON string.
    final jsonString = jsonEncode(chain);

    // Step 2: Create a blob from the JSON string.
    // The 'Blob' is a file-like object of immutable raw data.
    final blob = Blob([jsonString]);

    // Step 3: Create a URL for the blob.
    final url = Url.createObjectUrlFromBlob(blob);

    // Step 4: Create a temporary anchor element to trigger the download.
    final anchor = document.createElement('a') as AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = fileName;

    // Step 5: Append the anchor to the body, click it, and then remove it.
    document.body!.children.add(anchor);
    anchor.click();
    document.body!.children.remove(anchor);

    // Step 6: Revoke the object URL to free up resources.
    Url.revokeObjectUrl(url);

    return "${chain.title}.json is saved under Downloads";
  }

  Future<void> shareChain(Chain chain) async {
    File chainFile = File('${chain.title}.json');
    await chainFile.writeAsString(jsonEncode(chain));
    await SharePlus.instance.share(
      ShareParams(files: [XFile('${chain.title}.json')], text: chain.title),
    );
    await chainFile.delete();
  }

  Future<bool> okToDownloadWithoutLocalImageRef(BuildContext ctx) async {
    return await showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          content: const Text(
            "This Chain is referring to local Images/GIFs which cannot be shared.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                "It's Fine, share without Local Images/GIFs.",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                "Ok, don't share!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String> checkAndDownloadChain(BuildContext ctx, Chain chain) async {
    bool doChainHasLocalReferences = chainHasLocalReferences(chain);
    String downloadResponse = "";
    if (doChainHasLocalReferences) {
      bool proceedToDownloadChain = await okToDownloadWithoutLocalImageRef(ctx);
      if (proceedToDownloadChain) {
        downloadResponse = await downloadChain(chain);
      }
    } else {
      downloadResponse = await downloadChain(chain);
    }
    return downloadResponse;
  }

  Future<void> checkAndShareChain(BuildContext ctx, Chain chain) async {
    ScaffoldMessengerState scms = ScaffoldMessenger.of(ctx);
    ThemeData theme = Theme.of(context);
    try {
      bool doChainHasLocalReferences = chainHasLocalReferences(chain);
      bool proceedToShareChain = doChainHasLocalReferences
          ? await okToDownloadWithoutLocalImageRef(ctx)
          : true;
      // if (doChainHasLocalReferences) {
      //   proceedToShareChain = await okToDownloadWithoutLocalImageRef(ctx);
      // } else {}
      if (proceedToShareChain) {
        await shareChain(chain);
      } else {
        throw "Unable to share this chain!!\nTry to Download it from Chain's detailed view & share the downloaded file.";
      }
    } catch (e) {
      scms.showSnackBar(
        SnackBar(
          content: Text(
            //e.toString(),
            "Unable to share this chain!!\nTry to Download it from Chain's detailed view & share the downloaded file.",
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            //textColor: Colors.white,
            label: 'OK',
            onPressed: () {},
          ),
        ),
      );
    }
  }

  Future<Chain?> uploadChain(String fileString) async {
    Chain? chain;
    try {
      Map<String, dynamic> jsonData = jsonDecode(fileString);

      if (jsonData['title'] != null && jsonData['activities'] != null) {
        chain = Chain.fromJson(jsonData);

        chain.title = getValidTitle(chain.title);
      } else {
        chain = null;
        // Navigator.of(context).pushReplacementNamed("");
      }
    } catch (e) {
      chain = null;
    }
    return chain;
  }

  Future<void> renameChain(String oldChainTitle, String newChainTitle) async {
    notifyListeners();
  }

  Future<void> updateChainActivityByActivityId(
    Chain chain,
    ChainActivity chainActivity,
  ) async {
    notifyListeners();
  }
}
