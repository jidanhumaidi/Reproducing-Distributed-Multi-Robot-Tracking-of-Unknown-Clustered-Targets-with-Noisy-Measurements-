# Reproduction of "Distributed Multi-Robot Tracking of Unknown Clustered Targets with Noisy Measurements" (ACC 2024)

This repository contains my reproduction attempt of the paper:  
**Shinkyu Park, Yifan Hou, Yannis Papelis, Danjue Chen, and Christos G. Cassandras.  
“Distributed Multi-Robot Tracking of Unknown Clustered Targets with Noisy Measurements.”  
American Control Conference (ACC), 2024.**

## 🎯 Objective
The goal of this reproduction is to understand the fundamentals of distributed multi-robot tracking, focusing on target clustering under noisy measurements.

## 🛠️ Implementation
- Implemented in **MATLAB** (simplified version)  
- Voronoi-based partitioning for robot allocation  
- Robots iteratively move toward the centroid of local targets  
- Compared **uniform vs clustered** target distributions  

## 📊 Results
- Robots waste coverage in uniform allocation  
- Voronoi allocation adapts robots naturally to clustered targets  
- Reproduction confirms the main qualitative result of the paper  

## 📂 Contents
- `Repro_1.m`, `Repro_2.m` → MATLAB scripts  
- `anim_uniform.mp4`, `anim_clustered.mp4`, `voronoi_tracking_hd.mp4` → simulation animations  
- `SLIDE_DECK_JIDAN.pptx` → presentation slides  

## 🎥 Presentation
Watch the 5-minute presentation on YouTube: [YouTube link]  

## 🔗 Author
Jidan Humaidi – Automation Engineering graduate (Diponegoro University, Indonesia)  
Preparing for PhD at KAUST (Spring 2026 intake).  
