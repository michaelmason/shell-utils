#include <iostream>
using namespace std;

int main(int argc, char * argv[])
{
    cout << "**** Integer Types"         << endl;
    cout << "sizeof(char):             " << sizeof(char) << endl;
    cout << "sizeof(short):            " << sizeof(short) << endl;
    cout << "sizeof(int):              " << sizeof(int) << endl;
    cout << "sizeof(long int):         " << sizeof(long int) << endl;
    //cout << "sizeof(long long int):    " << sizeof(long long int) << endl;
    cout << "sizeof(size_t):           " << sizeof(size_t) << endl;
    cout << "**** Floating Point Types"  << endl;
    cout << "sizeof(float):            " << sizeof(float) << endl;
    cout << "sizeof(double):           " << sizeof(double) << endl;
    cout << "sizeof(long double):      " << sizeof(long double) << endl;
    //cout << "sizeof(long long double): " << sizeof(long long double) << endl;
    return 0;
}
