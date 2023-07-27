part of 'contact_cubit.dart';

class ContactState {
  final List<Contact> contacts;
  final StatesCubit cubitState;
  final String? message;

  const ContactState(
      {this.contacts = const [],
        this.cubitState = StatesCubit.initial,
        this.message});

  /*factory ContactState.initial({List<Contact> contacts = const []}) =>
      ContactState._(contacts: contacts, cubitState: StatesCubit.initial);

  factory ContactState.loading({required List<Contact> contacts}) =>
      ContactState._(contacts: contacts, cubitState: StatesCubit.loading);

  factory ContactState.error({required String message, List<Contact> contacts = const []}) =>
      ContactState._(message: message, contacts: contacts, cubitState: StatesCubit.error);

  factory ContactState.loaded({required List<Contact> contacts}) =>
      ContactState._(contacts: contacts, cubitState: StatesCubit.loaded);*/

  ContactState copyWith({
    List<Contact>? contacts,
    StatesCubit? cubitState,
    String? message,
  }) =>
      ContactState(
        contacts: contacts ?? this.contacts,
        cubitState: cubitState ?? this.cubitState,
        message: message ?? this.message,
      );
}

enum StatesCubit {
  initial,
  loading,
  loaded,
  error,
}