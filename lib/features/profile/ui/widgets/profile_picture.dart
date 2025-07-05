import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickit/core/constants/assets.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/features/profile/logic/profile_cubit.dart';
import 'package:pickit/features/profile/logic/profile_state.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  late final cubit = context.read<ProfileCubit>();
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: IntrinsicWidth(
        child: Stack(
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is UploadingProfilePic) {
                  return CircleAvatar(
                    radius: 64,
                    backgroundColor: MyColors(context).primaryColorDark,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyColors(context).secondaryColor,
                      ),
                    ),
                  );
                }
                return cubit.getProfilePic() == null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(128),
                      child: Image.asset(
                        width: 128,
                        height: 128,
                        Assets.assetsImagesPngProfileAvatar,
                        fit: BoxFit.cover,
                      ),
                    )
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(128),
                      child: CachedNetworkImage(
                        imageUrl: cubit.getProfilePic()!,
                        width: 128,
                        height: 128,
                        fit: BoxFit.cover,
                      ),
                    );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    await cubit.uploadProfilePic(image.path);
                  }
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: MyColors(context).primaryColor,
                  // ignore: prefer_const_constructors
                  child: Icon(
                    Icons.edit,
                    color: MyColors(context).secondaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
