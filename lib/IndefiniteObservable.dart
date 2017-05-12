typedef void Disconnect();
abstract class Observer<T> {
  void next(T value);
}

class Subscription {
  Subscription(Disconnect) {
    this.disconnect = Disconnect;
  }

  unsubscribe() {
    disconnect();
    disconnect = null;
  }

  Disconnect disconnect;
}

class IndefiniteObservable <O extends Observer> {
  IndefiniteObservable(Disconnect connect(O o)) {
    this.connect = connect;
  }

  Subscription subscribe(Observer o) {
    return new Subscription(connect(o));
  }
  Function connect;
}