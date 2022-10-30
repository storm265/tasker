import 'package:get_it/get_it.dart';
import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/database/data_source/checklists_data_source.dart';
import 'package:todo2/database/data_source/notes_data_source.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/data_source/task_data_source.dart';
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/checklist_repository.dart';
import 'package:todo2/database/repository/notes_repository.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/task_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/database/scheme/notes/note_dao.dart';
import 'package:todo2/database/scheme/notes/note_database.dart';
import 'package:todo2/database/scheme/projects/project_dao.dart';
import 'package:todo2/database/scheme/projects/project_database.dart';
import 'package:todo2/database/scheme/tasks/task_dao.dart';
import 'package:todo2/database/scheme/tasks/task_database.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/form_validator_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_in_controller.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/sign_up_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/member_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/panel_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_validator.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/new_note_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/providers/color_pallete_provider/color_pallete_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/menu_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/providers/file_provider.dart';
import 'package:todo2/presentation/providers/user_provider.dart';
import 'package:todo2/services/cache_service/cache_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  final projectDao = ProjectDaoImpl(ProjectDatabase());
  final taskDao = TaskDaoImpl(TaskDatabase());
  final noteDao = NoteDaoImpl(NoteDatabase());

  getIt.registerFactory<FormValidatorController>(
    () => FormValidatorController(),
  );

  getIt.registerFactory<SignInController>(
    () => SignInController(
      userController: UserProvider(
        userProfileRepository: UserProfileRepositoryImpl(
          userProfileDataSource: UserProfileDataSourceImpl(
            network: NetworkSource(),
            secureStorageService: SecureStorageSource(),
          ),
        ),
      ),
      storageSource: SecureStorageSource(),
      authRepository: AuthRepositoryImpl(
        authDataSource: AuthDataSourceImpl(
          network: NetworkSource(),
          secureStorageService: SecureStorageSource(),
        ),
      ),
      formValidatorController: FormValidatorController(),
    ),
  );
  getIt.registerFactory<SignUpController>(
    () => SignUpController(
      authRepository: AuthRepositoryImpl(
        authDataSource: AuthDataSourceImpl(
          network: NetworkSource(),
          secureStorageService: SecureStorageSource(),
        ),
      ),
      fileController: FileProvider(),
      formValidatorController: FormValidatorController(),
      storageSource: SecureStorageSource(),
    ),
  );

  getIt.registerFactory<TaskRepositoryImpl>(
    () => TaskRepositoryImpl(
      inMemoryCache: InMemoryCache(),
      taskDao: taskDao,
      taskDataSource: TaskDataSourceImpl(
        network: NetworkSource(),
        secureStorage: SecureStorageSource(),
      ),
    ),
  );
  getIt.registerFactory<AddEditTaskController>(
    () => AddEditTaskController(
      memberProvider: MemberProvider(),
      projectController: ProjectController(
        colorPalleteProvider: ColorPalleteProvider(),
        projectsRepository: ProjectRepositoryImpl(
          inMemoryCache: InMemoryCache(),
          projectDao: projectDao,
          projectDataSource: ProjectUserDataImpl(
            secureStorageService: SecureStorageSource(),
            network: NetworkSource(),
          ),
        ),
      ),
      panelProvider: PanelProvider(),
      taskValidator: TaskValidator(),
      attachmentsProvider: AttachmentsProvider(
        fileProvider: FileProvider(),
        taskRepository: TaskRepositoryImpl(
          inMemoryCache: InMemoryCache(),
          taskDao: taskDao,
          taskDataSource: TaskDataSourceImpl(
            network: NetworkSource(),
            secureStorage: SecureStorageSource(),
          ),
        ),
      ),
      secureStorage: SecureStorageSource(),
      projectRepository: ProjectRepositoryImpl(
        inMemoryCache: InMemoryCache(),
        projectDao: projectDao,
        projectDataSource: ProjectUserDataImpl(
          secureStorageService: SecureStorageSource(),
          network: NetworkSource(),
        ),
      ),
      userRepository: UserProfileRepositoryImpl(
        userProfileDataSource: UserProfileDataSourceImpl(
          secureStorageService: SecureStorageSource(),
          network: NetworkSource(),
        ),
      ),
    ),
  );

  getIt.registerFactory<ViewTaskController>(
    () => ViewTaskController(
      memberProvider: MemberProvider(),
      taskRepository: TaskRepositoryImpl(
        inMemoryCache: InMemoryCache(),
        taskDao: taskDao,
        taskDataSource: TaskDataSourceImpl(
          network: NetworkSource(),
          secureStorage: SecureStorageSource(),
        ),
      ),
      projectRepository: ProjectRepositoryImpl(
        inMemoryCache: InMemoryCache(),
        projectDao: projectDao,
        projectDataSource: ProjectUserDataImpl(
          secureStorageService: SecureStorageSource(),
          network: NetworkSource(),
        ),
      ),
      userRepository: UserProfileRepositoryImpl(
        userProfileDataSource: UserProfileDataSourceImpl(
          secureStorageService: SecureStorageSource(),
          network: NetworkSource(),
        ),
      ),
      secureStorage: SecureStorageSource(),
      attachmentsProvider: AttachmentsProvider(
        taskRepository: TaskRepositoryImpl(
          inMemoryCache: InMemoryCache(),
          taskDao: taskDao,
          taskDataSource: TaskDataSourceImpl(
            network: NetworkSource(),
            secureStorage: SecureStorageSource(),
          ),
        ),
        fileProvider: FileProvider(),
      ),
    ),
  );

  getIt.registerSingleton<CheckListController>(
    CheckListController(
      checkListRepository: CheckListRepositoryImpl(
        checkListsDataSource: CheckListsDataSourceImpl(
          network: NetworkSource(),
          secureStorage: SecureStorageSource(),
        ),
      ),
    ),
  );

  getIt.registerSingleton<NewNoteController>(
    NewNoteController(
      addNoteRepository: NoteRepositoryImpl(
        noteDao: noteDao,
        inMemoryCache: InMemoryCache(),
        noteDataSource: NotesDataSourceImpl(
          network: NetworkSource(),
          secureStorage: SecureStorageSource(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => ProjectController(
      colorPalleteProvider: ColorPalleteProvider(),
      projectsRepository: ProjectRepositoryImpl(
        inMemoryCache: InMemoryCache(),
        projectDao: projectDao,
        projectDataSource: ProjectUserDataImpl(
          secureStorageService: SecureStorageSource(),
          network: NetworkSource(),
        ),
      ),
    ),
  );

  getIt.registerFactory<ProfileController>(
    () => ProfileController(
      taskRepository: TaskRepositoryImpl(
        inMemoryCache: InMemoryCache(),
        taskDao: taskDao,
        taskDataSource: TaskDataSourceImpl(
          network: NetworkSource(),
          secureStorage: SecureStorageSource(),
        ),
      ),
      notesRepository: NoteRepositoryImpl(
        noteDao: noteDao,
        inMemoryCache: InMemoryCache(),
        noteDataSource: NotesDataSourceImpl(
          network: NetworkSource(),
          secureStorage: SecureStorageSource(),
        ),
      ),
      fileProvider: FileProvider(),
      secureStorageService: SecureStorageSource(),
      userProfileRepository: UserProfileRepositoryImpl(
        userProfileDataSource: UserProfileDataSourceImpl(
          network: NetworkSource(),
          secureStorageService: SecureStorageSource(),
        ),
      ),
      authRepository: AuthRepositoryImpl(
        authDataSource: AuthDataSourceImpl(
          network: NetworkSource(),
          secureStorageService: SecureStorageSource(),
        ),
      ),
    ),
  );

  getIt.registerFactory<UserProvider>(
    () => UserProvider(
      userProfileRepository: UserProfileRepositoryImpl(
        userProfileDataSource: UserProfileDataSourceImpl(
          network: NetworkSource(),
          secureStorageService: SecureStorageSource(),
        ),
      ),
    ),
  );
}
