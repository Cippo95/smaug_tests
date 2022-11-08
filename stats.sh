#!/bin/bash
echo -e "\nUseful stats, work in progress...\n"

simTicks=$(/bin/bash ./sum.sh sim_ticks $1)
echo "sim_ticks		" $simTicks
cpuOnTicks=$(/bin/bash ./sum.sh system.switch_cpus.pwrStateResidencyTicks::ON $1)
echo "onCycles		" $cpuOnTicks
simCycles=$(/bin/bash ./sum.sh system.acc0_datapath.sim_cycles $1)
echo "simCycles		" $simCycles
dmaSetupCycles=$(/bin/bash ./sum.sh system.acc0_datapath.dma_setup_cycles $1) 
echo "dma_setup_cycles	" $dmaSetupCycles

echo -e "\nPercent breakdown"

cpuTime=$(echo $cpuOnTicks $simTicks | awk '{print $1/$2}')
echo "CPU			" $cpuTime

simTime=$(echo $simCycles $simTicks | awk '{print $1*1000/$2}')
echo "Total accelerator	" $simTime

dmaTime=$(echo $dmaSetupCycles $simTicks | awk '{print $1*1000/$2}')
echo "DMA setup		" $dmaTime

accTime=$(echo $simCycles $dmaSetupCycles $simTicks | awk '{print ($1-$2)*1000/$3}')
echo "Accelerator only(?)	" $accTime

echo -e "\nCPU time is similar to SMAUG paper"
echo -e "Accelerator is not, still testing!\n"
