
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => inputModel(),
  child:const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: const Color.fromRGBO(30, 62, 98, 100), secondary: const Color.fromARGB(255, 11, 25, 44), tertiary: const Color.fromARGB(255, 255, 101, 0) ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BMI Calculator'),
    );
  }
}

class inputModel extends ChangeNotifier {
  double _sliderValue = 0;
  int _weight = 0;
  int _age = 0;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  double get sliderValue => _sliderValue;
  int get weight => _weight;
  int get age => _age;

  void weightInput(int newWeightInput){
    _weight = newWeightInput;
    notifyListeners();
  }

  void ageInput(int newAgeInput){
    _age = newAgeInput;
    notifyListeners();
  }


  void updateInput(double newSliderValue){
    _sliderValue = newSliderValue;
    notifyListeners();
  } 

  void updateAgeFromController(){
    int age = int.tryParse(ageController.text) ?? 0;
    ageInput(age);
  }

  void updateWeightFromController(){
    int weight = int.tryParse(weightController.text) ?? 10;
    weightInput(weight);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeGender = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(30, 62, 98, 0),
        toolbarHeight: 30,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.fitness_center, color: Colors.white,),
            SizedBox(width: 8),
            Text(widget.title, style: GoogleFonts.poppins(fontSize: 15, color: Colors.white))
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(2, (index) {
              String gender = index == 0 ? "Male" : "Female";
              return genderCard(gender: gender, index: index, isActive: activeGender == index, onCardtap: (selectedIndex) {
                setState(() {
                  activeGender = selectedIndex;
                });
              },);
            }),
          ),
          SizedBox(height: 5),
          heightCards(),
          SizedBox(height: 30),
          submitButton(gender: activeGender,)
        ],
      )
    )
    ;
  }
}

class bmiResult extends StatelessWidget{
  final double result;
  final String indexResult;
  bmiResult({
    super.key,
    required this.result,
    required this.indexResult,
  });
  @override
  Widget build(BuildContext context) {
      var colorScheme = Theme.of(context).colorScheme;
      return Scaffold(
        backgroundColor: colorScheme.primary,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
              SizedBox(height: 80,),
              Text("Your BMI Index Is", style: GoogleFonts.poppins(color: colorScheme.tertiary, fontSize: 20)),
              Text(indexResult, style: GoogleFonts.poppins(color: colorScheme.tertiary, fontSize: 20)),
              SizedBox(height: 50,),
              Card(
                color: colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                child: SizedBox(
                  height: 700,
                  width: 403,
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Text('Your BMI IS', style: GoogleFonts.poppins(color: colorScheme.tertiary, fontSize: 30, fontWeight: FontWeight.w600),),
                      Text(result.toStringAsFixed(2), style: GoogleFonts.poppins(color: colorScheme.tertiary, fontSize: 20),),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: colorScheme.tertiary),
                        onPressed:(){
                          Navigator.pop(context);
                      }, child: Text('Re Generate', style: GoogleFonts.poppins(color: colorScheme.secondary),))
                    ],
                  ),
                ),
              )
                ],
              ),
            ],
          ),
        )
      );
  }
}

class genderCard extends StatefulWidget{
  final String gender;
  final int index;
  final bool isActive;
  final Function(int) onCardtap;
  genderCard({super.key, 
  required this.gender,
  required this.index,
  required this.isActive,
  required this.onCardtap,
  });

  @override
  State<genderCard> createState() => _genderCardState();
}

class _genderCardState extends State<genderCard> {
  
  @override
  
  Widget build(BuildContext context){
  var colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Card(
          clipBehavior: Clip.hardEdge,
          color: widget.isActive ? const Color.fromARGB(255, 223, 223, 223) : colorScheme.secondary,
          child: InkWell(
            splashColor: colorScheme.primary,
            onTap: () {
              widget.onCardtap(widget.index);
            },
            child: SizedBox(
            width: 180,
            height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.index == 1 ? Icons.female : Icons.male, color: colorScheme.tertiary,),
                  Text(widget.gender, style:  GoogleFonts.poppins(color: colorScheme.tertiary))
                ],
              )
            ),
          ),
          ),
      ],
    );
  }
}

class heightCards extends StatelessWidget{
  heightCards({super.key});
  @override
  Widget build(BuildContext context){
    var colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: colorScheme.secondary,
          child: SizedBox(
            width: 370,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Height', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: colorScheme.tertiary)),
                    ),
                    heightSlider(),
                    SizedBox(height: 25,),
                    weightTextField(),
                    SizedBox(height: 50,),
                    ageTextField(),
            ],
            ),
          )
        )
      ],
    );
  }
}

