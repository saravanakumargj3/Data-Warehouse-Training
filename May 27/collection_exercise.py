# LISTS
# 1. List of Squares
squares = [i**2 for i in range(1, 21)] #loops till 20
print("List of squares from 1 to 20:", squares)

# 2. Second Largest Number
lst = [10, 20, 4, 45, 99]
first = second = float('-inf') #using most min number
for num in lst:
    if num > first:
        second = first
        first = num #new max
    elif num > second and num != first: #less than first
        second = num
print("Second largest number:", second)

# 3. Remove Duplicates
lst = [1, 2, 2, 3, 4, 4, 5]
seen = set()
unique = []
for item in lst: #making use of the no duplicates in set
    if item not in seen:
        unique.append(item)
        seen.add(item)
print("List without duplicates:", unique)

# 4. Rotate List
lst = [1, 2, 3, 4, 5]
k = 2
k = k % len(lst) #rotating 7 times is same as rotating twice as length is 5
rotated = lst[-k:] + lst[:-k] #get k elements, then add remaining
print("Rotated list:", rotated)

# 5. List Compression
data = [1, 2, 3, 4, 5, 6]
compressed = [x*2 for x in data if x % 2 == 0] #loop with condition
print("Compressed even numbers doubled:", compressed)

# TUPLES
# 6. Swap Values
def swap_tuples(t1, t2):
    return t2, t1 #return reversed

tuple1 = (1, 2)
tuple2 = (3, 4)
tuple1, tuple2 = swap_tuples(tuple1, tuple2)
print("Swapped tuples:", tuple1, tuple2)

# 7. Unpack Tuples
student = ("Saravana", 21, "AI", "A")
name, age, branch, grade = student
print(f"Student {name}, aged {age}, studies {branch} and has grade {grade}.")

# 8. Tuple to Dictionary
tuple_data = (("a", 1), ("b", 2))
dict_data = dict(tuple_data) #from tuple to dict
print("Converted dictionary:", dict_data)

# SETS
# 9. Common Items
list1 = [1, 2, 3, 4]
list2 = [3, 4, 5, 6]
common = list(set(list1) & set(list2)) # & = intersection
print("Common elements:", common)

# 10. Unique Words in Sentence
sentence = "This is a test. This test is easy."
words = sentence.lower().replace('.', '').split() # replace dot with space and split the words
unique_words = set(words) #removes duplicates
print("Unique words:", unique_words)

# 11. Symmetric Difference
set1 = {1, 2, 3}
set2 = {3, 4, 5}
sym_diff = set1 ^ set2 #not common elements
print("Symmetric difference:", sym_diff)

# 12. Subset Checker
A = {1, 2}
B = {1, 2, 3, 4}
print("Is A a subset of B?", A.issubset(B)) #inbuilt function like in

# DICTIONARIES
# 13. Frequency Counter
string = "Saravana" #Takes upper and lowercase as diff elements
freq = {}
for char in string:
    if char != ' ': #omit spaces
        freq[char] = freq.get(char, 0) + 1 #update the the val using get+1
print("Character frequencies:", freq)

# 14. Student Grade Book
students = {}
for _ in range(3): #_ is temp variable
    name = input("Enter student name: ")
    marks = int(input("Enter marks: "))
    if marks >= 90:
        grade = 'A'
    elif marks >= 75:
        grade = 'B'
    else:
        grade = 'C'
    students[name] = grade
name_to_check = input("Enter student name to display grade: ")
print(f"Grade of {name_to_check}: {students.get(name_to_check, 'Not found')}")

# 15. Merge Two Dictionaries
d1 = {"a": 1, "b": 2}
d2 = {"b": 3, "c": 4}
merged = d1.copy()
for key, value in d2.items(): #same key
    merged[key] = merged.get(key, 0) + value  #same key, then add, else append as new key
print("Merged dictionary:", merged)

# 16. Inverted Dictionary
original = {"a": 1, "b": 2}
inverted = {v: k for k, v in original.items()} #k ->v , v-> k
print("Inverted dictionary:", inverted)

# 17. Group Words by Length
words = ["apple", "dog", "banana", "bat", "cat"]
length_dict = {}
for word in words:
    length_dict.setdefault(len(word), []).append(word) #if key present return, else default
print("Grouped words by length:", length_dict)