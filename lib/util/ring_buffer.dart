class RingBuffer<T> {
  final int length;
  final T fill;
  final List<T?> _buffer;
  int _index = 0;
  int _count = 0;

  RingBuffer(this.fill, {required this.length}) : _buffer = List<T?>.filled(length, fill);

  void push(T item) {
    _buffer[_index] = item;
    _index = (_index + 1) % length;
    if (_count < length) _count++;
  }

  List<T> snapshot() {
    List<T> result = [];
    for (int i = 0; i < _count; i++) {
      int idx = (_index + i) % length;
      final item = _buffer[idx];
      if (item != null) result.add(item);
    }
    return result;
  }
}
