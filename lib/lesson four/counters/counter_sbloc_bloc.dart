import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_sbloc_event.dart';
part 'counter_sbloc_state.dart';

class CounterSblocBloc extends Bloc<CounterSblocEvent, CounterSblocState> {
  CounterSblocBloc() : super(const CounterSblocInitial(countA: 0, countB: 0, countC: 0, countD: 0)) {
    on<CountAIncrementEvent>((event, emit) => emit(CounterSblocLoaded(countA: state.countA + 1, countB: state.countB, countC: state.countC, countD: state.countD)));
    on<CountBIncrementEvent>((event, emit) => emit(CounterSblocLoaded(countA: state.countA, countB: state.countB + 1, countC: state.countC, countD: state.countD)));
    on<CountCIncrementEvent>((event, emit) => emit(CounterSblocLoaded(countA: state.countA, countB: state.countB, countC: state.countC + 1, countD: state.countD)));
    on<CountDIncrementEvent>((event, emit) => emit(CounterSblocLoaded(countA: state.countA, countB: state.countB, countC: state.countC, countD: state.countD + 1)));
  }
}
