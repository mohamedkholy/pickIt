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
import 'package:pickit/features/browse/data/repos/browse_repo.dart' as _i265;
import 'package:pickit/features/browse/logic/browse_cubit.dart' as _i398;
import 'package:pickit/features/chat/data/repos/chat_repo.dart' as _i296;
import 'package:pickit/features/chat/logic/chat_cubit.dart' as _i1000;
import 'package:pickit/features/chats/data/repos/chats_repo.dart' as _i548;
import 'package:pickit/features/chats/logic/chats_cubit.dart' as _i880;
import 'package:pickit/features/listings/data/repos/listings_repo.dart' as _i90;
import 'package:pickit/features/listings/logic/listings_cubit.dart' as _i451;
import 'package:pickit/features/login/data/repos/login_repo.dart' as _i977;
import 'package:pickit/features/login/logic/login_cubit.dart' as _i1053;
import 'package:pickit/features/main/logic/main_cubit.dart' as _i844;
import 'package:pickit/features/post_item/data/repos/post_item_repo.dart'
    as _i932;
import 'package:pickit/features/post_item/logic/post_item_cubit.dart' as _i56;
import 'package:pickit/features/profile/data/repos/profile_repo.dart' as _i244;
import 'package:pickit/features/profile/logic/profile_cubit.dart' as _i1052;
import 'package:pickit/features/search/data/repos/search_repo.dart' as _i161;
import 'package:pickit/features/search/logic/search_cubit.dart' as _i683;
import 'package:pickit/features/sign_up/data/repos/sign_up_repo.dart' as _i35;
import 'package:pickit/features/sign_up/logic/sign_up_cubit.dart' as _i1004;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i265.BrowseRepo>(() => _i265.BrowseRepo());
    gh.factory<_i296.ChatRepo>(() => _i296.ChatRepo());
    gh.factory<_i548.ChatsRepo>(() => _i548.ChatsRepo());
    gh.factory<_i977.LoginRepo>(() => _i977.LoginRepo());
    gh.factory<_i844.MainCubit>(() => _i844.MainCubit());
    gh.factory<_i932.PostItemRepo>(() => _i932.PostItemRepo());
    gh.factory<_i35.SignUpRepo>(() => _i35.SignUpRepo());
    gh.factory<_i90.ListingsRepo>(() => _i90.ListingsRepo());
    gh.factory<_i244.ProfileRepo>(() => _i244.ProfileRepo());
    gh.factory<_i161.SearchRepo>(() => _i161.SearchRepo());
    gh.factory<_i451.ListingsCubit>(
      () => _i451.ListingsCubit(gh<_i90.ListingsRepo>()),
    );
    gh.factory<_i398.BrowseCubit>(
      () => _i398.BrowseCubit(gh<_i265.BrowseRepo>()),
    );
    gh.factory<_i1000.ChatCubit>(() => _i1000.ChatCubit(gh<_i296.ChatRepo>()));
    gh.factory<_i683.SearchCubit>(
      () => _i683.SearchCubit(gh<_i161.SearchRepo>()),
    );
    gh.factory<_i880.ChatsCubit>(() => _i880.ChatsCubit(gh<_i548.ChatsRepo>()));
    gh.factory<_i1053.LoginCubit>(
      () => _i1053.LoginCubit(gh<_i977.LoginRepo>()),
    );
    gh.factory<_i1052.ProfileCubit>(
      () => _i1052.ProfileCubit(gh<_i244.ProfileRepo>()),
    );
    gh.factory<_i56.PostItemCubit>(
      () => _i56.PostItemCubit(gh<_i932.PostItemRepo>()),
    );
    gh.factory<_i1004.SignUpCubit>(
      () => _i1004.SignUpCubit(gh<_i35.SignUpRepo>()),
    );
    return this;
  }
}
