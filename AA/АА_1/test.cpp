//
//  test.cpp
//  lab1AA

#include "test.hpp"

void print_result(std::string s1, std::string s2, int number, int result, unsigned int time, std::string alg)
{
    std::cout << "Test №" << number << ": \n" << "Algorhytm: " << alg << "\nFirst string: " << s1 << '\n' << "Second string: " << s2 << '\n' << "Result: " << result << '\n' << "Time of work: " << time << '\n' << std::endl;
}

void test_levenstein_distance()
{
    std::string s1;
    std::string s2;

    std::string s12;
    std::string s23;

    int result = 0;
    float start_time =  clock();
    float end_time = clock();
    float search_time = end_time - start_time;
    std::string alg1 = "Levenshtein";
    std::string alg2 = "Levenshtein recurs";
    std::string alg3 = "Damerau-Levenshtein";

    //------------Case 1
    
    s12 = "qwerty"; // generate(10);
    s23 = "qewryt"; //  generate(10);
    s1 =  generate(1000);
    s2 =  generate(1000);
    
    start_time = clock();
    result = levenshtein_distance(s1, s2);
   // end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 1, result, start_time, alg1);
    
    int start_time1= clock();
    result = damerau_levenshtein(s1, s2);
    //end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 1, result, start_time1, alg3);
    
    int start_time2 = clock();
    result = levenshtein_recurs(s12, s23);
    //end_time = clock();
    //search_time = end_time - start_time;
    print_result(s12, s23, 1, result, start_time2, alg2);
    
    //------------Case 2
/*
    s1 = generate(10);
    s2 = generate(9);
    start_time2 = clock();
    result = levenshtein_distance(s1, s2);
    //end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 2, result, start_time2, alg1);
    
    start_time3 = clock();
    result = damerau_levenshtein(s1, s2);
   // end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 2, result, start_time3, alg3);
    /*
    start_time = clock();
    result = levenshtein_recurs(s1, s2);
    end_time = clock();
    search_time = end_time - start_time;
    print_result(s1, s2, 2, result, search_time, alg2);
    */
    //------------Case 3
/*
    s1 = generate(8);
    s2 = generate(7);
    start_time4 = clock();
    result = levenshtein_distance(s1, s2);
   // end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 3, result, start_time4, alg1);
    
    start_time5 = clock();
    result = damerau_levenshtein(s1, s2);
    //end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 3, result, start_time5, alg3);
    /*
    start_time = clock();
    result = levenshtein_recurs(s1, s2);
    end_time = clock();
    search_time = end_time - start_time;
    print_result(s1, s2, 3, result, search_time, alg2);
    */
    //------------Case 4
/*
    s1 = generate(15);
    s2 = generate(15);
    start_time6 = clock();
    result = levenshtein_distance(s1, s2);
   // end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 4, result, start_time6, alg1);
    
    int start_time7 = clock();
    result = damerau_levenshtein(s1, s2);
    //end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 4, result, start_time7, alg3);
    /*
    start_time = clock();
    result = levenshtein_recurs(s1, s2);
    end_time = clock();
    search_time = end_time - start_time;
    print_result(s1, s2, 4, result, search_time, alg2);
    */
    //------------Case 5
/*
    s1 = generate(22);
    s2 = generate(21);
    int start_time8 = clock();
    result = levenshtein_distance(s1, s2);
    //end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 5, result, start_time8, alg1);

    int start_time9 = clock();
    result = damerau_levenshtein(s1, s2);
    //end_time = clock();
    //search_time = end_time - start_time;
    print_result(s1, s2, 5, result, start_time9, alg3);
    /*
    start_time = clock();
    result = levenshtein_recurs(s1, s2);
    end_time = clock();
    search_time = end_time - start_time;
    print_result(s1, s2, 5, result, search_time, alg2);
    */
}
