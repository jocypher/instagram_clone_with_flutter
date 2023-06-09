import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{
  // ignore: no_leading_underscores_for_local_identifiers
  final ImagePicker _imagePicker = ImagePicker();

  // ignore: no_leading_underscores_for_local_identifiers
  XFile? _file = await _imagePicker.pickImage(source: source);

  if(_file != null){
    return await _file.readAsBytes();
  }
  // ignore: avoid_print
  print("No image selected");
}

const networkImage = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAH8AfwMBIgACEQEDEQH/xAAbAAEAAwEBAQEAAAAAAAAAAAAAAQUGBAMCB//EADQQAAIBAwIDBAgFBQAAAAAAAAABAgMEMQURIUGBUXFysRITIiQyMzRhFJGSwdEjQkNSYv/EABYBAQEBAAAAAAAAAAAAAAAAAAABAv/EABYRAQEBAAAAAAAAAAAAAAAAAAABEf/aAAwDAQACEQMRAD8A/WgGCoAAAAAAAAAAAAAAAAEogLIBgMAAAAAAAFfd6rTotwopVJrL34Irp6ndzfzFHwxQwaEGep6pdwe7qKa7JRRZWeqUq7UKq9XUeOxjB3gAAAAAWQFkAwGAAAAFXrF46fu9J7SfGbXZ2Fo2km3hcWZStUdarOpLMnuIPkEAqBJAAvNIvHWj6iq95xW8W+aLIy1vVdCvCrHMXv0NT3YJVgAAAWQFkAwGAAAA8rrha1ts+rlt+RljWyipxcXhrZmUnB05yhLMXsyxK+QAAAAEmqo/Jp7/AOq8jMUqbq1YU45lJI1KWy2WEKRIAIoFkBZAMBgAAABT61aNS/EwXB/Hty+5cENJpprdPtAyQLi80jdudrLb/iXLuZXTtLmHxUKnSLZUeBJ707O5m/ZoVOsdvMsbPSVCSnc7Nrj6Cx1YEaLaNe81Ftw9j+S2HcCKAAAFkBZAMBgACHwW7eyKi+1RtunavZYdTm+4CxuLuhbfNntLlFcW+hXVtZk+FCkl95vcqm222223lsgqOueo3c/8zj4UkeTurh5r1P1s8QB7K6uI4uKv62etPUruG39VyXZJJnIALehrPKvSXig/2LKhc0bhb0aik+aw10MuTGUoSUoyakuafEYrWAqrDVfSap3TSb4Kp295akwAsgLIBgM87mp6m3qVX/bFvryAqtYvG5O2pvZL42uf2KsNttuXFt7tkFQAAAAAAAAAAAudIvfTX4eo/aS9hvmuwpj7pzlTqRnD4ovdAasLJ8wmpwjNYkk0fSyRRnHq30FTp5nbscerfQVOnmBnQQDSJBAIJBAAkEACQQAJBAKNNp/0VHwI6Fk59PXuVHwI6UuJlX//2Q==";


showSnackBar(String content, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)
      )
  );
}