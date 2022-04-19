import 'package:chat_app/bloc/splash/splash_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashBloc>().add(
          CheckUserLoggedInOrNot(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(
        bloc: context.read<SplashBloc>(),
        builder: (context, state) {
          if (state.checking == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return state.isUSerLoggedIn == false
                ? const LoginScreen()
                : const MyHomePage();
          }
        },
      ),
    );
  }
}
