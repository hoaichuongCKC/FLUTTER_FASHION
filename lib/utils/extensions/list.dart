extension ListX on List {
  double getCostOrder<T>() {
    return fold<double>(
      0,
      (previousValue, element) =>
          previousValue +
          (element.quantity *
              (element.product.regular_price! -
                  element.product.sale_price!.toInt())),
    );
  }

  int checkExistsId(List<int?> sortedList, int target) {
    int left = 0;
    int right = sortedList.length - 1;

    while (left <= right) {
      int mid = left + ((right - left) ~/ 2);

      if (sortedList[mid] == target) {
        return mid; // Trả về vị trí của target trong danh sách
      } else if (sortedList[mid]! < target) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    return -1; // Trả về -1 nếu không tìm thấy target trong danh sách
  }
}
