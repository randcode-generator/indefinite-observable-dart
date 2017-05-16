import 'dart:async';
import "../lib/IndefiniteObservable.dart";

class Point {
	Point(double x, double y)
		: this.x = x,
			this.y = y;

	String toString() {
		return "x: ${this.x}, y: ${this.y}";
	}

	double x;
	double y;
}

class MouseObserver<T> extends Observer<T> {
  Function n;
  MouseObserver(void n(T t)) {
    this.n = n;
  }
  @override
  void next(T value) {
    n(value);
  }
}

class MouseObservable<T> extends IndefiniteObservable<MouseObserver<T>> {
  MouseObservable(Disconnect connect(MouseObserver<T> m)) : super(connect);
}

void main() {
  var mo = new MouseObservable<Point>((o) {
    int x = 50.1;
    int y = 60.1;
    Timer timer = new Timer.periodic(const Duration(seconds:1), 
      (Timer t) {
        x += 0.1;
        y += 0.1;
        o.next(new Point(x, y));
    });
    
    return () {
      timer.cancel();
    };
	});
  var s = mo.subscribe(new MouseObserver<Point>((o) {
    print(o);
  }));

  new Timer(const Duration(seconds: 5), ()=> s.unsubscribe());
}