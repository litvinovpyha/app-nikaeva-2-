// Generic states
abstract class GenericState<T> {}

class ItemsInitial<T> extends GenericState<T> {}

class ItemsLoading<T> extends GenericState<T> {}

class ItemsLoaded<T> extends GenericState<T> {
  final List<T> items;
  ItemsLoaded(this.items);
}

class ItemsError<T> extends GenericState<T> {
  final String message;
  ItemsError(this.message);
}
