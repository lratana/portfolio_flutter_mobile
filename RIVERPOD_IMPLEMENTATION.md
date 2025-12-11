# Riverpod State Management Implementation

## Overview

This project now uses **Riverpod** (River + Provider) for state management - a modern, compile-safe, and testable alternative to Provider.

## What is Riverpod?

Riverpod is a reactive caching and data-binding framework that:

- ✅ **Compile-safe** - Catches errors at compile-time, not runtime
- ✅ **No BuildContext** - Access providers anywhere without context
- ✅ **Testable** - Easy to test and mock
- ✅ **No ProviderNotFoundException** - Type-safe provider access
- ✅ **Better DevTools** - Enhanced debugging experience

## Architecture Changes

### 1. **Added Riverpod Package** (`pubspec.yaml`)

```yaml
dependencies:
  flutter_riverpod: ^2.6.1
```

### 2. **Created Riverpod Provider** (`lib/providers/portfolio_provider.dart`)

**PortfolioState Class:**

- Immutable state class holding data, loading, and error states
- Includes convenient getters for all portfolio sections
- `copyWith()` method for immutable updates

**PortfolioNotifier Class:**

- Extends `StateNotifier<PortfolioState>`
- Manages all state transitions
- Provides CRUD operations
- Automatically loads data on initialization

**portfolioProvider:**

- `StateNotifierProvider` that exposes the notifier and state
- Single source of truth for portfolio data

### 3. **Updated Main App** (`lib/main.dart`)

```dart
void main() {
  runApp(
    const ProviderScope(  // Root of Riverpod
      child: MyApp(),
    ),
  );
}
```

### 4. **Updated Homepage** (`lib/home/homepage.dart`)

- Changed from `StatelessWidget` to `ConsumerWidget`
- Uses `ref.watch(portfolioProvider)` to listen to state
- Uses `ref.read(portfolioProvider.notifier)` to call methods

### 5. **Updated Section Widgets**

All section widgets now use:

```dart
final container = ProviderScope.containerOf(context);
container.read(portfolioProvider.notifier).deleteWorkItem(id);
```

## Key Concepts

### State vs Notifier

**State (`PortfolioState`):**

- Immutable data class
- Read-only access via `ref.watch()`
- UI rebuilds when state changes

**Notifier (`PortfolioNotifier`):**

- Manages state transitions
- Methods to update state
- Access via `ref.read(portfolioProvider.notifier)`

### ConsumerWidget vs Consumer

**ConsumerWidget:**

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portfolioProvider);
    return Text(state.hero?.name ?? '');
  }
}
```

**Consumer (for StatefulWidgets):**

```dart
Consumer(
  builder: (context, ref, child) {
    final state = ref.watch(portfolioProvider);
    return Text(state.hero?.name ?? '');
  },
)
```

## Provider Access Patterns

### 1. Watch (Rebuild on Changes)

```dart
final state = ref.watch(portfolioProvider);
// Widget rebuilds when state changes
```

### 2. Read (No Rebuild)

```dart
ref.read(portfolioProvider.notifier).deleteWorkItem(id);
// Call methods without triggering rebuild
```

### 3. Listen (Side Effects)

```dart
ref.listen(portfolioProvider, (previous, next) {
  if (next.hasError) {
    showSnackBar(next.errorMessage);
  }
});
```

## Benefits Over Provider

| Feature                | Provider          | Riverpod               |
| ---------------------- | ----------------- | ---------------------- |
| **Compile Safety**     | ❌ Runtime errors | ✅ Compile-time errors |
| **BuildContext**       | ✅ Required       | ✅ Optional            |
| **Testing**            | 😐 Needs setup    | ✅ Very easy           |
| **Error Messages**     | 😐 Generic        | ✅ Specific            |
| **DevTools**           | ✅ Good           | ✅ Excellent           |
| **Multiple Instances** | ❌ Difficult      | ✅ Easy                |
| **Scoping**            | 😐 Manual         | ✅ Automatic           |

## State Flow

```
App Starts
  ↓
ProviderScope created
  ↓
portfolioProvider initialized
  ↓
PortfolioNotifier() constructor runs
  ↓
loadPortfolioData() called automatically
  ↓
State updates to loading (isLoading: true)
  ↓
Data loaded from JSON
  ↓
State updates with data (isLoading: false)
  ↓
UI (ConsumerWidget) rebuilds automatically
  ↓
User performs CRUD operation
  ↓
ref.read(portfolioProvider.notifier).deleteItem()
  ↓
Service updates and emits stream event
  ↓
Notifier receives update, sets new state
  ↓
