import 'package:todo2/database/database_scheme/comments_scheme.dart';

class CommentModel {
  final String content;
  final String ownerId;
  final String createdAt;

  CommentModel({
    required this.content,
    required this.createdAt,
    required this.ownerId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        content: json[CommentScheme.content],
        ownerId: json[CommentScheme.ownerId],
        createdAt: json[CommentScheme.createdAt],
      );
}
