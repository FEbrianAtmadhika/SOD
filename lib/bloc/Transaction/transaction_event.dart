part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionGetAll extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final AddTransactionModel data;

  const AddTransaction(this.data);

  @override
  List<Object> get props => [data];
}

class CancelTransaction extends TransactionEvent {
  final List<TransactionModel> data;
  final int id;

  const CancelTransaction(this.data, this.id);
  @override
  List<Object> get props => [data, id];
}
