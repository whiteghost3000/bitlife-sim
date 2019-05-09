#!/usr/bin/env python3
import time
import os
import sys
import random
import pickle
import termcolor
from termcolor import colored

all_jobs = ["Cameraman","Teacher","Doctor","Government Spy", "Janitor"]
sickness = ["Flu","Fever","Cancer","Ebola","Aids"]
kill_items = ["running them over", "cutting their head off", "showing them t-series videos"]

class Player:

    def __init__(self,name):
        self.name = name
        self.salary = 0
        self.money = 0
        self.smart = random.randint(15,75)
        self.health = random.randint(60,100)
        self.age = 0
        self.education_year = 0
        self.year_cost = 0
        self.education = 0
        self.job = "No Job"
        self.sickness = "Not Sick"
        self.in_college = False
        self.in_school = False
        self.years_in_college = False
        self.has_job = False
        self.years_in_prison = 0
        self.lifetime_earnings_casino = 0
        self.dead = False
        self.criminal = False
        self.prison_escapes = 0

def main():
    os.system('clear')
    print("1. Start")
    print("2. Load")
    print("3. View Update Log")
    print("4. Exit")

    option = input(">>> ")

    if option == "1":
        restart()
    elif option == "2":
        os.system('clear')
        if os.path.exists('sim.save') == True:
            with open('sim.save', 'rb') as f:
                global PlayerIG
                PlayerIG = pickle.load(f)
                os.system('clear')
                print("Game loaded!")
                option = input(" ")
                start()
        else:
            os.system('clear')
            print("No save file found!")
    elif option == "3":
        update_log()
    elif option == "4":
        sys.exit()
    else:
        sys.exit()

def update_log():
    os.system('clear')
    print("1.0: Game released")
    print("1.1: Installer released")
    print(('1.2:'), colored('Colour', 'cyan'), ('added to certain sections of the game.'))
    print("1.3 (current): Misc")
    print(" ")
    option = input("ENTER to go back.")
    main()

def restart():

    os.system('clear')

    print("What would you like to be called?")

    option = input(">>> ")

    global PlayerIG
    PlayerIG = Player(option)

    start()

def doctor():
    if PlayerIG.age < 18:
        print("You are now cured!")
        PlayerIG.sickness = "Not Sick"

        option = input(" ")
        start()

    os.system('clear')
    print("Welcome to the medical centre!")
    print("I can see that you are sick with %s." % PlayerIG.sickness)
    doctor_cost = random.randint(100,2000)
    print("That will cost you %s." % doctor_cost)
    print("Would you like to pay it? [Yes/No]")

    option = input(">>> ")
    if option == "Yes":
        if PlayerIG.money < doctor_cost:
            os.system('clear')
            print("You don't have enough money!")
            option = input(" ")
            start()
        else:
            os.system('clear')
            print("You are now cured!")
            PlayerIG.money -= doctor_cost
            PlayerIG.sickness = "Not Sick"
            option = input(" ")
            start()
    elif option == "No":
        os.system('clear')
        start()
    else:
        os.system('clear')
        start()

def activities():
    os.system('clear')
    print("What would you like to do?")
    print("1. Library")
    print("2. Yoga")
    print("3. Commit a murder")
    print("4. Back")

    option = input(" ")

    if option == "1":
        os.system('clear')
        print("You went to the library!")
        PlayerIG.health += random.randint(1,5)
        PlayerIG.smart += random.randint(1,5)
        option = input(" ")
        start()
    elif option == "2":
        if PlayerIG.money > 15:
            os.system('clear')
            print("You goto a yoga session! It cost $15.")
            PlayerIG.money -= 15
            PlayerIG.health += random.randint(2,6)
            option = input(" ")
            start()
        else:
            print("You don't have enough money...")
            option = input(" ")
            start()
    elif option == "3":
        commit = random.randint(1,10)
        if commit < 8:
            PlayerIG.criminal = True
            PlayerIG.prison_escapes = 0
            caught()
        else:
            os.system('clear')
            money_gained = random.randint(50,40000)
            print("You got away with the murder by %s." % random.choice(kill_items))
            print("You stole %s from the victum!" % money_gained)
            PlayerIG.money += money_gained
            option = input(" ")
            start()
    elif option == "4":
        start()
    else:
        activities()

