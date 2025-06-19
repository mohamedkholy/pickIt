// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pickit/features/login/data/repos/login_repo.dart' as _i977;
import 'package:pickit/features/login/logic/login_cubit.dart' as _i1053;
import 'package:pickit/features/profile/logic/profile_cubit.dart' as _i1052;
import 'package:pickit/features/sign_up/data/repos/sign_up_repo.dart' as _i35;
import 'package:pickit/features/sign_up/logic/sign_up_cubit.dart' as _i1004;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i977.LoginRepo>(() => _i977.LoginRepo());
    gh.factory<_i1052.ProfileCubit>(() => _i1052.ProfileCubit());
    gh.factory<_i35.SignUpRepo>(() => _i35.SignUpRepo());
    gh.factory<_i1053.LoginCubit>(
      () => _i1053.LoginCubit(gh<_i977.LoginRepo>()),
    );
    gh.factory<_i1004.SignUpCubit>(
      () => _i1004.SignUpCubit(gh<_i35.SignUpRepo>()),
    );
    return this;
  }
}
