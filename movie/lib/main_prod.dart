
import 'package:vinhcine/commons/app_environment.dart';
import 'main.dart';


void main() async{
  currentEnvironment = Environment.prod;
  await loadApp();
}