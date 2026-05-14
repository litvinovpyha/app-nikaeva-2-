// Generic events
abstract class GenericEvent<T> {}

class LoadItems<T> extends GenericEvent<T> {}

class CreateItem<T> extends GenericEvent<T> {
  final T item;
  CreateItem(this.item);
}

class UpdateItem<T> extends GenericEvent<T> {
  final T item;
  final String id;
  UpdateItem(this.item, this.id);
}

class DeleteItem<T> extends GenericEvent<T> {
  final String id;
  DeleteItem(this.id);
}

class LoadItemById<T> extends GenericEvent<T> {
  final String id;
  LoadItemById(this.id);
}

class LoadItemsByLineId<T> extends GenericEvent<T> {
  final String lineId;

  LoadItemsByLineId(this.lineId);
}

class SearchItems<T> extends GenericEvent<T> {
  final String query;
  SearchItems(this.query);
}

class LoadItemsByDate<T> extends GenericEvent<T> {
  final DateTime date;

  LoadItemsByDate(this.date);
}
