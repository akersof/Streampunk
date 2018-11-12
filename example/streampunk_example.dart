import 'package:streampunk/streampunk.dart';

class Counter {
  int _counter;
  Counter([this._counter = 0]);
  int get count => _counter;
  void increment([int inc = 1]) => ++_counter;
  void decrement([int dec = -1]) => increment(dec);
}


main() {
  final bloc = Bloc(state: Counter());
  bloc.addInput("increment", InputController<int>());
  bloc.addOutput("count", OutputController<int>());
  bloc.getInput("increment").add(10);

}
