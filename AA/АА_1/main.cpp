//
//  main.cpp
//  lab1AA

#include <iostream>
#include <string>
#include <vector>
#include "test.hpp"
#include "levenstein.hpp"
#include "levenstein_recurs.hpp"


int main(int argc, const char * argv[]) {
    
    //test_levenstein_distance();

//    std::string s1;
//    std::cout << "Input first string: " << std::endl;
//    std::cin >> s1;
//    std::string s2;
//    std::cout << "Input second string: " << std::endl;
//    std::cin >> s2;

//    std::cout << "Result levenstein: ";
//    int result = levenshtein_distance(s1, s2);
//    std::cout << result << std::endl;
//
//    std::cout << "Result domerau-levenstein: ";
//    result = damerau_levenshtein(s1, s2);
//    std::cout << result << std::endl;
//
//    std::cout << "Result recurs levenstein: ";
//    result = levenshtein_recurs(s1, s2);
//    std::cout << result << std::endl;
    test_levenstein_distance();
    
    return 0;
}
