# Mini Project2 - Shape Matching

In this project our goal is to detect different shapes and label the shape name

## Main functions used
- findContour
- approxPolyDP
- drawContours
- moments
- boundingRect

## Procedures
1. Read an image
2. Apply Threshold
3. Find Contours using *findContour*
4. Loop through all contours
5. Based on the number of approximate polygon, we can figure out the shape
6. Determine shape using *approxPolyDP*
 - if len(approx) == 3, then **Triangle**
 - if len(approx) == 4, use *boundingRect* to calculate width, height, a top left point location
 --    if abs(w-h) <= 3, then **Square**
 --    else **Rectangle**
 - else if len(approx) == 10, then **Star** [No star shape in my image]
 - else if len(approx) >= 15, then **Circle**
7. Put the label and draw contours

