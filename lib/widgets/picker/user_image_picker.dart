import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File? file) imagerPickFn;
  const UserImagePicker({required this.imagerPickFn});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final _defaultImage=AssetImage('assets/images/cameraImagee.png');
  File? _pickedImage;

  Future<dynamic> getImageSource() {
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            alignment: Alignment.center,

            title: Text('How would you like to choose your profile image ?',textAlign: TextAlign.center,),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    label: Text('Camera'),
                    onPressed: () {
                      Navigator.pop(context, ImageSource.camera);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueGrey.withOpacity(0.8)),
                    ),
                    icon: Icon(
                      Icons.camera_alt_outlined,
                    ),
                  ),
                  ElevatedButton.icon(
                    label: Text('Gallery'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueGrey.withOpacity(0.8)),
                    ),
                    onPressed: () {
                      Navigator.pop(context, ImageSource.gallery);
                    },
                    icon: Icon(Icons.photo_library_outlined),
                  ),
                ],
              )
            ],
          );
        });
  }

  void _pickImage() async {
    ImageSource? imageSource = await getImageSource();
    if(imageSource==null)
      return;
    final XFile? xfile=await ImagePicker().pickImage(source: imageSource, maxWidth: 100, maxHeight: 100,imageQuality: 50);
    if(xfile==null)
        return;
    setState(() {
      _pickedImage=File(xfile.path);
    });
    //pass to auth screen
    widget.imagerPickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return GestureDetector(
      child: CircleAvatar(
        radius: mediaQueryData.size.width * 0.15,
        backgroundImage:  _pickedImage!=null ? FileImage(_pickedImage!) as ImageProvider : _defaultImage,
        backgroundColor: Colors.blueGrey.withOpacity(0.8),
      ),
      onTap: _pickImage,
    );
  }
}
