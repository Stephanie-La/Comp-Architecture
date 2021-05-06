#include <stdio.h>

typedef union {
    float floating_value_in_32_bits;
    struct sign_exp_mantissa {
        unsigned mantissa : 23;
        unsigned exponent : 8;
        unsigned sign : 1;
    }f_bits;
    struct single_bits {
        unsigned  b0 : 1;
        unsigned  b1 : 1;
        unsigned  b2 : 1;
        unsigned  b3 : 1;
        unsigned  b4 : 1;
        unsigned  b5 : 1;
        unsigned  b6 : 1;
        unsigned  b7 : 1;
        unsigned  b8 : 1;
        unsigned  b9 : 1;
        unsigned  b10 : 1;
        unsigned  b11 : 1;
        unsigned  b12 : 1;
        unsigned  b13 : 1;
        unsigned  b14 : 1;
        unsigned  b15 : 1;
        unsigned  b16 : 1;
        unsigned  b17 : 1;
        unsigned  b18 : 1;
        unsigned  b19 : 1;
        unsigned  b20 : 1;
        unsigned  b21 : 1;
        unsigned  b22 : 1;
        unsigned  b23 : 1;
        unsigned  b24 : 1;
        unsigned  b25 : 1;
        unsigned  b26 : 1;
        unsigned  b27 : 1;
        unsigned  b28 : 1;
        unsigned  b29 : 1;
        unsigned  b30 : 1;
        unsigned  b31 : 1;
    }bit;
}FLOAT_UN;

void generate_binary_string(FLOAT_UN float_32, int j);


int main(int argc, char* argv[]) {
    FLOAT_UN float_32_s1, float_32_s2, float_32_rslt, fun_arg;

    /******** local helper variables ***********/

    float the_hardware_result;
    int mant_s1, mant_s2, mant_res, exp_s1, exp_s2;
    int i, k, shift_count;
    int denom_s1 = true, denom_s2 = true;


    printf("*****************************************************************************\n ");


    /******** Beginning of program message ***********/
    printf("This program will emulate the addition of two IEEE 754 floating point numbers\n");
    printf("\n");

    /******** request two floating point numbers ********/
    printf("Please enter two positive floating point values each with: ");
    printf("\n");
    printf(" - no more than 6 significant digits\n");
    //printf("\n");
    printf(" - a value between    +    10**37 and 10**-37\n");
    printf("\n");
    printf("\n");



    // scan each floating point in 
    printf("Enter Float 1: ");
    scanf("%g", &float_32_s1.floating_value_in_32_bits);

    printf("Enter Float 2: ");
    scanf("%g", &float_32_s2.floating_value_in_32_bits);
    printf("\n");
    printf("\n");


    /****** generate the floating point hardware result ********/

    // just added the two floating points together 
    the_hardware_result = float_32_s2.floating_value_in_32_bits + float_32_s1.floating_value_in_32_bits;

    /******* get the mantissa and exponent components ****/
    /*******        into the helper variables         ****/

    mant_s1 = float_32_s1.f_bits.mantissa;
    mant_s2 = float_32_s2.f_bits.mantissa;
    exp_s1 = float_32_s1.f_bits.exponent;
    exp_s2 = float_32_s2.f_bits.exponent;

    /******* check for normalization and slam in the *****/
    /*******     hidden bit if normalized            *****/

    // expose hidden bits into mantissa
    // denormalized is false and hidden bit is visible 
    if (exp_s1) {
        mant_s1 |= (1 << 23);
        denom_s1 = false;
    }
    if (exp_s2) {
        mant_s2 |= (1 << 23);
        denom_s2 = false;
    }

    /******* check exponent diff and who's the smallest ****/
    // shift mantissa of smaller value for common exponent

    if ((shift_count = exp_s1 - exp_s2) < 0) {
        shift_count = -(shift_count);    /* keep diff + */
        if (shift_count > 24)shift_count = 24;
        if (shift_count >= 1 && denom_s1) {
            mant_s1 = (mant_s1 >> shift_count - 1);
        }
        else {
            mant_s1 = mant_s1 >> shift_count;
        }
        float_32_rslt.f_bits.exponent = exp_s2;
    }
    else {
        if (shift_count > 24)shift_count = 24;
        if (shift_count >= 1 && denom_s2) {
            mant_s2 = (mant_s2 >> shift_count - 1);
        }
        else {
            mant_s2 = mant_s2 >> shift_count;
        }
        float_32_rslt.f_bits.exponent = exp_s1;
    }
    /**** finally ready to add helper mantissa variables ****/
    // add mantissa together for result

    mant_res = mant_s1 + mant_s2;

    /**** check if the addition overflowed 24 bits, since  ****/
    /**** mantissa with hidden bit can only be 24 bits     ****/
    /**** if we need to right shift, must increase the exp ****/
    /**** finally clear the slammed hidden bit in the      ****/
    /**** mantissa helper to get to 23 bits and put these  ****/
    /**** 23 bits into the mantissa bit field of the result ****/

    // if it overflowed 24 bits, right shift and add to exponent
    if (mant_res & (1 << 24)) {
        mant_res >>= 1;
        float_32_rslt.f_bits.exponent++;
        printf("\n2 HIDDEN BITS, MUST INCREMENT EXPONENT\n");
        float_32_rslt.f_bits.mantissa = (mant_res & ~(1 << 23));
    }
    else {
        float_32_rslt.f_bits.mantissa = (mant_res & ~(1 << 23));
    }


    /**** check for infinity exponent pattern (0xFF) ****/
    /**** cannot have NAN from addition so clear mantissa ****/
    // denom -> denormalized-> exponent is all 0's and  there's no hidden bit

    // if one number overflowed, then all would overflow
    // set the exponents to all zeros
    // if exponents hit the value of 254, exponent is now 255, mantissa is 0
    // exponent is all 0's, that just means some denormalized value
    if(exp_s1 == 254 || exp_s2 == 254 ){
	float_32_rslt.f_bits.exponent = 255;
	float_32_rslt.f_bits.mantissa = 0;
	}


	

    /**** PRINTING EVERYTHING ****/
    /**** printf original pattern of floats and bit pattern of result ****/

    printf("Original pattern of Float 1:  ");
    generate_binary_string(float_32_s1, 0);
    printf("\n");
    printf("Original pattern of Float 2:  ");
    generate_binary_string(float_32_s2, 0);
    printf("\n");
    printf("Bit pattern of result      :  ");
    generate_binary_string(float_32_rslt, 0);
    printf("\n");
    printf("\n");



    /**** print floating results ****/
    printf("EMULATED FLOATING RESULT FROM PRINTF ==>>> %.2f\n", float_32_rslt.floating_value_in_32_bits);
    printf("HARDWARE FLOATING RESULT FROM PRINTF ==>>> %.2f\n", the_hardware_result);
    printf("\n");
    printf("*****************************************************************************\n");

}

