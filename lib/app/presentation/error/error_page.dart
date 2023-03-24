import '../../../export.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => AppRoutes.router.pop(),
          child: const Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: true,
        title: const Text('ERROR'),
      ),
      body: const Center(
        child: Text('Error page'),
      ),
    );
  }
}
