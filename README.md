# smaug\_tests

In this repository I will upload some test I have done with SMAUG.  

SMAUG is a framework for simulation of systems for deep learning applications.  
You can find SMAUG's repo and more info here:  
https://github.com/harvard-acc/smaug   

I use the docker image provided from SMAUG developers.  
Beware that compiling gem5-aladdin which SMAUG needs is really slow.  

This folder should be copied in `/workspace/smaug/experiments/sims/`.  
To copy stuff from your pc to a docker volume you need to use a command like
this: `docker cp host:source container:destination`.   
Docker docs about cp: https://docs.docker.com/engine/reference/commandline/cp/    

I won't provide dynamic\_traces\_.gz because they are really heavy and they 
would make this repository too big (just run trace.sh if need them).  

I provide tests made for minerva, lenet5, cnn10, vgg16 and elu 16, because their
model is provided with SMAUG and their simulation doesn't take too much time.  

My baseline system mimics the one in SMAUG paper at page 6:  
https://arxiv.org/pdf/1912.04481.pdf

But it has only one CPU instead of eight (--num-cpu=1) because I find stats 
being more manageable this way.  

The configurations of the accelerators are the same as provided by SMAUG in 
their experiments folder for minerva (smv and gem5.cfg).  

I have been able of testing also the systolic array that sadly works only for
convolutions: folders with -sys appended have this enabled.  

I also provide some script to analize the stats.  
`bash stats.sh PATH/TO/STATS.TXT`  
sum.sh is the script that stats.sh calls to calculate the total of a single
stat.  

Right now I think that I have found how they achieve their CPU time.
Now I'm looking for the accelerator compute time and data transfer time, I have
found something but it is really different from what SMAUG devs/researchers have
shown.  
