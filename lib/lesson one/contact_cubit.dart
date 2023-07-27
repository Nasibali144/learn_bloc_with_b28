import 'package:bloc/bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20one/network_service.dart';

import 'contact_model.dart';

class ContactState {
  final List<Contact> contacts;
  final StatesCubit cubitState;
  final String? message;

  const ContactState._(
      {this.contacts = const [],
      this.cubitState = StatesCubit.initial,
      this.message});

  factory ContactState.initial({List<Contact> contacts = const []}) =>
      ContactState._(contacts: contacts, cubitState: StatesCubit.initial);

  factory ContactState.loading({required List<Contact> contacts}) =>
      ContactState._(contacts: contacts, cubitState: StatesCubit.loading);

  factory ContactState.error({required String message, List<Contact> contacts = const []}) =>
      ContactState._(message: message, contacts: contacts, cubitState: StatesCubit.error);

  factory ContactState.loaded({required List<Contact> contacts}) =>
      ContactState._(contacts: contacts, cubitState: StatesCubit.loaded);

  /*ContactState copyWith({
    List<Contact>? contacts,
    StatesCubit? cubitState,
    String? message,
  }) =>
      ContactState._(
        contacts: contacts ?? this.contacts,
        cubitState: cubitState ?? this.cubitState,
        message: message ?? this.message,
      );*/
}

enum StatesCubit {
  initial,
  loading,
  loaded,
  error,
}

/// cubit
class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactState.initial());

  void addContact() {}

  void readContact() async {
    emit(ContactState.loading(contacts: state.contacts));
    final json = await Network.methodGet(api: Network.apiContacts);
    if (json != null) {
      final list = Network.parseContact(json);
      emit(ContactState.loaded(contacts: list));
    } else {
      emit( ContactState.error(message: "Something Error", contacts: state.contacts));
    }
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
