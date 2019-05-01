Future<void> main() async {
  print('Waiting for a day!');
  await Future.delayed(const Duration(days: 1));
}
