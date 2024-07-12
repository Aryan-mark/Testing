// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo_project/home/home.dart';
import 'package:riverpod_demo_project/provider/providers.dart';

void main() {
  //ProviderScope it store all providers and provider state
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Riverpod Example',
      //home: StateProviderPage(),
      home: FutureProviderScreen(),
      //home: StreamProviderScreen(),
      // home: StateNotifierProviderScreen(),
      // home: ChangeNotifierProviderScreen(),
    );
  }
}

//ConsumerWidget when you have to access any provider than you have to wrap CosumerWidget
//And it gives one more additional parameter in buid
// '' Widget build(BuildContext context, WidgetRef ref) ''
// with ref we access any provider in our widget class. And this properties also and with this
// ref.watch: Reads the current state of the provider.
// ref.read: Modifies the state of the provider.

class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Riverpod Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //In Riverpod, the .notifier property is used to access the provider's underlying notifier object.
        //This is particularly useful when you need to perform state updates or call methods on the notifier, rather than simply reading the state.
        //When to Use .notifier
        //Updating State: When you want to update the state of a Provider, you access the notifier to modify the state.
        //Calling Methods on Notifier: If you're using more advanced state management with StateNotifier or ChangeNotifier,
        // you'll need to access the notifier to call its methods.

        onPressed: () => ref.read(counterProvider.notifier).state++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use ref.watch to get the AsyncValue from the dataProvider
    final asyncValue = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter FutureProvider Example'),
      ),
      body: Center(
        child: asyncValue.when(
          data: (data) =>
              Center(child: Text(data, style: const TextStyle(fontSize: 24))),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use ref.watch to get the AsyncValue from the counterStreamProvider
    final asyncValue = ref.watch(counterStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter StreamProvider Example'),
      ),
      body: Center(
        child: asyncValue.when(
          data: (count) => Center(
            child: Text(
              'Counter: $count',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error: $err'),
        ),
      ),
    );
  }
}

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter StateNotifier Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () =>
                      ref.read(counterNotifierProvider.notifier).decrement(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () =>
                      ref.read(counterNotifierProvider.notifier).increment(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeNotifierProviderScreen extends ConsumerWidget {
  const ChangeNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterNotifier = ref.watch(counterChangeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ChangeNotifier Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counterNotifier.count}',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => ref
                      .read(counterChangeNotifierProvider.notifier)
                      .decrement(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => ref
                      .read(counterChangeNotifierProvider.notifier)
                      .increment(),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                },
                child: const Text("Navigate"))
          ],
        ),
      ),
    );
  }
}
