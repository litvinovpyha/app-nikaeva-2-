import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/core/repository/generic_api_reposotory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenericBloc<T> extends Bloc<GenericEvent<T>, GenericState<T>> {
  final GenericApiRepository<T> repository;

  GenericBloc({required this.repository}) : super(ItemsInitial<T>()) {
    Future<void> _reloadItems(Emitter<GenericState<T>> emit) async {
      final items = await repository.getAll();
      emit(ItemsLoaded<T>(items));
    }

    void _handleError(Object e, Emitter<GenericState<T>> emit) {
      if (e is Exception)
        emit(ItemsError<T>(e.toString()));
      else
        emit(ItemsError<T>('Неизвестная ошибка: $e'));
    }

    // LOAD items
    on<LoadItems<T>>((event, emit) async {
      emit(ItemsLoading<T>());
      try {
        await _reloadItems(emit);
      } catch (e) {
        _handleError(e, emit);
      }
    });

    on<LoadItemsByDate<T>>((event, emit) async {
      emit(ItemsLoading<T>());
      try {
        final item = await repository.getByDate(event.date);
        emit(ItemsLoaded<T>(item));
      } catch (e) {
        _handleError(e, emit);
      }
    });

    // load item by id
    on<LoadItemById<T>>((event, emit) async {
      emit(ItemsLoading<T>());
      try {
        final item = await repository.get(event.id); // твой метод get по id
        if (item == null) {
          emit(ItemsError<T>('Элемент не найден'));
        } else {
          // кладём в список, чтобы GenericState остался совместим
          emit(ItemsLoaded<T>([item]));
        }
      } catch (e) {
        _handleError(e, emit);
      }
    });

    // CREATE
    on<CreateItem<T>>((event, emit) async {
      emit(ItemsLoading<T>());
      try {
        await repository.create(event.item);
        await _reloadItems(emit);
      } catch (e) {
        _handleError(e, emit);
      }
    });

    // UPDATE
    on<UpdateItem<T>>((event, emit) async {
      emit(ItemsLoading<T>());
      try {
        await repository.update(event.item, event.id);
        await _reloadItems(emit);
      } catch (e) {
        _handleError(e, emit);
      }
    });

    // DELETE
    on<DeleteItem<T>>((event, emit) async {
      emit(ItemsLoading<T>());
      try {
        await repository.delete(event.id);
        await _reloadItems(emit);
      } catch (e) {
        _handleError(e, emit);
      }
    });
    on<SearchItems<T>>((event, emit) async {
      emit(ItemsLoading<T>());

      try {
        final result = await repository.search(event.query);
        emit(ItemsLoaded<T>(result));
      } catch (e) {
        emit(ItemsError<T>(e.toString()));
      }
    });
  }
}