class ageTextField extends StatelessWidget{
  ageTextField({super.key});
  @override
  Widget build(BuildContext context) {
  var colorScheme = Theme.of(context).colorScheme;
  final model = Provider.of<inputModel>(context);
      return Center(
        child: Column(
          children: [
            Text('Age', style: GoogleFonts.poppins(color: colorScheme.tertiary),),
            Container(
              width: 200,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(color: colorScheme.tertiary),
                controller: model.ageController,
                decoration: InputDecoration(
                  hintText: 'Year',
                  hintStyle: GoogleFonts.poppins(color: colorScheme.tertiary),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.tertiary)
                  )
                ),
              ),
            )
          ],
        ),
      );
  }
}
class weightTextField extends StatelessWidget{
  weightTextField({super.key});
  @override
  Widget build(BuildContext context) {
  var colorScheme = Theme.of(context).colorScheme;
  final models = Provider.of<inputModel>(context);
      return Center(
        child: Column(
          children: [
            Text('Weight', style: GoogleFonts.poppins(color: colorScheme.tertiary),),
            Container(
              width: 200,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(color: colorScheme.tertiary),
                controller: models.weightController,
                decoration: InputDecoration(
                  hintText: 'CM',
                  hintStyle: GoogleFonts.poppins(color: colorScheme.tertiary),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.tertiary)
                  )
                ),
              ),
            )
          ],
        ),
      );
  }
}

class heightSlider extends StatefulWidget{
    heightSlider({super.key});

  @override
  State<heightSlider> createState() => _heightSliderState();
}

class _heightSliderState extends State<heightSlider> {
    double currentSliderValue = 0;
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    @override
    Widget build(BuildContext context){
    var colorScheme = Theme.of(context).colorScheme;
      return Column(
        children: [
          Text(currentSliderValue.toString().replaceAll(regex, '') + " CM ", style: GoogleFonts.poppins(color: colorScheme.tertiary,fontSize: 20, fontWeight: FontWeight.w600),),
          Center(
            child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: colorScheme.tertiary,
              inactiveTrackColor: colorScheme.primary,
              thumbColor: colorScheme.tertiary
            ), 
            child: Slider(
            value: currentSliderValue,
             max: 250,
             divisions: 250,
             label: currentSliderValue.round().toString(),
             onChanged: (double value){
              setState(() {
                currentSliderValue = value;
                Provider.of<inputModel>(context, listen: false).updateInput(value);
              });
             },
             ),)
            
          ),
        ],
      );
    }
}

class submitButton extends StatefulWidget{
  final int gender;
  submitButton({
    super.key,
    required this.gender,  });

  @override
  State<submitButton> createState() => _submitButtonState();
}

class _submitButtonState extends State<submitButton> {

  @override
  Widget build(BuildContext context) {
  var colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: SizedBox(
        width: 370,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ), backgroundColor: colorScheme.tertiary),
          onPressed: (){
        _navigateAndDisplaySelection(context);
        }, child: Text('Calculate', style: GoogleFonts.poppins(color: Colors.white),)),
      ),
    );
  }
  Future<void> _navigateAndDisplaySelection(BuildContext context) async{
  double sliderValue = Provider.of<inputModel>(context, listen: false).sliderValue;
          Provider.of<inputModel>(context, listen: false).updateWeightFromController(); 
          Provider.of<inputModel>(context, listen: false).updateAgeFromController(); 
          // int age = Provider.of<inputModel>(context, listen: false).age;
          int weight = Provider.of<inputModel>(context, listen: false).weight;
        double meter = sliderValue/100;
        double bmi = weight/(meter*meter);
        String result = "";
        switch(widget.gender){
          case 0:
            if(bmi <= 18.4){
              result = "Underweight";
            }else if(bmi >= 18.5 && bmi <= 24.9){
              result = "Normal";
            }else if(bmi >= 25.0 && bmi <= 39.9){
              result = "Overweight";
            }else{
              result = "Obese";
            }
          break;
          case 1:
            if(bmi <= 18.4){
              result = "Underweight";
            }else if(bmi >= 18.5 && bmi <= 24.9){
              result = "Normal";
            }else if(bmi >= 25.0 && bmi <= 39.9){
              result = "Overweight";
            }else{
              result = "Obese";
            }
          break;
          default:

          break;
        
        }
        await Navigator.push(context, MaterialPageRoute(builder: (context) => bmiResult(result: bmi, indexResult: result)));
  }
}
