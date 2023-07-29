part of 'counter_sbloc_bloc.dart';

abstract class CounterSblocEvent extends Equatable {
  const CounterSblocEvent();
  @override
  List<Object?> get props => [];
}

class CountAIncrementEvent extends CounterSblocEvent {}
class CountBIncrementEvent extends CounterSblocEvent {}
class CountCIncrementEvent extends CounterSblocEvent {}
class CountDIncrementEvent extends CounterSblocEvent {}