def start():

    if PlayerIG.years_in_prison > 0:
        prison()

    if PlayerIG.dead == True:
        dead()

    os.system('clear')
    print(colored('Name:', 'green'), (PlayerIG.name))
    print(colored('Age:', 'green'), (PlayerIG.age))
    print(colored('Salary:', 'green'), (PlayerIG.salary))
    print(colored('Smartness:', 'green'), (PlayerIG.smart))
    print(colored('Health:', 'green'), (PlayerIG.health))
    print(colored('Money:', 'green'), (PlayerIG.money))
    print(colored('Job:', 'green'), (PlayerIG.job))
    print(colored('Sickness:', 'green'), (PlayerIG.sickness))
    print(" ")
    print("1. Age Up")
    print("2. Education")
    print("3. Doctor")
    if PlayerIG.age > 13:
        print("4. Jobs")
    if PlayerIG.age >= 17:
        print("5. Casino")
    if PlayerIG.age >= 17:
        print("6. Activities")
    print("7. Die")
    if PlayerIG.age >= 17:
        print("8. Save")

    option = input(">>> ")

    if option == "1":
        age_up()
    elif option == "2":
        if PlayerIG.in_school is True or PlayerIG.in_college is True:
            education()
        else:
            os.system('clear')
            print("You do not goto school.")
            option = input(" ")

            start()
    elif option == "3":
        if PlayerIG.age < 17 and PlayerIG.sickness in sickness:
            os.system('clear')
            print("You are no longer sick!")
            PlayerIG.sickness = "Not Sick"
        elif PlayerIG.sickness == "Not Sick":
            os.system('clear')
            print("You are not sick?")
            option = input(" ")
            start()
        else:
            doctor()
    elif option == "4":
        if PlayerIG.age < 13:
            start()
        elif PlayerIG.in_college is True or PlayerIG.in_school is True:
            os.system('clear')
            print("You are in school you cant work!")
            option = input(" ")
        else:
            jobs()
    elif option == "5" and PlayerIG.age >= 17:
        casino()
    elif option == "6" and PlayerIG.age >= 17:
        activities()
    elif option == "7":
        os.system('clear')
        print("R.I.P %s...." % PlayerIG.name)
        option = input(" ")
        dead()
    elif option == "8" and PlayerIG.age >= 17:
        os.system('clear')
        with open('sim.save', 'wb') as f:
            pickle.dump(PlayerIG, f)
            print("Gave saved!")
            option = input(" ")
            start()


    elif option == "enablehacks":
        PlayerIG.salary = 100000
        PlayerIG.money = 500000000
        PlayerIG.smart = 100
        PlayerIG.health = 100
        PlayerIG.name = "Hacker"
        PlayerIG.in_school = False
        PlayerIG.in_college = False

        os.system('clear')
        print("Hacks enabled!")
        option = input(" ")
        start()
    else:
        start()

def prison():

    os.system('clear')
    text = colored('PRISON', 'red', attrs=['reverse', 'blink'])

    print("------ " + text + " ------")

    print(colored('Name:', 'red'), (PlayerIG.name))
    print(colored('Age:', 'red'), (PlayerIG.age))
    print(colored('Smartness:', 'red'), (PlayerIG.smart))
    print(colored('Health:', 'red'), (PlayerIG.health))
    print(colored('Sickness:', 'red'), (PlayerIG.sickness))
    print(colored('Years left in prison:', 'red'), (PlayerIG.years_in_prison))
    print(" ")
    print("1. Age Up")
    print("2. Doctor")
    print("3. Library")
    if PlayerIG.prison_escapes < 3:
        print("4. Attempt to escape (%s/3)" % PlayerIG.prison_escapes)
    option = input(">>> ")

    if option == "1":
        age_up()
    elif option == "2":
        os.system('clear')
        print("You are now cured!") # add chance to not be cured
        PlayerIG.sickness = "Not Sick"
        option = input(" ")
        prison()
    elif option == "3":
        print("You goto the library!")
        PlayerIG.smart += random.randint(-1,1)
        PlayerIG.health += random.randint(-1,1)
        option = input(" ")
        prison()
    elif option == "4" and PlayerIG.prison_escapes < 3:
        escape = random.randint(1,5)
        if escape == 1:
            os.system('clear')
            print("You escaped!")
            PlayerIG.years_in_prison = 0
            PlayerIG.criminal = False
            option = input("")
            age_up()
        else:
            os.system('clear')
            years_increased = random.randint(10,20)
            print(colored('''You didn't escape!''','red'))
            print("Your prison sentence got increased by %s years." % years_increased)
            PlayerIG.years_in_prison += years_increased
            PlayerIG.prison_escapes += 1
            option = input(" ")
            age_up()

    else:
        prison()

