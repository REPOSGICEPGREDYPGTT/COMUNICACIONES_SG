/*
 * OCP5051.h
 *
 *  Created on: 28/08/2020
 *      Author: davrm
 */

#ifndef INCLUDE_OCP5051_H_
#define INCLUDE_OCP5051_H_

//#include <arm_math.h>

typedef struct
{
    int TrigFt;             //
    int Trig;               // Disparo
    int Cont50;        // Timer protección 51
    int Cont51;        // Timer protección 50
    float k;            // Constante K
    float alpha;        // Constante Alpha
    float b;            // Constante B
    float TMS1;         // Multiplicador de tiempo
    float PS1;          //
    float Tins;         // Tiempo instantaneo
    float Esc;          // Escala
    float In;           // Corriente Nominal
    float IPickUp;      // I Pick-Up 51
    float IPickUp_1;    // I Pick-Up 50
    float Ts;           // Sample time

}OCPS;// Overcurrent protection settings


void OCP50_Loop(OCPS *OCP, int *Iin);
void ResetProt(int Ordr, OCPS *OCP);
void OCP50_Init(OCPS *OCP);
int Max(int *Data);

#endif /* INCLUDE_OCP5051_H_ */
