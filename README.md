# smaug\_tests

In this repository I will upload some test I have done with SMAUG.  

SMAUG is a framework for simulation of systems for deep learning applications.  
SMAUG's repo: https://github.com/harvard-acc/smaug   

I use the docker image provided from SMAUG developers.  
Beware that compiling gem5-aladdin (needed by SMAUG) takes a lot of time (~8 hours on my PC).  

This folder should be copied in `/workspace/smaug/experiments/sims/`.  
To copy files from your pc to a docker volume you need to use docker cp, for example: `docker cp host:source container:destination`.   
Docker cp documentation: https://docs.docker.com/engine/reference/commandline/cp/    

I won't provide dynamic\_traces\_.gz because they are often >100MB and they would make this repository too big (run trace.sh to build them in case).  

I provide tests made for minerva, lenet5, cnn10, vgg16 and elu 16, because their model is provided with SMAUG and their simulation doesn't take too much time.  

My baseline system mimics the one in SMAUG paper at page 6: https://arxiv.org/pdf/1912.04481.pdf  
But it has only one CPU instead of eight (--num-cpu=1) because I find stats being more manageable this way.  

The configurations of the accelerators are the same as provided by SMAUG in their experiments folder for minerva (smv-accel.cfg and gem5.cfg).  

I have been able of testing also the systolic array that sadly works only for convolutions: folders with -sys appended have this enabled.  
I have enabled this appending `--use-systolic-array` to trace.sh and run.sh (where they call SMAUG binary) and copying in gem5.cfg the configuration of the systolic array from a file provided in SMAUG.  
Warning: elu16-sys doesn't end simulation for some reason, so stats are wrong, I'll try simulate it again soon.  

I also provide some script to analize the stats, run: `bash stats.sh PATH/TO/STATS.TXT`.  
There also sum.sh which is the script that stats.sh calls to calculate the total sum of a single stat.  
**It is work in progress:**
I really like how in SMAUG paper there's a breakdown of CPU time, DMA transfer and accelerator compute.
I think that I have found how they achieve their CPU time, but I'm still trying to extrapolate the other stats.
For now I'm working on this for the system without the systolic array.

Stats are also very big! to obtain something more compact I have analyzed them and made `useful_stats.txt`, **also this file is work in progress**. 
With `grep -f useful_stats.txt /PATH/TO/STATS.TXT` you can view (and save if you redirect the output) what for now seems to me that could help in some way.
