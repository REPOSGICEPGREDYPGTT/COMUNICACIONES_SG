/*
 * OCP5051.c
 *
 *  Created on: 28/08/2020
 *      Author: davrm
 *
 *  Edited on: 29/03/2021
 *      By: AINV
 */


#include <OCP5051.h>
#include <math.h>

float K[8] = { 0.14, 13.5, 120, 80, 315.2, 0.0515, 19.61, 28.2 };
float A[8] = { 0.02, 1, 1, 2, 2.5, 0.02, 2, 2 };
float B[8] = { 0, 0, 0, 0, 0, 0.114, 0.491, 0.1217 };

/*
 * brief: According to tipe of curve, it is select protection settings among
 * 0 -> IEC standard inverse, 1-> Very inverse, 2-> IEC Long TIme inverse
 * 3-IEC Extremely Inverse, 4->IEC Ultra Inverse, 5->IEEE Moderately Inverse
 * 6->IEEE Very Inverse and 7->IEEE Extremely Inverse
 */
void OCP50_Init(OCPS *OCP)
{
    OCP->k = K[OCP->TrigFt];
    OCP->alpha = A[OCP->TrigFt];
    OCP->b = B[OCP->TrigFt];
    OCP->IPickUp = OCP->PS1 * OCP->In;
    OCP->Trig = 0;
    OCP->IPickUp_1 = OCP->IPickUp * OCP->Esc;
}


void OCP50_Loop(OCPS *OCP, int *Iin)
{
    float   auxVar_0, auxVar_1, TO, Tact50, Tact51;
    int RMSMax;

    RMSMax = Iin[0];
    if (RMSMax > OCP->IPickUp_1){           // Timer protección 50
        OCP->Cont50++;
        Tact50 = OCP->Ts * OCP->Cont50;
        if ( Tact50 > OCP->Tins){
            OCP->Trig = 1;
            OCP->Cont50 = 0;
        }
    }

    if (RMSMax > OCP->IPickUp)              // Timer ´protección 51
    {
        OCP->Cont51++;
        auxVar_0 = RMSMax / OCP->IPickUp;
        auxVar_1 = pow(auxVar_0, OCP->alpha);
        auxVar_1 -= 1;
        auxVar_1 = OCP->k / auxVar_1;
        auxVar_1 += OCP->b;
        TO = auxVar_1 * OCP->TMS1;
        Tact51 = OCP->Ts * OCP->Cont51;
        if (Tact51 > TO){
            OCP->Trig = 1;
            OCP->Cont51 = 0;
        }
    }

}

void ResetProt(int Ordr, OCPS *OCP)
{
    if (Ordr==1){
        //OCP->Trig = 0;
        OCP->Cont50 = 0;
        OCP->Cont51 = 0;
    }
}
/*
int Max(int *Data)
{
    if (Data[0] >= Data[1])
    {
        if (Data[0] >= Data[2])
            return Data[0];
    }
    else if (Data[1] >= Data[0])
    {
        if (Data[1] >= Data[2])
            return Data[1];
    }
    else if (Data[2] >= Data[0])
    {
        if (Data[2] >= Data[1])
            return Data[2];
    }
    return 0;
}
*/
