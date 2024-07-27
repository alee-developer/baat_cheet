import 'dart:io';
import 'package:baat_cheet_app/views/utils/extensions/int_extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MediaController extends GetxController {
  Rx<File> getCameraImageFile = File("").obs;

  Future<XFile?> takeImageFromCamera() async {
    var imageFile = (await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50));
    if (imageFile != null) getCameraImageFile.value = File(imageFile.path);
    return imageFile;
  }

  var getCameraVideoFile = File("").obs;

  Future<XFile?> takeVideoFromCamera() async {
    var videoFile = (await ImagePicker()
        .pickVideo(source: ImageSource.camera, maxDuration: 5.minutes));
    if (videoFile != null) getCameraVideoFile.value = File(videoFile.path);
    return videoFile;
  }

  Rx<File> getGalleryImageFile = File("").obs;

  Future<XFile?> takeSingleImageFromGallery() async {
    var imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (imageFile != null) getGalleryImageFile.value = File(imageFile.path);
    return imageFile;
  }

  var getGalleryImageFiles = <File>[].obs;

  Future<List<XFile>> takeMultipleImageFromGallery() async {
    var imageFiles = await ImagePicker().pickMultiImage();
    if (imageFiles.isNotEmpty) {
      getGalleryImageFiles.value =
          imageFiles.map((file) => File(file.path)).toList();
    }
    return imageFiles;
  }

  var getVideoFile = File("").obs;

 Future<XFile?> takeVideoFiles()async{
    var videoFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if(videoFile != null) getVideoFile.value = File(videoFile.path);
    return videoFile;
  }
  var getVideoFiles = <File>[].obs;

 Future<List<File>> takeMultipleVideoFiles()async{
   var filePicker = await FilePicker.platform.pickFiles(
       allowMultiple: true,
       type: FileType.video);
   if(filePicker?.files.isNotEmpty == true && filePicker != null){
     getVideoFiles.value = filePicker.files.map((file)=>File(file.path??"")).toList();
   }
    return getVideoFiles;
  }


  var getDocumentFiles = <File>[].obs;

  Future<List<File>?> takeDocuments() async {
    List<File>? files = <File>[];
    var filePicker = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowedExtensions: ['PDF', "JPG", "PNG"],
        type: FileType.custom);
    if (filePicker?.paths.isNotEmpty == true) {
      files = filePicker!.paths.map((file) => File(file ?? "")).toList();
      getDocumentFiles.value = files;
    }

    return files;
  }
}
