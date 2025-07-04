import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';
import 'package:pickit/core/widgets/my_button.dart';
import 'package:pickit/core/widgets/my_dropdown.dart';
import 'package:pickit/core/widgets/my_text_form_field.dart';
import 'package:pickit/core/widgets/not_signed_in_widget.dart';
import 'package:pickit/features/post_item/data/models/item.dart';
import 'package:pickit/features/post_item/data/models/user.dart';
import 'package:pickit/features/post_item/logic/post_item_cubit.dart';
import 'package:pickit/features/post_item/logic/post_item_state.dart';
import 'package:pickit/features/post_item/ui/widgets/add_photos_layout.dart';
import 'package:pickit/features/post_item/ui/widgets/city_autocomplete.dart';
import 'package:pickit/features/post_item/ui/widgets/item_image.dart';

class PostItemScreen extends StatefulWidget {
  const PostItemScreen({super.key});

  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final List<String> _photos = [];
  late final PostItemCubit _postItemCubit = context.read<PostItemCubit>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    _postItemCubit.checkUserLoggedIn();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post an Item",
          style: MyTextStyles(context).font18BlackBold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocConsumer<PostItemCubit, PostItemState>(
            listener: (context, state) {
              if (state is PostItemSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Item posted successfully")),
                );
                _titleController.clear();
                _priceController.clear();
                _descriptionController.clear();
                _categoryController.clear();
                _photos.clear();
                setState(() {});
                Navigator.pop(context);
              }
              if (state is PostItemError) {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is PostItemLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (context) => PopScope(
                        canPop: false,

                        child: Center(
                          child: CircularProgressIndicator(
                            color: MyColors(context).primaryColor,
                          ),
                        ),
                      ),
                );
              }
            },
            builder: (context, state) {
              if (state is UserNotLoggedIn) {
                return const Center(child: NotSignedInWidget());
              }
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextFormField(
                        hint: "What are you seeling",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Title is required";
                          }
                          if (value.length < 5) {
                            return "Title must be at least 5 characters";
                          }
                          if (value.length > 100) {
                            return "Title must be less than 100 characters";
                          }
                          return null;
                        },
                        controller: _titleController,
                      ),
                      SizedBox(height: 24),
                      MyTextFormField(
                        hint: "Price",
                        controller: _priceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Price is required";
                          }
                          if (double.parse(value) < 10) {
                            return "Price must be at least 10";
                          }
                          if (double.parse(value) > 1000000000) {
                            return "Price must be less than 1000000000";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      SizedBox(height: 24),
                      MyDropdown(
                        controller: _categoryController,
                        items: const [
                          "Furniture",
                          "Electronics",
                          "Clothing",
                          "Books",
                          "Properties",
                          "Toys",
                        ],
                      ),
                      SizedBox(height: 24),
                      CityAutocomplete(controller: _cityController),
                      SizedBox(height: 24),
                      MyTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Description is required";
                          }
                          if (value.length < 20) {
                            return "Description must be at least 20 characters";
                          }
                          if (value.length > 1000) {
                            return "Description must be less than 1000 characters";
                          }
                          return null;
                        },
                        hint: "Description",
                        controller: _descriptionController,
                        maxLines: 5,
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Photos",
                        style: MyTextStyles(context).font22BlackBold,
                      ),
                      SizedBox(height: 24),
                      if (_photos.isEmpty)
                        AddPhotosLayout(
                          onAddButtonPressed: (photos) {
                            addPhotos(photos);
                          },
                        ),
                      if (_photos.isNotEmpty)
                        Wrap(
                          children: [
                            for (var photo in _photos)
                              ItemImage(
                                photo: photo,
                                onDelete: (photo) {
                                  setState(() {
                                    _photos.remove(photo);
                                  });
                                },
                              ),
                            GestureDetector(
                              onTap: () {
                                _imagePicker.pickMultiImage(limit: 5).then((
                                  value,
                                ) {
                                  addPhotos(value.map((e) => e.path).toList());
                                });
                              },
                              child: Container(
                                width: 100,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: MyColors(context).secondaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 24),
                      MyButton(
                        minWidth: double.infinity,
                        onPressed: () {
                          if (_photos.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please add at least one photo"),
                              ),
                            );
                            return;
                          }
                          if (_categoryController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select a category"),
                              ),
                            );
                            return;
                          }
                          if (_cityController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select a city"),
                              ),
                            );
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            _postItemCubit.postItem(
                              Item(
                                id: "1",
                                title: _titleController.text,
                                price: double.parse(_priceController.text),
                                category: _categoryController.text,
                                description: _descriptionController.text,
                                photos: _photos,
                                seller: User(
                                  userId: _postItemCubit.getUserID(),
                                  userName: _postItemCubit.getUserName(),
                                  userImageUrl:
                                      _postItemCubit.getUserImageUrl(),
                                ),
                                city: _cityController.text,
                              ),
                            );
                          }
                        },
                        text: "Post Item",
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void addPhotos(List<String> photos) {
    setState(() {
      for (var i = 0; i < photos.length; i++) {
        if (_photos.length == 5) {
          _photos[i] = photos[i];
        } else {
          _photos.add(photos[i]);
        }
      }
    });
  }
}
