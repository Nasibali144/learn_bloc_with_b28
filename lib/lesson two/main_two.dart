import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter App"),),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {
              bloc.add(DecrementCounterEvent());
            }, icon: const Icon(Icons.remove), style: Theme.of(context).iconButtonTheme.style,),
            StreamBuilder<int>(
              initialData: bloc.state,
              stream: bloc.stream,
              builder: (context, snapshot) {
                return Text(bloc.state.toString(), style: Theme.of(context).textTheme.headlineMedium,);
              }
            ),
            IconButton(onPressed: () {
              bloc.add(IncrementCounterEvent());
            }, icon: const Icon(Icons.add), style: Theme.of(context).iconButtonTheme.style,),
          ],
        ),
      ),
    );
  }
}

///     <= State           request =>
/// UI              Bloc              Data
///       Event =>         <= response
sealed class CounterEvent {}
final class IncrementCounterEvent extends CounterEvent {}
final class DecrementCounterEvent extends CounterEvent {}



class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementCounterEvent>((event, emit) => emit(state + 1));
    on<DecrementCounterEvent>((event, emit) => emit(state - 1));
  }
}
