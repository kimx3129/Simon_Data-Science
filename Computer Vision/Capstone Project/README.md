# Capstone Project

## Objective
- The goal of this project is to count the number of fingers through the live cam (accuracy is not that very perfect). First, it takes a few seconds to calculate accumulated average for the background and once it is ready we can put our hand into the ROI (a predefined red square on the cam). Once hand is detected, another window will be popped up for displaying a series of binary threshold images. 

## Used libraries 
- Numpy
- OpenCV2
- Sklearn

## What are main image processing & computer vision techniques used
- Threshold
- Contour detection
- Convex Hull
- Bitwise operator
- Gaussian blur

## Step
1. Define global variables for setting up and calculate an accumulated average of the background in ROI
2. Grab ROI and get running average for 60 frames of video. After average value is calculated, we can put our hands in ROI
3. Retrieve a hand segment from ROI
4. Through Convex Hull draw a polygon around the hand and it connects points around most external points in a frame
5. Get rid of wrist part so that we calculate the most extreme values (top, bottom, left, right)
6. Use their intersection to get the center
7. Calculate the distance the furthest away from the center. 
8. Use that distance to create a circle (in this case that distance will be the radius of that circle)
9. Count any points outside of the circle are extended fingers, so we count them
10. Run all steps above on the live cam

## Result

1. Initialization step

![Init](https://github.com/kimx3129/Simon_Data-Science/blob/master/Computer%20Vision/Capstone%20Project/Initialization%203.15.56%20AM.png)

2. Test

*One Finger*
![Init](https://github.com/kimx3129/Simon_Data-Science/blob/master/Computer%20Vision/Capstone%20Project/One%203.15.56%20AM.png)

*Two Fingers*
![Init](https://github.com/kimx3129/Simon_Data-Science/blob/master/Computer%20Vision/Capstone%20Project/Two%203.15.56%20AM.png)

*Three Fingers*
![Init](https://github.com/kimx3129/Simon_Data-Science/blob/master/Computer%20Vision/Capstone%20Project/Three%203.15.56%20AM.png)


## Reference
[1] Convex Hull 
![CH](https://github.com/kimx3129/Simon_Data-Science/blob/master/Computer%20Vision/Capstone%20Project/ch.png)
