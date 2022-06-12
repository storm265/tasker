import 'package:flutter/material.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_glow_single_child_scroll_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/color_pallete_widget.dart';

Future<void> showMaterialDialog(BuildContext context) async {
  int _selectedIndex = 0;
  final _titleController = TextEditingController();
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text(
        'Title',
        style: TextStyle(fontWeight: FontWeight.w300),
      ),
      content: DisabledGlowScrollView(
        child: SizedBox(
          height: 230,
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _titleController,
                ),
              ),
              const SizedBox(height: 70),
              const Padding(
                padding: EdgeInsets.only(right: 220, bottom: 20),
                child: Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
              ColorPalleteWidget(selectedIndex: _selectedIndex)
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (_titleController.text.length >= 2) {
              await ProjectRepositoryImpl()
                  .putData(
                      color: colors[_selectedIndex].value.toString(),
                      title: _titleController.text)
                  .then((_) => Navigator.of(context).pop());
            }
          },
          child: const Text('Add Project'),
        )
      ],
    ),
  );
}
