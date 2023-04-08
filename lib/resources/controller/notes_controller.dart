import 'dart:math';

import 'package:get/get.dart';
import 'package:mira_care/resources/data/model/message.dart';

class NotesController extends GetxController {
  List<String> avatarUri = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPprK2UpcWM6d34sFN4LZARi59deYcjy2QuIVpydrTMg5HGpzDLfm5vngiqr0z4sz3B8U&usqp=CAU',
    'https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmInR4ljBH8rLmxngqj5KH5NIWJ6fdGtt8ow&usqp=CAU',
    'https://www.tensionends.com/wp-content/uploads/2022/09/Beautiful-Girl-DP-Images-1.jpg',
    'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80'
  ];

  List<String> messages = [
    'Beth did not have a good night\'s sleep and woke up several times during the night. She ate her breakfast however it took a bit longer than normal because she appeared tired.',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
    'Picture of Beth when she came home from school',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
    'Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it. Beth had a good day at school, had speech and physical therapy, and, per the therapists, did well. Met with Dr. Shah, and she recommended increasing Melatonin to 10mg for the next week. I pureed the lasagna and fed her dinner at 6:30 pm. She really enjoyed it.',
  ];

  List<Note> get notes => [
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
        Note(
          messages[Random().nextInt(messages.length)],
          avatarUri[Random().nextInt(avatarUri.length)],
          DateTime.now(),
        ),
      ];

  int get notesTotal => notes.length;
}
