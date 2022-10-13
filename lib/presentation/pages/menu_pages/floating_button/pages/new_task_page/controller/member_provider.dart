import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';


class MemberProvider extends ChangeNotifier {
  final taskMembers = ValueNotifier<Set<UserProfileModel>>({});

  void fillMembers(List<UserProfileModel>? list) {
    if (list != null) {
      for (var i = 0; i < list.length; i++) {
        taskMembers.value.add(list[i]);
      }
      taskMembers.notifyListeners();
    }
  }

  void addMember({required UserProfileModel userModel}) {
    taskMembers.value.add(userModel);
    taskMembers.notifyListeners();
  }

  void removeMember({required UserProfileModel model}) {
    taskMembers.value.removeWhere((element) => element.id == model.id);
    taskMembers.notifyListeners();
  }

  void clearMemberList() {
    taskMembers.value.clear();
    taskMembers.notifyListeners();
  }
}
