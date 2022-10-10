import 'package:flutter/material.dart';

enum PanelStatus {
  showUserPanel,
  showProjectPanel,
  hide,
}

class PanelProvider extends ChangeNotifier {
  final isConfirmButtonActive = ValueNotifier<bool>(true);

  void changeConfirmButtonStatus(bool value) {
    isConfirmButtonActive.value = value;
    isConfirmButtonActive.notifyListeners();
  }

  final isShowPickUserWidget = ValueNotifier(false);

  final isShowProjectWidget = ValueNotifier(false);

  final panelStatus = ValueNotifier<PanelStatus>(PanelStatus.hide);

  void changePanelStatus({required PanelStatus newStatus}) {
    panelStatus.value = newStatus;
    panelStatus.notifyListeners();
  }
}
