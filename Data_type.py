#if else concept

"""1) Get User Input for Variable Meghna, If Meghna==Died Print
"Surya meets Priya"
Else "Surya weds Meghna" I

Meghna=input("Meghna:")
if Meghna=="Died":
    print("Surya meets Priya")
else:
    print("Surya weds Meghna")"""

"""2) Get the input for variable income.If income is greater than 7000
scholarship is available.Else not eligible for scholarship 
income=int(input("income:"))
if (income>7000):
    print("Scholarship is available")
else :
    print("Scholarship is NOT available")"""

"""3)Get input for a number and check whether it is divisible by both 3
and 5 or not.If yes then print,the number is divisible by 3 and 5.Else print
the number is not divisible by 3 and 5.

number = int(input("number:"))
if number % 3 == 0 and number % 5 == 0:
    print("number is divisible by 3 and 5")
else:
    print("number is not divisible by 3 and 5")"""

"""4.Get input for a number and find it is even or odd.

number = int(input("number:"))
if number%2==0:
    print("the given number is even")
else:
    print("the given number is odd")"""

"""5) Get the input out of 100,if score is <35=poor student,
 if student score greater than 35 and 75 print Average student,and if score than 70 the student is good

score = int(input("score:"))
if score<35:
    print("Poor Student")
elif score>35 and score<75:
    print("Average Student")
else:
    print("Performed Student")"""

"""6)Make a mini calculator,Get input for 2 variables
A and B .Get input from user where operator is add/sub/mul/div and print the result

a=int(input("a:"))
b=int(input("b:"))
operator=input("operator:"  )
if operator=="+":
    print(a+b)
elif operator=="-":
    print(a-b)
elif operator=="*":
    print(a*b)
elif operator=="/":
    print(a/b)
else:
    print("Operator not supported")"""

"""7)Get input for salary and age,if salary greater than or equal to 20000 or age less than or equal to 25
get input for loan amount.If not print you are not eligible for loan. If required loan amount is less than
or equal to 50000 print you are eligible for loan. If it is greater than 50000 print max amount is 50000

salary=int(input("salary:"))
age=int(input("age:"))
if salary>=20000 and age>=25:
    loan=int(input("loan:"))
    if loan>=50000:
        print("You are eligible for loan")
    else :
        print("Minimum Loan amount is 50000")
else:
    print("Loan Declined")"""

"""8)Get input for five subjects marks.Add all of it,And find average .If average mark is less than 35.
    print "Additional Class Required",else print "you are good to go".
a=int(input("Enter the mark: "))
b=int(input("Enter the mark: "))
c=int(input("Enter the mark: "))
d=int(input("Enter the mark: "))
e=int(input("Enter the mark: "))
total_mark=a+b+c+d+e
avg_mark=total_mark/5
print(total_mark)
if avg_mark>35:
    print("You are Good")
else:
    print("You are bad,Additional Class Required")"""

                                                                                                        #FOR LOOP
"""1)print output in for loop

a=[1,2,3,4,5,6,7,8,9,10]
for n in range(0,121):
    print(n)"""

"""2)Get output of n in multiple of numbers in list

a=[1,2,3,4,5,6,7,8,9,10]
for n in range(0,121):
    print(n*n)"""

"""3)print 2 table using loop
num=[]
for i in range(1,11):
    print(i,"x2=",i*2)"""

"""4)get a input for two variables of a and b ,print numbers between A and B using for loop.
a=int(input("Enter the number:"))
b=int(input("Enter the number:"))
for i in range(a+1,b-1):
    print(i)"""

"""5)print even numbers using for loop
for i in range(1,11):
    if i%2==0:
        print(i)"""

"""6)count even numbers of 1 to 10
count=0 #count=0:assign variable count 1st incase you haven't it doesn't consider
for n in range(1,11):
    if n%2==0:
        count=count+1
        print(n)
print("count: ",count)
"""

"""7)count the odd and even numbers between 1 to 10 and print it.
count_a=0
count_b=0
for i in range(1,11):
    if i%2==0:
        count_a=count_a+1
    elif i%2!=0:
        count_b=count_b+1
print("count of even numbers: ",count_a)
print("count of odd numbers: ",count_b)"""

"""8)count number divisible by 3 and 5
count=0
for i in range(1,101):
    if i%3==0 and i%5==0:
        count=count+1
print("numbers divisible by 3 and 5: ",count)"""

"""9)write the program for compute sum of a first 5 natural numbers
sum=0
for i in range(1,6):
    sum=sum+i
print(sum)"""

"""10)write a code to read 10 numbers from the key board and find thier sum and average
numbers=[]
for i in range(1,11):
    i=int(input("Enter the number:"))
    numbers.append(i)
print(numbers)
sum=0
for i in numbers:
    sum=sum+i
print(sum)
avg=sum/len(numbers)
print(avg)"""

"""11)write a program to display the cube number up to an integer.
for i in range(1,6):
    print(i*i*i)"""
                                                                                #NESTED LOOP

"""1)Get input for days in Week using Nested for loop
for i in range(1,3):
    print("Week:",i)
    for j in range(1,6):
        print("Day:",j)"""

"""2)print program in pyramid using nested for loop
for i in range(1,5):
    print(i)
    for j in range(1,i+1):
        print(j,end=" ")"""
                                                                              #WHILE LOOP
#1)Print 1 to 5 numbers using while loop
i=5
while i<5:
    print(i)
i=i+1
