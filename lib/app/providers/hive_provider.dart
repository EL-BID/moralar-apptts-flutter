import 'package:hive/hive.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class HiveProvider{

  void deleteAll(){
    Hive.deleteBoxFromDisk('quizzes');
  }

  Future<QuizDetails?> getQuizDetails(String id) async {
    var box = await Hive.openBox('quizzes');
    if(box.isNotEmpty) {
      for(int i = 0; i < box.length; i++){
        if(box.getAt(i).id == id){
          return box.getAt(i);
        }
      }
    }
    return null;
  }

  Future<void> saveQuizDetails(QuizDetails quizDetails) async {
    var box = await Hive.openBox('quizzes');
    box.add(quizDetails);
  }

  Future<List<FamilyTTS>> getTimeline() async {
    var box = await Hive.openBox('timeline');
    List<FamilyTTS> families = [];
    if(box.isNotEmpty) {
      for(int i = 0; i < box.length; i++){
        families.add(box.getAt(i));
      }
    }
    return families;
  }

  Future<void> saveTimeline(List<FamilyTTS> families) async {
    await Hive.deleteBoxFromDisk('timeline');
    var box = await Hive.openBox('timeline');
    families.forEach((element) {
      box.add(element);
    });
  }

  Future<FamilyTTS?> getFamily(String id) async {
    var box = await Hive.openBox('family');
    if(box.isNotEmpty) {
      for(int i = 0; i < box.length; i++){
        if(box.getAt(i).familyId == id){
          return box.getAt(i);
        }
      }
    }
    return null;
  }

  Future<void> saveFamily(FamilyTTS familyTTS) async {
    var box = await Hive.openBox('family');
    box.add(familyTTS);
  }

  Future<List<Answer>> getAnswers() async {
    var box = await Hive.openBox('answers');
    List<Answer> answers = [];
    if(box.isNotEmpty) {
      for(int i = 0; i < box.length; i++){
        answers.add(box.getAt(i));
      }
    }
    return answers;
  }

  Future<void> saveAnswers(List<Answer> answers) async {
    var box = await Hive.openBox('answers');
    answers.forEach((element) {
      box.add(element);
    });
  }
}