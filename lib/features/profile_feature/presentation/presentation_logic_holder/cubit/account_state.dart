part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class ContactUsLoading extends AccountState {
  @override
  List<Object> get props => [];
}
class UpdateProfileLoading extends AccountState {
  @override
  List<Object> get props => [];
}
class UpdatePasswordLoading extends AccountState {
  @override
  List<Object> get props => [];
}
class AccountVisiblePasswordState extends AccountState {
  final bool isVisible;
  const AccountVisiblePasswordState(this.isVisible);
  @override
  List<Object?> get props => [isVisible];
}
