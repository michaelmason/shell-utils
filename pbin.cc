#include <iostream>
using std::cout;
using std::endl;
#include <cstdlib>
using std::atoi;
#include <cstdio>

void print_binary(int n)
{
    if(n) {
        print_binary(n >> 1);
        putc((n & 1) ? '1' : '0', stdout);
    }
}

int main(int argc, char * argv[])
{
    if(argc != 2) {
        cout << "Usage: " << argv[0] << " <integer-value>" << endl;
        return 1;
    }

    int i = atoi(argv[1]);

    print_binary(i);
    cout << endl;

    return 0;
}