def caught():
    os.system('clear')
    years_in_prison = random.randint(5,30)
    print("You were caught in the act of killing your victim by %s." % random.choice(kill_items))
    print("You got put in prison for %s years." % years_in_prison)
    option = input(" ")
    PlayerIG.salary = 0
    PlayerIG.job = "None"
    PlayerIG.has_job = False
    PlayerIG.years_in_prison = years_in_prison
    start()

def sick():
    global sickness
    sickness_for_person = random.sample(sickness, 1)
    print("Oh no! You got sick from %s" % sickness_for_person)
    PlayerIG.sickness = sickness_for_person
    option = input(" ")

    start()

def age_up():

    # Setting year cost to zero
    PlayerIG.year_cost = 0

    # Setting escape attempts back to zero if they leave jail
    if PlayerIG.years_in_prison == 0:
        PlayerIG.prison_escapes = 0

    #Taxes (to stop people getting soooo much money b/c government is mean)
    if PlayerIG.age > 18 and PlayerIG.salary > 0:
        PlayerIG.year_cost = (PlayerIG.salary * 0.25)
        if PlayerIG.salary > 150000:
            PlayerIG.year_cost = (PlayerIG.salary * 0.47)

    # college
    if PlayerIG.in_college is True:
        PlayerIG.years_in_college += 1
        if PlayerIG.years_in_college == 4:
            finished_college()

    #Money + Age
    os.system('clear')
    PlayerIG.age += 1
    salary = PlayerIG.salary
    salary -= PlayerIG.year_cost
    PlayerIG.money += salary
    if PlayerIG.age > 17 and PlayerIG.has_job is True:
        print("Your base salary was %s, however tax brought it down to: %s" % (PlayerIG.salary, salary))
        option = input(" ")
    print("You are now %s." % PlayerIG.age)

    #health
    if PlayerIG.age > 100:
        PlayerIG.health += random.randint(-10,0)
    if PlayerIG.money < 0:
        PlayerIG.health -= random.randint(-5,-1)
    if PlayerIG.age < 100:
        PlayerIG.health += random.randint(-5,3)
    if PlayerIG.health > 100:
        PlayerIG.health = 100
    if PlayerIG.age > 150:
        PlayerIG.health -= 35
    if PlayerIG.health <= 0:
        dead()

    if PlayerIG.years_in_prison > 0:
        PlayerIG.years_in_prison -= 1

    if PlayerIG.sickness == "Fever":
        PlayerIG.health += random.randint(-5,0)
    elif PlayerIG.sickness == "Flu":
        PlayerIG.health += random.randint(-5,0)
    elif PlayerIG.sickness == "Cancer":
        PlayerIG.health += random.randint(-20,-10)
    elif PlayerIG.sickness == "Ebola":
        PlayerIG.health += random.randint(-70,-50)
    elif PlayerIG.sickness == "Aids":
        PlayerIG.health += random.randint(-40,-20)

    #stuff about education milestones
    if PlayerIG.age == 6:
        print("You now attend primary school.")
        PlayerIG.education_year = random.randint(-3,3)
        PlayerIG.in_school = True
    elif PlayerIG.age == 13 and PlayerIG.in_school == True:
        print("You are now attending high school.")
        PlayerIG.education_year = random.randint(-3,3)
        PlayerIG.in_school = True
    elif PlayerIG.age == 17 and PlayerIG.in_school == True:
        college()

    #education
    PlayerIG.smart += PlayerIG.education_year
    if PlayerIG.smart > 100:
        PlayerIG.smart = 100
    elif PlayerIG.smart < 0:
        PlayerIG.smart= 0

    option = input(" ")

    chance_of_sickness = random.randint(1,10)
    print(chance_of_sickness)
    if chance_of_sickness == 1:
                sick()

    start()

