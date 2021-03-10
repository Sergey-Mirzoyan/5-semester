import numpy as np
import time
import os
def menu():
    print("1. Левенштейн: Рекурсивный способ \n\
2. Левенштейн: Матричный способ\n\
3. Дамерау-Левенштейн: Рекурсивный способ \n\
4. Дамерау-Левенштейн: Матричный способ\n\
5. Ввести новые слова\n\
6. Выход")

def levenshtein_rec(a, b):
    if a == "":
        return len(b)
    if b == "":
        return len(a)
    if a[-1] == b[-1]:
        d = 0
    else:
        d = 1
    res = min([levenshtein_rec(a[:-1], b)+1, levenshtein_rec(a, b[:-1])+1, levenshtein_rec(a[:-1], b[:-1]) + d])
    return res

def levenshtein_matrix(seq1, seq2):
    size_x = len(seq1) + 1
    size_y = len(seq2) + 1
    matrix = np.zeros((size_x, size_y))
    for x in range(size_x):
        matrix[x, 0] = x
    for y in range(size_y):
        matrix[0, y] = y

    for x in range(1, size_x):
        for y in range(1, size_y):
            if seq1[x-1] == seq2[y-1]:
                matrix[x, y] = min(
                    matrix[x-1, y] + 1,
                    matrix[x-1, y-1],
                    matrix[x, y-1] + 1)
            else:
                matrix[x, y] = min(
                    matrix[x-1, y] + 1,     
                    matrix[x-1, y-1] + 1,   
                    matrix[x, y-1] + 1)     
                
    return int(matrix[size_x - 1, size_y - 1])

def D_L_rec(a, b):
    if a == "":
        return len(b)
    if b == "":
        return len(a)
    res = 1
    if len(a) >= 2 and len(b) >= 2:
        if a[len(a)-1] == b[len(b)-2] and a[len(a)-2] == b[len(b)-1]:
            if a[-1] == b[-1]:
                d = 0
            else:
                d = 1
            res = min(
                D_L_rec(a[:-1],b)+1,
                D_L_rec(a[:-1],b[:-1]) + d,
                D_L_rec(a,b[:-1])+1,
                D_L_rec(a[:-2],b[:-2]) + 1)
        else:
            if a[-1] == b[-1]:
                d = 0
            else:
                d = 1
            res = min(
                D_L_rec(a[:-1],b)+1,
                D_L_rec(a[:-1],b[:-1]) + d,
                D_L_rec(a,b[:-1])+1)
    return res

def D_L_M(seq1, seq2):
    size_x = len(seq1) + 1
    size_y = len(seq2) + 1
    matrix = np.zeros((size_x, size_y))
    for x in range(size_x):
        matrix[x, 0] = x
    for y in range(size_y):
        matrix[0, y] = y
    val = 0
    for x in range(1, size_x):
        for y in range(1, size_y):
            if seq1[x-1] == seq2[y-1]:
                matrix[x, y] = min(
                    matrix[x-1, y] + 1,
                    matrix[x-1, y-1],
                    matrix[x, y-1] + 1)
            else:
                val = 1
                matrix[x, y] = min(
                    matrix[x-1, y] + 1,     
                    matrix[x-1, y-1] + 1,   
                    matrix[x, y-1] + 1)     
            if x and y and (seq1[x-1] == seq2[y-2] and seq1[x-2] == seq2[y-1]):
                matrix[x,y] = min(
                    matrix[x,y],
                    matrix[x-2,y-2]+val)            
    return int(matrix[size_x - 1, size_y - 1])
def inputwords():
    word = input("Введите слово: ")
    diary_word = input("Введите словарное слово: ")
    return word, diary_word

def process():
    word_1, word_2 = inputwords()
    while True:
        menu()
        choice = input("Выберите пункт: ")
        if choice == "1":
            start  = time.perf_counter()
            m = levenshtein_rec(word_1, word_2)
            stop = time.perf_counter()
            print("Штафов: ", m, "\t Время работы = ", stop-start)
        elif choice == "2":
            start = time.perf_counter()
            m = levenshtein_matrix(word_1, word_2)
            stop = time.perf_counter()
            print("Штафов: ", m, "\t Время работы = ", stop-start)
        elif choice == "3":
            start  = time.perf_counter()
            m = D_L_rec(word_1, word_2)
            stop = time.perf_counter()
            print("Штафов: ", m, "\t Время работы = ", stop-start)
        elif choice == '4':
            start  = time.perf_counter()
            m = D_L_M(word_1, word_2)
            stop = time.perf_counter()
            print("Штафов: ", m, "\t Время работы = ", stop-start)
        elif choice == "5":
            word_1, word_2 = inputwords()
        elif choice == "6":
            break
        else:
            print("Неправильный ввод. Выберите пункт из списка!\n")
        print()
process()
