import "package:test/test.dart";
import "../lib/IndefiniteObservable.dart";

class ValueObserver<T> extends Observer<T> {
  Function n;
  ValueObserver(void n(T t)) {
    this.n = n;
  }
  @override
  void next(T value) {
    n(value);
  }
}

class ValueObservable<T> extends IndefiniteObservable<ValueObserver<T>> {
  ValueObservable(Disconnect connect(ValueObserver<T> m)) : super(connect);
}

void main() {
  test("Test observer", () {
  	var value = 56.1;
    var mo = new ValueObservable<double>((o) {
	    o.next(value);
	    return () {};
  	});
	  var s = mo.subscribe(new ValueObserver<double>((o) {
	    expect(o, value);
	  }));
	  s.unsubscribe();
  });
}