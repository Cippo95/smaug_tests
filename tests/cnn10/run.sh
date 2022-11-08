#!/usr/bin/env bash

. ./model_files

cfg_home=`pwd`
gem5_dir=${ALADDIN_HOME}/../..
bmk_dir=`git rev-parse --show-toplevel`/../build/bin

${gem5_dir}/build/X86/gem5.opt \
  --debug-flags=Aladdin,HybridDatapath \
  --outdir=${cfg_home}/outputs \
  --stats-db-file=stats.db \
  ${gem5_dir}/configs/aladdin/aladdin_se.py \
  --num-cpus=1 \
  --mem-size=4GB \
  --mem-type=LPDDR4_3200_2x16  \
  --cpu-clock=2.5GHz \
  --cpu-type=DerivO3CPU \
  --ruby \
  --access-backing-store \
  --mem-channels=4 \
  --l1d_size=64kB \
  --l1i_size=64kB \
  --l1d_assoc=4 \
  --l1i_assoc=4 \
  --l1d_hit_latency=2 \
  --l1i_hit_latency=2 \
  --l2_hit_latency=20 \
  --l2_size=2MB \
  --l2_assoc=16 \
  --cacheline_size=32 \
  --accel_cfg_file=gem5.cfg \
  --fast-forward=10000000000 \
  -c ${bmk_dir}/smaug \
  -o "${topo_file} ${params_file} --sample-level=high --gem5 --debug-level=0 --num-accels=1" \
  > stdout 2> stderr
