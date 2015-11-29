#include <iostream>

int makeFruitsFromTrees(int fruits, int people, int trees, int weeks) {
    weeks += 1;
    fruits += trees;

    if (fruits >= people) {
        return weeks;
    } else {
        return makeFruitsFromTrees(fruits, people, trees + fruits, weeks);
   }
}

int main(int argc, char* argv[]) {
    int fruits = std::stoi(argv[1]);
    int people = std::stoi(argv[2]);

    int weeks = makeFruitsFromTrees(0, people, fruits, 1);
    std::cout << weeks << std::endl;

    return 0;
}
