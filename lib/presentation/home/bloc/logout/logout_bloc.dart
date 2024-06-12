// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:possapp/data/datasources/auth_remote_datasource.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDataSource _authRemoteDataSource;
  LogoutBloc(
    this._authRemoteDataSource,
  ) : super(const _Initial()) {
    on<LogoutEvent>((event, emit) async {
      emit(const LogoutState.loading());
      final result = await _authRemoteDataSource.logout();
      result.fold(
        (l) => emit(LogoutState.error(l)),
        (r) => emit(LogoutState.success()),
      );
    });
  }
}
