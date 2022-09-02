// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:todo2/database/database_scheme/comments_scheme.dart';

// import 'package:todo2/services/error_service/error_service.dart';
// import 'package:todo2/services/supabase/constants.dart';

// abstract class CommentDataSource {
//   Future postComment({required String content});
// }

// class CommentDataSourceImpl implements CommentDataSource {
//   final String _table = 'comment';
//   final _supabase = NetworkSource();

//   @override
//   Future<Response<dynamic>> postComment(
//       {required String content}) async {
//     try {
//       final response = await _supabase.from(_table).insert({
//         CommentScheme.content: content,
//         CommentScheme.ownerId: _supabase.auth.currentUser!.id,
//         CommentScheme.createdAt: DateTime.now().toString(),
//       }).execute();
//       return response;
//     } catch (e) {
//       ErrorService.printError(
//           'Error in CommentDataSourceImpl putComment() :$e');
//       rethrow;
//     }
//   }
// }
