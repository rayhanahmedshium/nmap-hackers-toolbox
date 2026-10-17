#!/usr/bin/env bash
# Nmap demo workflow used in the CYB 301 Part II video.
# Run each command by hand in a Kali terminal, in order.
# Only scan targets you own or have permission to scan.
#   - 10.0.2.0/24     = my own VirtualBox NAT lab network (change to yours)
#   - scanme.nmap.org = practice host provided by the Nmap Project (keep scans light)

# Setup
nmap --version
ip -br a
mkdir -p scans
sudo nmap --script-updatedb

# 1. Host discovery: which hosts are online? (no port scan)
nmap -sn 10.0.2.0/24

# 2. Port scan: TCP connect scan of the top 100 ports, faster timing
nmap -sT -T4 -F scanme.nmap.org

# 3. Service version detection on the open ports
nmap -sV -p 22,80 scanme.nmap.org

# 4. Default NSE scripts + version detection, saved in all three formats
nmap -sC -sV -p 22,80 -oA scans/scanme_baseline scanme.nmap.org
ls -l scans
cat scans/scanme_baseline.nmap
grep open scans/scanme_baseline.gnmap

# 5. OS detection, kept fast with -T4 -F (may need sudo; unreliable behind NAT)
nmap -O -T4 -F scanme.nmap.org
