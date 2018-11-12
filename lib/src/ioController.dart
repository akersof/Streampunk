import 'dart:async';
import "package:meta/meta.dart";
import 'package:rxdart/rxdart.dart';


typedef Callback<T> = void Function(T);

enum Direction {
  input,
  output,
  both,
}

abstract class IOController<T> {
  var _controller;
  Direction direction;
  Sink<T> get input => _controller.sink;
  get output;
  void close() => _controller.close();
}

///Input controller of our Bloc
class InputController<T> extends IOController<T> {
  final Callback onData;
  final _controller = StreamController<T>();
  final direction = Direction.input;
  InputController({@required this.onData}) {
    _controller.stream.listen(onData);
  }
  Stream<T> get output => _controller.stream;
}

///Output controller of our BLoc
class OutputController<T> extends IOController<T> {
  final _controller = BehaviorSubject<T>();
  final direction = Direction.output;
  ValueObservable<T> get output => _controller.stream;
}