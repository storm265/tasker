import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo2/database/database_scheme/env_scheme.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/access_token_mixin.dart';
import 'package:todo2/presentation/providers/file_provider.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class ProfileController extends ChangeNotifier with AccessTokenMixin {
  final SecureStorageSource _secureStorageService;
  final FileProvider fileProvider;
  final UserProfileRepositoryImpl userProfileRepository;
  final AuthRepositoryImpl authRepository;
  final TaskRepository _taskRepository;
  final NoteRepository _notesRepository;
  ProfileController({
    required this.fileProvider,
    required NoteRepository notesRepository,
    required SecureStorageSource secureStorageService,
    required TaskRepository taskRepository,
    required this.userProfileRepository,
    required this.authRepository,
  })  : _secureStorageService = secureStorageService,
        _notesRepository = notesRepository,
        _taskRepository = taskRepository;

  late String username = '';
  late Map<String, String> imageHeader = {};
  final imageUrl = ValueNotifier<String>('');
  late String email = '';
  late AnimationController iconAnimationController;

  // ignore: prefer_final_fields
  List<TaskModel> _tasks = [];
  int _eventsLength = 0;
  int _todoLength = 0;
  int _quickNotesLength = 0;
  List<int> cardLength = [0, 0, 0];

  Future<void> clearImage() async {
    final url = await _secureStorageService.getUserData(
            type: StorageDataType.avatarUrl) ??
        '';
    await CachedNetworkImage.evictFromCache(url);
    imageCache.clearLiveImages();
    imageCache.clear();
    imageUrl.value = url;
    imageUrl.notifyListeners();
  }

  Future<void> fetchProfileInfo() async {
    imageUrl.value =
        '${dotenv.env[EnvScheme.apiUrl]}/users-avatar/${await getAvatarLink()}';
    imageUrl.notifyListeners();
    imageHeader = await getAccessHeader(_secureStorageService);

    email =
        await _secureStorageService.getUserData(type: StorageDataType.email) ??
            '';
    username = await _secureStorageService.getUserData(
            type: StorageDataType.username) ??
        '';
  }

  Future<String> getAvatarLink() async {
    String avatarLink = await _secureStorageService.getUserData(
          type: StorageDataType.id,
        ) ??
        '';
    return avatarLink;
  }

  void rotateSettingsIcon({required TickerProvider ticker}) {
    iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: ticker,
    )..repeat();
  }

  Future<void> changeLocalization(BuildContext context) async {
    context.locale.toString().contains('ru')
        ? await context.setLocale(const Locale('en'))
        : await context.setLocale(const Locale('ru'));
    MessageService.displaySnackbar(
      context: context,
      message: LocaleKeys.please_restart_app.tr(),
    );
  }

  Future<void> signOut({required BuildContext context}) async {
    await _secureStorageService.removeAllUserData();
    await authRepository
        .signOut()
        .then((_) => NavigationService.navigateTo(context, Pages.welcome));
  }

  Future<void> fetchCardsData() async {
    await _fetchTasks();
    await _fetchQuickNotes();
    _findEventsLength();
    _findToDoLength();
    _findNotesLength();
    cardLength.removeRange(0, 3);
  }

  Future<void> _fetchTasks() async {
    final list1 = await _taskRepository.fetchUserTasks();
    final list2 = await _taskRepository.fetchAssignedToTasks();
    final list3 = await _taskRepository.fetchParticipateInTasks();
    for (var i = 0; i < list1.length; i++) {
      _tasks.add(list1[i]);
    }
    for (var i = 0; i < list2.length; i++) {
      _tasks.add(list2[i]);
    }
    for (var i = 0; i < list2.length; i++) {
      _tasks.add(list3[i]);
    }
  }

  Future<void> _fetchQuickNotes() async {
    final notes = await _notesRepository.fetchUserNotes();
    for (var i = 0; i < notes.length; i++) {
      if (notes[i].isCompleted) {
        _quickNotesLength++;
      }
    }
  }

  void _findEventsLength() {
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].isCompleted) {
        _eventsLength++;
      }
    }
    cardLength.add(_eventsLength);
  }

  void _findToDoLength() {
    for (var i = 0; i < _tasks.length; i++) {
      if (!_tasks[i].isCompleted) {
        _todoLength++;
      }
    }
    cardLength.add(_todoLength);
  }

  void _findNotesLength() {
    for (var i = 0; i < _tasks.length; i++) {
      if (_tasks[i].isCompleted) {
        _quickNotesLength++;
      }
    }
    cardLength.add(_quickNotesLength);
  }
}
