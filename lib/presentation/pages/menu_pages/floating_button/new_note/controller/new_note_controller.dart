import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class NewNoteController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final colorPalleteController = ColorPalleteController();
  final addNoteRepository = NoteRepositoryImpl();
  final isButtonClicked = ValueNotifier(true);

  Future<void> addNote({
    required BuildContext context,
    required String description,
  }) async {
    if (formKey.currentState!.validate()) {
      isButtonClicked.value = false;
      isButtonClicked.notifyListeners();
      await addNoteRepository
          .putNote(
            context: context,
            color:
                '${colors[colorPalleteController.selectedIndex.value].value}',
            description: description,
          )
          .then((value) => Navigator.pop(context));

      isButtonClicked.value = true;
      isButtonClicked.notifyListeners();
    }
  }
}
