import 'package:dio/dio.dart';


import 'package:todo2/services/error_service/error_service.dart';

import 'package:todo2/services/network_service/network_config.dart';

abstract class CheckListsDataSource {
  Future putCheckList({
    required String title,
    required String color,
  });
  Future fetchCheckId({required String title});
  Future fetchCheckList();
}

class CheckListsDataSourceImpl extends CheckListsDataSource {
  final _table = 'checklists';
  final _supabase = NetworkSource().networkApiClient;
  @override
  Future<Response<dynamic>> putCheckList({
    required String title,
    required String color,
  }) async {
    try {
      // final response = await _supabase.from(_table).insert({
      //   CheckListsScheme.title: title,
      //   CheckListsScheme.color: color,
      //   CheckListsScheme.ownerId: _supabase.auth.currentUser!.id,
      //   CheckListsScheme.createdAt: DateTime.now().toString(),
      // }).execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
       throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> fetchCheckList() async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select()
      //     .eq(CheckListsScheme.ownerId, _supabase.auth.currentUser!.id)
      //     .execute();
      // return response;
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
     throw Failure(e.toString());
    }
  }

  @override
  Future<int> fetchCheckId({required String title}) async {
    try {
      // final response = await _supabase
      //     .from(_table)
      //     .select(CheckListsScheme.id)
      //     .eq(CheckListsScheme.ownerId, _supabase.auth.currentUser!.id)
      //     .eq(CheckListsScheme.title, title)
      //     .execute();
      // return response.data[0][CheckListsScheme.id];
      return Future.delayed(Duration(seconds: 1));
    } catch (e) {
       throw Failure(e.toString());
    }
  }
}
