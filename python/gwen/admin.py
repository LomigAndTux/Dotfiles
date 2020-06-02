#!/usr/bin/env python

import psutil

def checkProcess(processName):
    '''
    Vérifie s'il y a un process déjà existant
    '''
    processList = []

    for proc in psutil.process_iter():
        try:
            if processName.lower() in proc.name().lower():
                processList.append(proc.cmdline())
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass

    return processList
