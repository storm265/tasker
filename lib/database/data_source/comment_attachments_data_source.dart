// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:todo2/database/database_scheme/comment_attachment_scheme.dart';
// import 'package:todo2/services/error_service/error_service.dart';
// import 'package:todo2/services/supabase/constants.dart';

// abstract class CommentAttachmentDataSource {
//   Future putCommentAttachment({
//     required String commentId,
//     required String url,
//   });
//   // Future fetchCommentAttachment();
// }

// class CommentAttachmentDataSourceImpl implements CommentAttachmentDataSource {
//   final _table = 'comment_attachment';
//   final _supabase = NetworkSource().networkApiClient;

//   @override
//   Future<PostgrestResponse<dynamic>> putCommentAttachment({
//     required String commentId,
//     required String url,
//   }) async {
//     try {
//       final response = await _supabase.from(_table).insert({
//         CommentAttachmentScheme.commentId: commentId,
//         CommentAttachmentScheme.url: url,
//         CommentAttachmentScheme.createdAt: DateTime.now().toString(),
//       }).execute();
//       return response;
//     } catch (e) {
//       ErrorService.printError(
//           'Error in CommentAttachmentDataSourceImpl putCommentAttachment: $e');
//       rethrow;
//     }
//   }

//   @override
//   Future<PostgrestResponse<dynamic>> fetchCommentAttachment() async {
//     try {
//       final response = await _supabase
//           .from(_table)
//           .select(
//               '${CheckListItemsScheme.content},${CheckListItemsScheme.isCompleted},${CheckListItemsScheme.checklistId}')
//           .eq(CheckListItemsScheme.ownerId, _supabase.auth.currentUser!.id)
//           .execute();
//       return response;
//     } catch (e) {
//       ErrorService.printError('Error in data source fetchChecklistItem: $e');
//       rethrow;
//     }
//   }
// }
