# SFM
This is a repository for a course work called &lt;&lt;Global reconstruction and uncalibrated cameras>> 2018/2019

Main files in MATLAB folder:

numbers.m -- file with function that finds fundamental matrix and distortion parameters

generate_right_way.m -- file with function that generates two sets of corresponsing points, two distortion parameters and fundamental         matrix by generating points in space, two camera models and random rotation and translation between them

fundamental_script.m -- script that uses numbers() function on generated data and compares found results with the intial data

ransac_on_gen.m -- script that uses RANSAC method for FL1L2 solver on generated data
