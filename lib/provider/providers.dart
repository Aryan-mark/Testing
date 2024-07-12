import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

//Riverpod Topic
// Riverpod is use beacuse it solved the problem that come in Provider Like
//1.Provider Not Found Exception.
//2. widget tree problem in SS.
// Simple Provider = Read Only Provider
// StateProvider
// Future Provider
// Stream Provider
// StateNotifierProvider
// ChangeNotifierProvider

// Define a provider that manages an integer state (the counter)
// 1}  StateProvider example
//In StateProvider state can change and read both . It use only when simple state work(boolean , enum , Strings and Number)
final counterProvider = StateProvider<int>((ref) => 0);

//------------------------------------------##---------------------------------------------------------------------------------
// 2} Future Provider = It use only for asynchronus code like when data comes in Future like Api calling or Network Request
// Simulate a network call with a Future
// Define a FutureProvider that uses fetchData
final dataProvider = FutureProvider<String>((ref) async {
  return fetchData();
});

Future<String> fetchData() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Hello from the Future!';
}
//------------------------------------------##---------------------------------------------------------------------------------

// 3} Stream Provider = Similar like Future Provider but this for Streams not Future . It use in Firebase or Web Sockets
// .Or Rebuild Another provider every few seconds

final counterStreamProvider = StreamProvider<int>((ref) {
  return counterStream();
});

Stream<int> counterStream() async* {
  int count = 0;
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield count++;
  }
}

//------------------------------------------##---------------------------------------------------------------------------------

//StateNotifier is a powerful way to manage state in Riverpod. It provides more control and
//flexibility over state management compared to simple providers like StateProvider.

//4} StateNotifierProvider example
final counterNotifierProvider = StateNotifierProvider<Counter, int>(
  (ref) {
    return Counter();
  },
);

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

//------------------------------------------##---------------------------------------------------------------------------------

//
//5} ChangeNotifierProvider example
final counterChangeNotifierProvider =
    ChangeNotifierProvider<CounterNotifier>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

//------------------------------------------##---------------------------------------------------------------------------------

//autoDispose modifier in Riverpod helps to clean up resources
// when the provider is no longer needed, which is useful for managing memory and avoiding leaks.
//It reset state when you leave you screen.

//final autoDisposeCounterProvider = StateProvider.autoDispose<int>((ref) => 0);
