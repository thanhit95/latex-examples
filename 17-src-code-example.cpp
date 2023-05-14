/*
My program prints data of a point
*/
#include <iostream>
using namespace std;

struct Point
{
    int x;
    int y;
};

Point createPoint(int x, int y)
{
    Point p = {x, y};
    return p;
}

int main()
{
    Point A = createPoint(4, -17);
    cout << A.x << " " << A.y << endl;
    // Should print "4 -17"
    return 0;
}
