# -*- coding: utf-8 -*-
"""
Created on Sat Nov 11 03:04:14 2017

@author: Evarist
"""

import numpy as np
import cv2  
import pylab as pl
from roipoly import roipoly 

cap = cv2.VideoCapture('C:/Users/Evariet/Documents/Headway_1/trial2.mp4')
fgbg = cv2.createBackgroundSubtractorMOG2()

cap.set(cv2.CAP_PROP_POS_MSEC,20000);
ret, imag = cap.read()
r = cv2.selectROI(imag)
imCrop = imag[int(r[1]):int(r[1]+r[3]), int(r[0]):int(r[0]+r[2])]
res = cv2.bitwise_and(imag,imag,mask = imCrop)
cv2.imshow("Image", res);
#cv2.SetImageROI(imag, poly)
# show the image
cv2.imshow('imag',imag)
#pl.colorbar()
cv2.title("left click: line segment         right click: close region")
# let user draw first ROI
ROI1 = roipoly(roicolor='r') #let user draw first ROI
i = 0

while(True):
    # Capture frame-by-frame
    ret, frame = cap.read()

    fgmask = fgbg.apply(frame)
    kernel = np.ones((5,5),np.uint8)
    fgmask = cv2.morphologyEx(fgmask, cv2.MORPH_OPEN, kernel)
    if i == 10:
        # Display the fgmask frame
        cv2.imshow('fgmask',fgmask)
        # Display original frame
        cv2.imshow('img', frame)

   # k = cv2.waitKey(0) & 0xff
   # if k == 5:
  #      break
    i = i+1
cap.release()
cv2.destroyAllWindows()