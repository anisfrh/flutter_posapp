import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:possapp/data/datasources/product_local_datasource.dart';
import 'package:possapp/presentation/orders/models/order_models.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const HistoryState.loading());
      final data = await ProductLocalDatasource.instance.getAllOrder();
      emit(HistoryState.success(data));
    });
  }
}
