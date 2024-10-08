part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class AddTransactionSuccess extends TransactionState {}

class AddTransactionFailed extends TransactionState {
  final String e;

  const AddTransactionFailed(this.e);

  @override
  List<Object> get props => [e];
}

class TransactionFailed extends TransactionState {
  final String e;

  const TransactionFailed(this.e);

  @override
  List<Object> get props => [e];
}

class TransactionSuccess extends TransactionState {
  final List<TransactionModel> data;
  const TransactionSuccess(this.data);

  @override
  List<Object> get props => [
        data,
      ];
}

class CancelTransactionSucccess extends TransactionState {}

class CancelTransactionFailed extends TransactionState {
  final String e;

  const CancelTransactionFailed(this.e);

  @override
  List<Object> get props => [e];
}
