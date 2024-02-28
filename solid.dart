//srp

class UserManager {
    bool authenticate(username, password){
        return true;
    }

    void updateProfile(username, profile){
        print("User updated");
    }
}

//right
class Auth{
     bool authenticate(username, password){
        return true;
    }
}

 class Profile{
    void updateProfile(username, profile){
        print("User updated");
    }
 }


 //ocp
 class Shape{
    String shape;
    Shape(this.type);
 }  
 class AreaCal{
    double area(Shape shape){
        if(shape.type == 'circle'){
            return 3.14 * 3.14;
        }else if(shape.type == 'rectangle'){
            return 4*5;
        }
        return 0;
    }
 }

    //right
abstract interface class Shape{
    double calArea();
}

class Circle implements Shape{

    double radius;
    Cricle(this.radius)

    @override
    double calArea(){
        ///perform here
    }
}

class AreaCal(
    double calculateArea(Shape shape){
        shape.calArea();
    }
)

//liskov
abstract class Animal{
    void makeSound();
}

class Lion extends Animal {
    @override
    void makeSound(){
        print('roar');
    }
}

void makeAnimalSound(Animal animal){

}

void main(){
    Animal animal = Lion();
    makeAnimalSound(animal);
}

//interface segregation
abstract interface class Worker{
    void work();
    void eat();
}

class Developer implements Worker{
    @override
    void work(){
        print("Dev is working");
    }

    @override
    void eat(){
        print("Dev is eating");
    }
}

class Girls implements Worker{
    @override
    void work(){
        print("Girl is working");
    }

    @override
    void eat(){
        print("Girl is eating");
    }
}

//right
abstract interface class Worker{
    void work();
}

abstract interface class Eater{
    void eat();
}

class Developer implements Worker{
    @override
    void work(){
        print("Dev is working");
    }
}

class Girls implements Worker{

    @override
    void eat(){
        print("Girl is eating");
    }
}

void main(){
    var dev = Developer();
    var.work();

    var dev = Girl();
    var.eat();
}

//dependency inversion
 class IncandescentBulb extends Bulb{
    @override
    void turnOn(){
        print('incandescent bulb on');
    }
    @override
    void turnOff(){
        print('incandescent bulb off');
    }
 }

  class Florescent extends Bulb{
    @override
    void turnOn(){
        print('Florescent bulb on');
    }
    @override
    void turnOff(){
        print('Florescent bulb off');
    }
 }

 abstract interface class Bulb{
    void turnOn();
    void turnOff();
 }



 class Room {
    Florescent bulb;
    Room(this.bulb);

    void switchOn(){
        bulb.turnOn();
    }
 }


 abstract interface class ApiService {
    double get();
 }

 class MockLocal extends ApiService{
    get(){
        //get from local
        double = 0;
    }
 }

 class Fetchbackend extends {
    get(){
        //get from backend
    }
 }