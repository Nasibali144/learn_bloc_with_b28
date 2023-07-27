import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'contact_cubit.dart';

final contacts = ContactCubit();

void mainOne() {
  Bloc.observer = MyBlocObserver();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    contacts.readContact();
    return StreamBuilder<ContactState>(
      initialData: contacts.state,
      stream: contacts.stream,
      builder: (context, snapshot) {
        final state = snapshot.data!;

        return Scaffold(
          appBar: AppBar(title: const Text("Contacts"),),
          body: Stack(
            children: [
              if(state.cubitState != StatesCubit.error) ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];

                  return Card(
                    child: ListTile(
                      title: Text(contact.title),
                      subtitle: Text(contact.phone),
                    ),
                  );
                },
              ),

              if(state.cubitState == StatesCubit.loading) const Center(
                child: CircularProgressIndicator(),
              ),

              if(state.cubitState == StatesCubit.error) Center(
                child: Text(state.message!),
              ),
            ],
          ),
        );
      },
    );
  }
}




