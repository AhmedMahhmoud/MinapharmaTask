import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmatask/features/Authentication/presentation/cubit/authentication_cubit.dart';
import 'package:pharmatask/features/Dashboard/Presentation/screens/dashboard_page.dart';
import 'package:pharmatask/features/Movies/Presentation/cubit/movies_cubit.dart';
import 'package:pharmatask/services/sembast_database/Auth/authentication_db.dart';
import 'Routes/app_routes.dart';
import 'dependency_injection/injection.dart' as di;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/Authentication/presentation/screens/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  getLastLoggedUser() async {
    AuthDao authDao = AuthDao();
    return await authDao.retrieveLastOpenedUser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (context) =>di.sl< MoviesCubit>()..getMovies(),
          child: Container(),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MaterialApp(
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
                future: getLastLoggedUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.white,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (snapshot.data == "") {
                      return SignUpPage();
                    } else if (snapshot.hasData) {
                      return DashboardPage(username: snapshot.data.toString());
                    }
                    return SignUpPage();
                  }
                }),
          );
        },
      ),
    );
  }
}
