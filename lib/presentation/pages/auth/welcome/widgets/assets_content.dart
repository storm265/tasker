mixin AssetsContent {
  final assetsPath = 'assets/start_page/avatars/';
}

// add const
class Walkthrough1 with AssetsContent {
  final String avatarsTitle = 'first';
  final String titleText = 'Welcome to todo list';
  final String subText = 'Whats going to happen tomorrow?';
}

class Walkthrough2 with AssetsContent {
  final String avatarsTitle = 'second';
  final String titleText = 'Work happens';
  final String subText = 'Get notified when work happens.';
}

class Walkthrough3 with AssetsContent {
  final String avatarsTitle = 'third';
  final String titleText = 'Tasks and assign';
  final String subText = 'Task and assign them to colleagues.';
}
