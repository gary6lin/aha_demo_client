extension IterableExt<T> on Iterable<T> {
  Iterable<T> superJoin({required T separator}) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return [];

    final list = [iterator.current];
    while (iterator.moveNext()) {
      list
        ..add(separator)
        ..add(iterator.current);
    }

    return list;
  }
}
