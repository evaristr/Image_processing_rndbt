function img = drawrectangle(img, xbounds, ybounds)
  img(ybounds, xbounds(1):xbounds(2)) = 1;
  img(ybounds(1):ybounds(2), xbounds) = 1;
end