# -*- coding: utf-8 -*-
"""
Created on Fri Nov 17 18:23:52 2017

@author: Evarist
"""

import numpy as np
import cv2  
import pylab as pl

cap = cv2.VideoCapture('C:/Users/Evariet/Documents/Headway_1/trial2.mp4')
fgbg = cv2.createBackgroundSubtractorMOG2()

cap.set(cv2.CAP_PROP_POS_MSEC,20000);
ret, imag = cap.read(1)
r = cv2.selectROI(imag)

pl.imshow(imag) 