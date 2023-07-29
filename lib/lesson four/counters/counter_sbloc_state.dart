part of 'counter_sbloc_bloc.dart';

abstract class CounterSblocState extends Equatable {
  final int countA;
  final int countB;
  final int countC;
  final int countD;

  const CounterSblocState({
    required this.countA,
    required this.countB,
    required this.countC,
    required this.countD,
  });

  @override
  List<Object?> get props => [countA, countB, countC, countD];
}

class CounterSblocInitial extends CounterSblocState {
  const CounterSblocInitial({required super.countA, required super.countB, required super.countC, required super.countD});
}

class CounterSblocLoading extends CounterSblocState {
  const CounterSblocLoading({required super.countA, required super.countB, required super.countC, required super.countD});
}

class CounterSblocLoaded extends CounterSblocState {
  final String? message;
  const CounterSblocLoaded({required super.countA, required super.countB, required super.countC, required super.countD, this.message});
}

class CounterSblocError extends CounterSblocState {
  final String message;
  const CounterSblocError({required super.countA, required super.countB, required super.countC, required super.countD, required this.message});
}
