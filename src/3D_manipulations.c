/*
 * Functions for manipulating points in 3D space
 *
 */

#include "3D_manipulations.h"



/* rotate_on_axis: rotate x,y angle degrees around
    an axis to points newx,newy
    (2D or 3D rotations) */
void rotate_on_axis (int x, int y, int angle, int *newx, int *newy) {
    /* newx and newy mappings for rotation:
        newx = y, newy = z : rotation about x
        newx = z, newy = x : rotation about y
        newx = x, newy = y : rotation about z
        */

    int rads = angle * 3.1415926535897932 / 180;

    *newx = (int)((x * cos (rads)) - (y * sin (rads)));
    *newy = (int)((y * cos (rads)) + (x * sin (rads)));
}

/* 3D_to_2D: translate 3D coordinates to 2D ones */
void coords_3D_to_2D (Point A, Point C, int angle, int *x2D, int *y2D) {

    int ax, az;
    rotate_on_axis (A.z, A.x, angle, &az, &ax);

    *x2D = (FOV * (ax  - C.x)) / (C.z - az);
    *y2D = (FOV * (A.y - C.y)) / (C.z - az);
}

