import 'package:flutter/material.dart';

import '../../data/model/user.dart';

class SortUsers {
  Map<String, dynamic> initUsersList(
    List users,
    List currentUserInterests,
    Map<dynamic, int> sharedInterestsMap,
    String genderType,
  ) {
    // * remove users that dont match search criteria
    List<dynamic> usersCopy = List.from(users); // copy _users to fix index bug

    for (var i = 0; i < usersCopy.length; i++) {
      // remove users that dont match gender criteria
      if (genderType.toLowerCase() != 'any' &&
          usersCopy[i]['gender'].toString() != genderType.toLowerCase()) {
        users.remove(usersCopy[i]);
      }
    }

    // * sort _users by common interests
    Map<dynamic, int> tempSharedInterestsMap = {}; // <uid, shared interests>

    List sortedUsers = [];

    for (var i = 0; i < users.length; i++) {
      // make sure interests & travel goals is a list
      if (users[i][UserData.interests] == null) {
        users[i][UserData.interests] = [];
      }
      if (users[i][UserData.travelgoals] == null) {
        users[i][UserData.travelgoals] = [];
      }

      List interestsAndGoals =
          users[i][UserData.interests] + users[i][UserData.travelgoals];
      debugPrint("User ${users[i]['name']} interests: $interestsAndGoals");

      // Calculate the number of shared interests
      int sharedInterests = 0;

      for (String interest in interestsAndGoals) {
        if (currentUserInterests.contains(interest)) {
          sharedInterests++;
        }
      }
      debugPrint(users[i]['name'] + " shared interests: $sharedInterests");

      tempSharedInterestsMap[users[i] /*['uid']*/] = sharedInterests;
    }

    // * sort sharedInterestsMap by value (sharedInterests)
    tempSharedInterestsMap = Map.fromEntries(
        tempSharedInterestsMap.entries.toList()
          ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    debugPrint("sharedInterestsMap: $tempSharedInterestsMap");

    // Convert the map to a list containing the keys (sorted users)
    sortedUsers = tempSharedInterestsMap.keys.toList();
    debugPrint("sortedUsers list: $sortedUsers");

    if (sortedUsers.isNotEmpty) {
      users = sortedUsers; // * returns correct output
    }

    // copy the sorted map to the sharedInterestsMap
    sharedInterestsMap = Map.from(tempSharedInterestsMap);

    // ! return relevent data
    return {
      'users': users,
      'sharedInterestsMap': sharedInterestsMap,
    };
  }
}