/**** helper function to print bit_string ****/

void generate_binary_string(FLOAT_UN float_32, int j) {
    char bit_string[43];

    int i;
    for (i = 0; i < 42; i++) {
        bit_string[i] = ' ';
        //make spaces
    }
    bit_string[42] = '\0';

    bit_string[0] = float_32.bit.b31 ? '1' : '0'; //sign bit, MSB

    bit_string[2] = float_32.bit.b30 ? '1' : '0'; //value at b31 n checks true(1) or false(0), 
    bit_string[3] = float_32.bit.b29 ? '1' : '0';
    bit_string[4] = float_32.bit.b28 ? '1' : '0';
    bit_string[5] = float_32.bit.b27 ? '1' : '0';

    bit_string[7] = float_32.bit.b26 ? '1' : '0';
    bit_string[8] = float_32.bit.b25 ? '1' : '0';
    bit_string[9] = float_32.bit.b24 ? '1' : '0';
    bit_string[10] = float_32.bit.b23 ? '1' : '0'; //end of exp. bits

    bit_string[12] = float_32.bit.b22 ? '1' : '0';
    bit_string[13] = float_32.bit.b21 ? '1' : '0';
    bit_string[14] = float_32.bit.b20 ? '1' : '0';

    bit_string[16] = float_32.bit.b19 ? '1' : '0';
    bit_string[17] = float_32.bit.b18 ? '1' : '0';
    bit_string[18] = float_32.bit.b17 ? '1' : '0';
    bit_string[19] = float_32.bit.b16 ? '1' : '0';

    bit_string[21] = float_32.bit.b15 ? '1' : '0';
    bit_string[22] = float_32.bit.b14 ? '1' : '0';
    bit_string[23] = float_32.bit.b13 ? '1' : '0';
    bit_string[24] = float_32.bit.b12 ? '1' : '0';

    bit_string[26] = float_32.bit.b11 ? '1' : '0';
    bit_string[27] = float_32.bit.b10 ? '1' : '0';
    bit_string[28] = float_32.bit.b9 ? '1' : '0';
    bit_string[29] = float_32.bit.b8 ? '1' : '0';

    bit_string[31] = float_32.bit.b7 ? '1' : '0';
    bit_string[32] = float_32.bit.b6 ? '1' : '0';
    bit_string[33] = float_32.bit.b5 ? '1' : '0';
    bit_string[34] = float_32.bit.b4 ? '1' : '0';

    bit_string[36] = float_32.bit.b3 ? '1' : '0';
    bit_string[37] = float_32.bit.b2 ? '1' : '0';
    bit_string[38] = float_32.bit.b1 ? '1' : '0';
    bit_string[39] = float_32.bit.b0 ? '1' : '0'; // end of mantissa

    // loop and print out the entire bit string
    for (i = j; i < 42; i++) {
        printf("%c", bit_string[i]);
    }
}