def finished_college():

    os.system('clear')
    print("You finished college!")
    PlayerIG.in_college = False
    PlayerIG.in_school = False
    PlayerIG.smart += random.randint(10,20)
    if PlayerIG.smart > 100:
        PlayerIG.smart = 100
    option = input(" ")
    start()

def education():

    os.system('clear')
    print("What would you like to do?")
    print("1. Study Harder")
    print("2. Leave School")
    print("3. Back")

    option = input(">>> ")

    if option == "1":
        os.system('clear')
        print("You study harder.")
        PlayerIG.smart += random.randint(1,3)
        if PlayerIG.smart > 100:
            PlayerIG.smart = 100

        option = input(" ")
        education();
    elif option == "2":
        leaveschool()
    elif option == "3":
        start()
    else:
        os.system('clear')
        print("Invalid Command.")
        option = input(" ")
        education()

def cameraman_job():
    if PlayerIG.smart > 35 and PlayerIG.criminal == False:
        print("You got the job!")
        print("Your salary is $35,000.")
        PlayerIG.salary = 35000
        PlayerIG.has_job = True
        option = input(" ")
        PlayerIG.job = "Camera Man"
        start()
    else:
        print("Sadly you didn't get the job!")
        option = input(" ")
        start()

def doctor_job():
    if PlayerIG.smart > 75 and PlayerIG.criminal == False:
        print("You got the job!")
        print("Your salary is $125,000.")
        PlayerIG.salary = 125000
        PlayerIG.has_job = True
        option = input(" ")
        PlayerIG.job = "Doctor"
        start()
    else:
        print("Sadly you didn't get the job!")
        option = input(" ")
        start()

def teacher_job():
    if PlayerIG.smart > 60 and PlayerIG.criminal == False:
        print("You got the job!")
        print("Your salary is $45,000.")
        PlayerIG.salary = 45000
        PlayerIG.has_job = True
        option = input(" ")
        PlayerIG.job = "Teacher"
        start()
    else:
        print("Sadly you didn't get the job!")
        option = input(" ")
        start()

def janitor_job():
    if PlayerIG.smart > 30:
        print("You got the job!")
        print("Your salary is $15,000.")
        PlayerIG.salary = 15000
        PlayerIG.has_job = True
        option = input(" ")
        PlayerIG.job = "Janitor"
        start()
    else:
        print("Sadly you didn't get the job!")
        option = input(" ")
        start()

def spy_job():
    if PlayerIG.smart > 90 and PlayerIG.criminal == False:
        print("You got the job!")
        print("Your salary is $200,000.")
        PlayerIG.salary = 200000
        PlayerIG.has_job = True
        option = input(" ")
        PlayerIG.job = "Government Spy"
        start()
    elif PlayerIG.criminal == True:
        print("The governemnt can't accpt criminals!")
    else:
        print("Sadly you didn't get the job!")
        option = input(" ")
        start()

def jobs():

    os.system('clear')

    # Choose random Jobs

    av_jobs = random.sample(all_jobs, 3)

    print("Welcome to the Job Centre!")
    print("Please choose a job!")
    print("---------------------------")
    for i in av_jobs:
        print(i)
    print("---------------------------")

    option = input(">>> ")

    # Checks if option in availiable jobs

    if option in av_jobs:
        os.system('clear')
        print("You applied for %s" % option)

        if option == "Cameraman":
            cameraman_job()
        elif option == "Teacher":
            teacher_job()
        elif option == "Doctor":
            doctor_job()
        elif option == "Government Spy":
            spy_job()
        elif option == "Janitor":
            janitor_job()
        else:
            print("You chicken... How did you get here? For your hard work of breaking this game I will now reward you with $5m!")
            PlayerIG.money =+ 5000000
            option = input(" ")
            start()

    else:
        os.system('clear')
        print("That job is currently not avaliable... or your just a madlad and pressed enter.")
        option = input(" ")
        start()


