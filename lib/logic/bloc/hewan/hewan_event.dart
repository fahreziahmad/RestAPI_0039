import 'package:equatable/equatable.dart';

abstract class HewanEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchHewan extends HewanEvent {}

class CreateHewan extends HewanEvent {
  final Map<String, dynamic> data;
  CreateHewan(this.data);

  @override
  List<Object> get props => [data];
}
