#!/bin/bash



#	Mellanox modules have to be removed before testing
sudo rmmod mlx4_ib
sudo rmmod mlx4_en
sudo rmmod mlx4_core


#	Broadcom module have to be removed before testing
sudo rmmod bnxt_en
