import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/inherited_navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class NewNoteController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final colorPalleteController = ColorPalleteController();
  final addNoteRepository = NoteRepositoryImpl();
  final isButtonClicked = ValueNotifier(true);

  Future<void> addNote(
      {required BuildContext context, required String description}) async {
    final _inheritedNavigatorConroller =
        InheritedNavigator.of(context)!.navigationController;

    if (formKey.currentState!.validate()) {
      isButtonClicked.value = false;
      isButtonClicked.notifyListeners();
      await addNoteRepository.putNote(
        color: '${colors[colorPalleteController.selectedIndex.value].value}',
        description: description,
      );
      await _inheritedNavigatorConroller.animateToPage(NavigationPages.tasks);

      isButtonClicked.value = true;
      isButtonClicked.notifyListeners();
    }
  }
}
