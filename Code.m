%Name, Surname: Betül Şener
%Student Number: 090180318
%MAT116E Term Project

clc;
clear all;
close all
warning off

[filename, pathname] = uigetfile('*.*', 'Pick the Bottle Image');
%Making the user select a photo
if isequal(filename,0) || isequal(pathname,0)
    disp('User pressed cancel')
%User's cancellation status  
else
    filename=strcat(pathname,filename);
    bottle=imread(filename);
%Readig the bottle image

cropped=imcrop(bottle,[518.5 186.5 93 56]);
%Cropping the bottle cap

YCbCr_x=rgb2ycbcr(cropped);
%converting the red, green, and blue values of cropped to luminance and chrominance of YCbCr.

blue_channel=YCbCr_x(:,:,2);
%selecting the blue channel

contrasted=imadjust(blue_channel);
%increasing the contrast

BlackWhite=imbinarize(contrasted, double(170/256));
%creating a binary image from image contrasted using the threshold

Blackpixel=sum(BlackWhite(:)==0);
%detecting the black intensity 

Whitepixel=numel(BlackWhite(:));
%detecting the white intensity

percentage=(Blackpixel/Whitepixel);
%determination of the ratio of the black to the white.
end

if percentage >0.7
%If there is 70% or more black bottle cap is missing
    result=1;
else
    result=0;
%else bottle cap is not missing
end

if result==1
    fprintf('Bottle cap does not exist.')
else 
    fprintf('Bottle cap is here.')

end
%Printing the results to the user
