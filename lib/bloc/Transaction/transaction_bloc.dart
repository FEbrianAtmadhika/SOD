import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sod_new/models/addtransactionmodel.dart';
import 'package:sod_new/models/transactionmodel.dart';
import 'package:sod_new/services/transactionservice.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) async {
      if (event is TransactionGetAll) {
        try {
          emit(TransactionLoading());

          List<TransactionModel> res =
              await TransactionService().getAllTransaction();

          emit(TransactionSuccess(res));
        } catch (e) {
          emit(TransactionFailed(e.toString()));
        }
      }
      if (event is AddTransaction) {
        try {
          emit(TransactionLoading());

          await TransactionService().addTransaction(event.data);
          emit(AddTransactionSuccess());
        } catch (e) {
          emit(TransactionFailed(e.toString()));
        }
      }

      if (event is CancelTransaction) {
        try {
          emit(TransactionLoading());

          List<TransactionModel> res = await TransactionService()
              .cancelTransaction(event.data, event.id);
          emit(CancelTransactionSucccess());
          emit(TransactionSuccess(res));
        } catch (e) {
          emit(CancelTransactionFailed(e.toString()));
          emit(TransactionSuccess(event.data));
        }
      }
    });
  }
}
