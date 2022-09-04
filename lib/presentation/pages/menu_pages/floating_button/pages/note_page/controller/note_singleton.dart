import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/new_note_controller.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class NoteSingleton {
  static final NoteSingleton _instance = NoteSingleton._internal();

  factory NoteSingleton() {
    return _instance;
  }

  NoteSingleton._internal();

  final NewNoteController _noteController = NewNoteController(
    addNoteRepository: NoteRepositoryImpl(
      noteDataSource: NotesDataSourceImpl(
        network: NetworkSource(),
        secureStorage: SecureStorageSource(),
      ),
    ),
    colorPalleteController: ColorPalleteController(),
  );

  NewNoteController get controller => _noteController;
}
