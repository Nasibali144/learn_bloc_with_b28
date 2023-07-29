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
    return RepositoryProvider<InfoRepo>(
      create: (context) => InfoRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CounterSblocBloc>(
            create: (context) {
              final bloc = CounterSblocBloc();
              bloc.add(CountAIncrementEvent());
              return bloc;
            },
            lazy: false,
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.light(useMaterial3: true),
          home: const HomeCS(),
        ),
      ),
    );
  }
}

class HomeCS extends StatelessWidget {
  const HomeCS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterSblocBloc>(context);

    return BlocListener<CounterSblocBloc, CounterSblocState>(
      listener: (context, state) {
        if (state is CounterSblocLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text("Count B updated, current value is ${state.countB}")));
        }
      },
      listenWhen: (previous, current) {
        return previous.countB != current.countB;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("CounterS"),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const InfoPage())),
              icon: const Icon(Icons.info),
            ),
          ],
        ),
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
                    onPressed: () => bloc.add(CountCIncrementEvent()),
                    icon: const Icon(Icons.add)),
              ],
            ),

            /// D
            const DStatePage(),
          ],
        ),
      ),
    );
  }
}

class DStatePage extends StatelessWidget {
  const DStatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CounterSblocBloc>(context);
    return BlocConsumer<CounterSblocBloc, CounterSblocState>(
      bloc: bloc,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Count D updated, current value is ${state.countD}")));
      },
      listenWhen: (previous, current) {
        return previous.countD != current.countD;
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                "A: CounterA: ${state.countA} \nCounterB: ${state.countB}\nCounterC: ${state.countC}\nCounterD: ${state.countD}",
                style: Theme.of(context).textTheme.headlineMedium),
            IconButton(
                onPressed: () => bloc.add(CountDIncrementEvent()),
                icon: const Icon(Icons.add)),
          ],
        );
      },
    );
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final repo = context.read<InfoRepo>();
    final repo = RepositoryProvider.of<InfoRepo>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(repo.data["name"]!),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(repo.data["creator"]!),
              Text(repo.data["version"]!),
            ],
          ),
        ));
  }
}

class InfoRepo {
  final data = {
    "name": "Lesson Four",
    "creator": "B28 Group Students",
    "version": "1.0.0",
  };
}