def dead():
    os.system('clear')
    print ("You are dead.")
    print("You survived to: %s" % PlayerIG.age)
    print("You had $%s." % PlayerIG.money)
    PlayerIG.dead = True
    with open('sim.save', 'wb') as f:
        pickle.dump(PlayerIG, f)

    sys.exit(0)

def college():

    os.system('clear')
    print("Would you like to attend college?")
    print("1. Yes")
    print("2. No")

    option = input(">>> ")

    if option == "1":
        if PlayerIG.smart < 75:
            print("Your grades are not good enough and your college application is rejected.")
            PlayerIG.education_year = 0
            PlayerIG.in_school = False
            PlayerIG.in_college = False
            option = input(" ")
        else:
            global college_cost
            college_cost = random.randint(30000,50000)
            accepted()
    elif option == "2":
        print("You choose not to goto college.")
        PlayerIG.in_school = False
        PlayerIG.education_year = 0
        option = input(" ")
    else:
        print("You must choose!")
        option = input(" ")
        college()

def accepted():
    os.system('clear')
    print("You are accepted.")
    print("How are you going to pay for your college?")

    print("Cost = %s" % college_cost)
    print("1. Ask Parents")
    print("2. Student Loan")

    option = input(">>> ")

    if option == "1":
        os.system('clear')
        parents = random.randint(1,4)
        if parents == 1:
            print("Your parents pay. You lucky duck.")
            option = input(" ")
            start()
            PlayerIG.in_college = True
            PlayerIG.in_school = False
        else:
            os.system('clear')
            print("You parents don't want to pay.")
            print("You get a student loan of %s dollars. You wallet will feel it later." % college_cost)
            PlayerIG.money -= college_cost
            PlayerIG.in_college = True
            PlayerIG.in_school = False
            option = input(" ")
    elif option == "2":
        os.system('clear')
        print("You get a student loan of %s dollars. You wallet will feel it later." % college_cost)
        PlayerIG.money -= college_cost
        option = input(" ")
        PlayerIG.in_college = True
        PlayerIG.in_school = False
    else:
        accepted()
    PlayerIG.education_year = random.randint(1,3)
    start()

def leaveschool():
    option = random.randint(1,2)

    if option == 1 and PlayerIG.age > 13:
        os.system('clear')
        print("You leave school.")
        PlayerIG.education_year = 0
        PlayerIG.in_school = False
        PlayerIG.in_college = False

        option = input(" ")
        start()
    else:
        os.system('clear')
        print("Your parents don't let you leave school.")

        option = input(" ")

        start()

def casino():

    os.system('clear')
    if PlayerIG.money < 0:
        os.system('clear')
        print("You don't have enough money!")
        option = input(">>> ")
        start()

    print("Welcome to the Casino.")
    print("Life Time Earnings: %s" % PlayerIG.lifetime_earnings_casino)
    print("You win twice what you bet! However you only lose what you bet!")
    print("----------------------------------------------------------------")
    print("How much would you like to bet? (Enter -5 to get back)")
    money_bet = int(input(">>> "))

    if money_bet == -5:
        os.system('clear')
        start()
    elif money_bet < 0:
        print("That is an invalid bet.")
        option = input(" ")
        os.system('clear')
        casino()
    if money_bet > PlayerIG.money:
        print("Thats more than you have!")
        option = input(" ")
        os.system('clear')
        casino()

    print("You need to roll a 5 or above to win!")
    print("Press enter to roll the dice...")
    option = input(" ")

    print("Rolling...")
    time.sleep(0.5)

    dice = random.randint(1,6)

    print("You rolled a %s" % dice)
    if dice >= 5:
        money_won = (money_bet * 2)
        print("You win $%s!" % money_won)
        PlayerIG.money += money_won

        option = input(" ")
        start()
    else:
        money_lost = (money_bet)
        print("You lose $%s!" % money_lost)
        PlayerIG.money -= money_lost

        option = input(" ")
        start()

main()
