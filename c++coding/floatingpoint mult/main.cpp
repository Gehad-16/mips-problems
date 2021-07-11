#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// assumptions:
// 'unsigned long' is a 32-bit type
// 'float' maps to IEEE-754 'binary32'. Exceptions are disabled

// add using definition of sum and carry bits in binary addition
unsigned long add (unsigned long a, unsigned  long b)
{
    unsigned long sum, carry;
    carry = b;
    do {
        sum = a ^ carry;
        carry = (a & carry) << 1;
        a = sum;
    } while (carry);
    return sum;
}

// return 1 if a == b, else 0
int eq (unsigned long a, unsigned  long b)
{
    unsigned long t = a ^ b;
    // OR all bits into lsb
    t = t | (t >> 16);
    t = t | (t >>  8);
    t = t | (t >>  4);
    t = t | (t >>  2);
    t = t | (t >>  1);
    return ~t & 1;
}

// compute 2.0f * a
unsigned long fpmul_by_2 (unsigned long a)
{
    unsigned long expo_mask = 0x7f800000UL;
    unsigned long expo_lsb  = 0x00800000UL;
    unsigned long qnan_mark = 0x00400000UL;
    unsigned long sign_mask = 0x80000000UL;
    unsigned long zero      = 0x00000000UL;
    unsigned long r;

    if (eq (a & expo_mask, zero)) {             // subnormal or zero
        r = a << 1;                             // double significand
    } else if (eq (a & expo_mask, expo_mask)) { // INF, NaNs
        if (eq (a & ~sign_mask, expo_mask)) {   // INF
            r = a;
        } else {                                // NaN
            r = a | qnan_mark;                  // quieten SNaNs
        }
    } else {                                    // normal
        r = add (a, expo_lsb);                  // double by bumping exponent
        if (eq (r & expo_mask, expo_mask)) {    // overflow
            r = expo_mask;
        }
    }
    return r | (a & sign_mask);                 // result has sign of argument
}

float uint_as_float (unsigned long a)
{
    float r;
    memcpy (&r, &a, sizeof r);
    return r;
}

unsigned long float_as_uint (float a)
{
    unsigned long r;
    memcpy (&r, &a, sizeof r);
    return r;
}

int main (void)
{
    unsigned long res, ref, a = 0;
    do {
        res = fpmul_by_2 (a);
        ref = float_as_uint (2.0f * uint_as_float (a));
        if (res != ref) {
            printf ("error: a=%08lx  res=%08lx  ref=%08lx\n", a, res, ref);
            return EXIT_FAILURE;
        }
        a++;
    } while (a);
    printf ("test passed\n");
    return EXIT_SUCCESS;
}
