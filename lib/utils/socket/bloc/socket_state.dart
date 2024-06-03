part of 'socket_bloc.dart';

@immutable
sealed class SocketState {}

final class SocketInitial extends SocketState {}

final class SocketConnected extends SocketState {}
