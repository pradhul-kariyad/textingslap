import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  Uint8List? _image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return Stack(
      children: [
        // Displaying current profile picture if available
        _image != null
            ? Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: MemoryImage(_image!),
                ),
              )
            : FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: getUserDocument(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    // Placeholder image if user document doesn't exist
                    return Center(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey, // Placeholder color
                        child: Icon(Icons.person), // Placeholder icon
                      ),
                    );
                  }

                  String? profilePic = snapshot.data!.get('profilepic');

                  if (profilePic == null || profilePic.isEmpty) {
                    // Placeholder image if profile picture URL is empty or null
                    return Center(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey, // Placeholder color
                        child: Icon(Icons.person), // Placeholder icon
                      ),
                    );
                  }

                  // Displaying profile picture from URL
                  return Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(profilePic),
                    ),
                  );
                },
              ),
        Positioned(
          right: 90,
          bottom: 4,
          child: IconButton(
            onPressed: () {
              showImagePickerOption(context);
            },
            icon: Icon(
              Icons.add_a_photo,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 221, 234, 245),
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: const SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 55,
                        ),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _pickImageFromCamera();
                  },
                  child: const SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 55,
                        ),
                        Text("Camera"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
      String imageUrl = await uploadImage(File(pickedImage.path), uid);
      updateProfilePicture(uid, imageUrl);

      setState(() {
        selectedImage = File(pickedImage.path);
        _image = File(pickedImage.path).readAsBytesSync();
      });

      Navigator.of(context).pop();
    }
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
      String imageUrl = await uploadImage(File(pickedImage.path), uid);
      updateProfilePicture(uid, imageUrl);

      setState(() {
        selectedImage = File(pickedImage.path);
        _image = File(pickedImage.path).readAsBytesSync();
      });

      Navigator.of(context).pop();
    }
  }

 Future<String> uploadImage(File imageFile, String userId) async {
  try {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  } catch (e) {
    print("Error uploading image: $e");
    return ""; // You may want to handle this differently based on your app's requirements
  }
}


  void updateProfilePicture(String userId, String imageUrl) {
    try {
      FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'profilepic': imageUrl,
      });
    } catch (e) {
      print("Error updating profile picture: $e");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;
      return await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .get();
    } else {
      return Future.value(null);
    }
  }
}