UI rebuilds automatically
```

## Code Examples

### Reading State

```dart
class PortfolioHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioState = ref.watch(portfolioProvider);

    if (portfolioState.isLoading) {
      return LoadingWidget();
    }

    return Text(portfolioState.hero?.name ?? 'No name');
  }
}
```

### Calling Methods

```dart
onPressed: () {
  ref.read(portfolioProvider.notifier).deleteWorkItem(workId);
}
```

### Accessing Without BuildContext

```dart
final container = ProviderScope.containerOf(context);
container.read(portfolioProvider.notifier).updateHero(newHero);
```

## Testing

Riverpod makes testing much easier:

```dart
test('Delete work item test', () {
  final container = ProviderContainer();

  // Access state
  final state = container.read(portfolioProvider);
  expect(state.isLoading, false);

  // Call methods
  container.read(portfolioProvider.notifier).deleteWorkItem('work-1');

  // Verify state changes
  final newState = container.read(portfolioProvider);
  expect(newState.works?.items.length, lessThan(state.works?.items.length ?? 0));

  container.dispose();
});
```

## Advanced Features

### 1. **Select (Optimized Rebuilds)**

```dart
// Only rebuild when hero name changes
final heroName = ref.watch(
  portfolioProvider.select((state) => state.hero?.name),
);
```

### 2. **Family (Parameterized Providers)**

```dart
final workItemProvider = Provider.family<WorkItem?, String>((ref, id) {
  final state = ref.watch(portfolioProvider);
  return state.works?.items.firstWhere((w) => w.id == id);
});

// Usage
final work = ref.watch(workItemProvider('work-1'));
```

### 3. **AutoDispose (Automatic Cleanup)**

```dart
final portfolioProvider = StateNotifierProvider.autoDispose<
  PortfolioNotifier, PortfolioState
>((ref) => PortfolioNotifier());
```

### 4. **keepAlive (Prevent Disposal)**

```dart
ref.keepAlive(); // Provider stays alive even when not watched
```

## File Structure

```
lib/
├── main.dart                           # ProviderScope root
├── providers/
│   └── portfolio_provider.dart         # State, Notifier, Provider
├── services/
│   └── portfolio_service.dart          # Data operations
├── models/
│   └── portfolio_models.dart           # Data models
├── home/
│   └── homepage.dart                   # ConsumerWidget
└── sections/
    ├── education_section.dart          # Uses ProviderScope.containerOf
    ├── experience_section.dart         # Uses ProviderScope.containerOf
    └── works_section.dart              # Uses ProviderScope.containerOf
```

## Migration Guide (Provider → Riverpod)

| Provider                  | Riverpod                       |
| ------------------------- | ------------------------------ |
| `ChangeNotifierProvider`  | `StateNotifierProvider`        |
| `Consumer`                | `Consumer` or `ConsumerWidget` |
| `context.watch()`         | `ref.watch()`                  |
| `context.read()`          | `ref.read()`                   |
| `Provider.of<T>(context)` | `ref.read(provider)`           |
| `notifyListeners()`       | `state = newState`             |

## Common Patterns

### Loading State

```dart
if (portfolioState.isLoading) {
  return CircularProgressIndicator();
}
```

### Error State

```dart
if (portfolioState.hasError) {
  return ErrorWidget(portfolioState.errorMessage);
}
```

### Empty State

```dart
if (!portfolioState.hasData) {
  return EmptyWidget();
}
```

### Success State

```dart
return ListView(
  children: portfolioState.works?.items.map((work) =>
    WorkCard(work: work)
  ).toList() ?? [],
);
```

## Best Practices

✅ **Use ConsumerWidget** - For stateless widgets that need providers
✅ **Use Consumer** - For specific parts of StatefulWidgets
✅ **Use ref.watch()** - When you want rebuilds
✅ **Use ref.read()** - For callbacks/event handlers
✅ **Use select()** - To optimize rebuilds
✅ **Use family** - For parameterized providers
✅ **Keep state immutable** - Use copyWith() for updates
✅ **Avoid long rebuild chains** - Use select() to limit scope

## Debugging

### Riverpod DevTools

- Inspect all providers
- See current state values
- Track state changes
- Monitor rebuild performance

### Enable Logging

```dart
void main() {
  runApp(
    ProviderScope(
      observers: [LoggerObserver()],
      child: MyApp(),
    ),
  );
}

class LoggerObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('[${provider.name ?? provider.runtimeType}] $newValue');
  }
}
```

## Resources

- [Riverpod Documentation](https://riverpod.dev)
- [Riverpod vs Provider](https://riverpod.dev/docs/from_provider/motivation)
- [Migration Guide](https://riverpod.dev/docs/from_provider/quickstart)
- [Examples](https://github.com/rrousselGit/riverpod/tree/master/examples)

## Summary

✅ **Migrated from Provider to Riverpod**
✅ **Compile-safe state management**
✅ **No BuildContext dependency**
✅ **Better testing capabilities**
✅ **Enhanced developer experience**
✅ **Production-ready architecture**

Riverpod provides a more robust, scalable, and maintainable state management solution!
