import 'package:flutter/material.dart';
import 'package:learn_bloc_with_b28/lesson%20four/counters/counter_sbloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const LessonFourApp());
}

class LessonFourApp extends StatelessWidget {
  const LessonFourApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterSblocBloc>(
      create: (context) => CounterSblocBloc(),
      child: MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        home: const HomeCS(),
      ),
    );
  }
}

class HomeCS extends StatelessWidget {
  const HomeCS({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterSblocBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("CounterS")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// A
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<CounterSblocBloc, CounterSblocState>(
                bloc: bloc,
                builder: (context, state) {
                  return Text(
                      "A: CounterA: ${state.countA} \nCounterB: ${state.countB}\nCounterC: ${state.countC}\nCounterD: ${state.countD}",
                      style: Theme.of(context).textTheme.headlineMedium);
                },
              ),
              IconButton(
                  onPressed: () => bloc.add(CountAIncrementEvent()),
                  icon: const Icon(Icons.add)),
            ],
          ),

          /// B
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocSelector<CounterSblocBloc, CounterSblocState, int>(
                selector: (state) {
                  return state.countB;
                },
                bloc: bloc,
                builder: (context, countB) {
                  return Text(
                      "B: CounterA: ${bloc.state.countA} \nCounterB: $countB\nCounterC: ${bloc.state.countC}\nCounterD: ${bloc.state.countD}",
                      style: Theme.of(context).textTheme.headlineMedium);
                },
              ),
              IconButton(
                  onPressed: () => bloc.add(CountBIncrementEvent()),
                  icon: const Icon(Icons.add)),
            ],
          ),

          /// C
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<CounterSblocBloc, CounterSblocState>(
                bloc: bloc,
                builder: (context, state) {
                  return Text(
                      "A: CounterA: ${state.countA} \nCounterB: ${state.countB}\nCounterC: ${state.countC}\nCounterD: ${state.countD}",
                      style: Theme.of(context).textTheme.headlineMedium);
                },
              ),
              IconButton(
                  onPressed: () => bloc.add(CountBIncrementEvent()),
                  icon: const Icon(Icons.add)),
            ],
          ),

          /// D
          DStatePage(),
        ],
      ),
    );
  }
}

class DStatePage extends StatelessWidget {
  DStatePage({Key? key}) : super(key: key);

  final bloc = CounterSblocBloc();
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocBuilder<CounterSblocBloc, CounterSblocState>(
            bloc: bloc,
            builder: (context, state) {
              return Text(
                  "A: CounterA: ${state.countA} \nCounterB: ${state.countB}\nCounterC: ${state.countC}\nCounterD: ${state.countD}",
                  style: Theme.of(context).textTheme.headlineMedium);
            },
          ),
          IconButton(
              onPressed: () => bloc.add(CountBIncrementEvent()),
              icon: const Icon(Icons.add)),
        ],
      );
  }
}

