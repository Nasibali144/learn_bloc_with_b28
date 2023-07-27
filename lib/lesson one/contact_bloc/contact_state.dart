part of 'contact_cubit.dart';

@freezed
sealed class ContactState with _$ContactState {
  const factory ContactState.initial({@Default(<Contact>[]) List<Contact> contacts}) = InitialContactState;
  const factory ContactState.loading({@Default(<Contact>[]) List<Contact> contacts}) = LoadingContactState;
  const factory ContactState.loaded({required List<Contact> contacts}) = LoadedContactState;
  const factory ContactState.error({@Default(<Contact>[]) List<Contact> contacts, required String message}) = ErrorContactState;
}