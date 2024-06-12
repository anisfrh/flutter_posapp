import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:possapp/data/models/response/product_response_model.dart';
import 'package:possapp/presentation/home/models/order_item.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  // jadi ketika awal checkout, data produk kosong, item atau quantity kosong dan total harga kosong
  CheckoutBloc() : super(const _Success([], 0, 0)) {
    on<_AddCheckout>((event, emit) {
      var currentStates = state as _Success;
      List<OrderItem> newCheckout = [...currentStates.product];
      emit(const _Loading());
      // ngecek apakah di state ada produk yang mau di checkout
      if (newCheckout.any((element) => element.product == event.product)) {
        var index = newCheckout
            .indexWhere((element) => element.product == event.product);
        newCheckout[index].quantity++;
      } else {
        newCheckout.add(OrderItem(product: event.product, quantity: 1));
      }

      int totalQuantity = 0;
      int totalPrice = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        totalPrice += element.quantity * element.product.price;
      }

      emit(_Success(newCheckout, totalQuantity, totalPrice));
    });

    // Untuk remove
    on<_RemoveCheckout>((event, emit) {
      var currentStates = state as _Success;
      List<OrderItem> newCheckout = [...currentStates.product];
      emit(const _Loading());
      if (newCheckout.any((element) => element.product == event.product)) {
        var index = newCheckout
            .indexWhere((element) => element.product == event.product);
        if (newCheckout[index].quantity > 1) {
          newCheckout[index].quantity--;
        } else {
          newCheckout.removeAt(index);
        }
      }

      int totalQuantity = 0;
      int totalPrice = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        totalPrice += element.quantity * element.product.price;
      }

      emit(_Success(newCheckout, totalQuantity, totalPrice));
    });

    on<_Started>((event, emit) { //started ini kalo kita udh selesai belanja, dia bakal ngulang kek dari awal
      emit(const _Loading());
      emit(const _Success([], 0, 0)); //produknya kosong, qty, price kembali ke semula
    });
  }
}
