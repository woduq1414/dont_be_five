class ImagePath {

  static const String person = "./assets/images/person1.png";
  static const String player = "./assets/images/player3.png";
  static const String goal = "./assets/images/goal.png";
  static const String isolate = "./assets/images/isolation.png";
  static const String release = "./assets/images/release.png";
  static const String vaccine = "./assets/images/vaccine.png";
  static const String diagonal = "./assets/images/diagonal.png";
  static const String titleLogo = "./assets/images/logo.png";


  static getTutorialImagePath(int page){
    return "./assets/images/tutorial${page}.png";
  }

}


class SoundPath {

  static const String beep = "sounds/beep.mp3";
  static const String clear = "sounds/clear.mp3";
  static const String step = "sounds/step.mp3";
  static const String release = "sounds/release.mp3";
  static const String isolate = "sounds/isolate.mp3";
  static const String vaccine = "sounds/vaccine.mp3";

}
