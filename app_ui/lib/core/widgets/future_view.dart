import 'package:flutter/material.dart';

/// Loads data once (in initState) and renders loading / error / data states.
/// Swap for Bloc / Riverpod later without touching the domain layer.
class FutureView<T> extends StatefulWidget {
  final Future<T> Function() load;
  final Widget Function(BuildContext context, T data) builder;
  const FutureView({super.key, required this.load, required this.builder});

  @override
  State<FutureView<T>> createState() => _FutureViewState<T>();
}

class _FutureViewState<T> extends State<FutureView<T>> {
  late final Future<T> _future = widget.load();

  @override
  Widget build(BuildContext context) => FutureBuilder<T>(
        future: _future,
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text('Something went wrong\n${snap.error}'));
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator(color: AppColors.coral));
          }
          return widget.builder(context, snap.data as T);
        },
      );
}
