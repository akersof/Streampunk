import 'package:meta/meta.dart';
import 'package:streampunk/src/ioController.dart';
import 'package:rxdart/rxdart.dart';

/// Our Business logic component, AKA BLoC.
class Bloc<T> {
  //state
  final T state;
  final _controllers = <String, IOController>{};

  //FIXME: do i need a name parameters for state? OK only if we can create our bloc in 1 definition, else we should not.
  //constructor
  Bloc({@required this.state});

  //input
  Sink<V> getInput<V>(String name) {
    if(!_controllers.containsKey(name))
      throw "Controller $name not registered.";
    if(_controllers[name].direction != Direction.input && _controllers[name].direction != Direction.both)
      throw "Controller $name is an OutputController. Can't get sink property";
    return _controllers[name].input;
  }

  void addInput<V>(String name, InputController<V> ctrl) {
    if(_controllers.containsKey(name))
      throw "Controller $name already exists. Delete $name first.";
    _controllers[name] = ctrl;
  }

  //output
  ValueObservable<V> getOutput<V>(String name) {
    if(!_controllers.containsKey(name))
      throw "Controller $name not registered.";
    if(_controllers[name].direction != Direction.output && _controllers[name].direction != Direction.both)
      throw "Controller $name is an InputController. Can't get a ValueObservable";
    return _controllers[name].output;
  }

  void addOutput<V>(String name, OutputController<V> ctrl) {
    if(_controllers.containsKey(name))
      throw "Controller $name already exists. Delete $name first.";
    _controllers[name] = ctrl;
  }

  ///close all our InputControllers and OutputControllers
  void dispose() {
    _controllers.forEach((name, controller) => controller.close());
  }



}