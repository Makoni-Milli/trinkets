#tartan by Takudzwa Makoni (c) 2019
import tartan as t
import gc, os, subprocess

print("info: .h for help, .q to quit.")

canvas_size0 = input('canvas size (pixels): ')
while not str.isdigit(canvas_size0):
    if canvas_size0 == '.q':
        exit(0)
    elif canvas_size0[0:2] == '.h':
        t.help(canvas_size0)
        canvas_size0 = input('canvas size (pixels): ')
    else:
        print('error: canvas size must be an integer.')
        canvas_size0 = input('canvas size (pixels): ')

filename = input('path to threadcount file [ext]: ')
if filename[0] == "~":
    filename = os.path.expanduser(filename)

while not os.path.isfile(filename):
    if filename == '.q':
        exit(0)
        print('test')
    elif filename[0:2] == '.h':
        t.help(filename)
        filename = input('path to threadcount file [ext]: ')
        if filename[0] == "~":
            filename = os.path.expanduser(filename)
    else:
        print('error: no such file found.')
        filename = input('path to threadcount file [ext]: ')
        if filename[0] == "~":
            filename = os.path.expanduser(filename)

SorR = input('symmetric or repetitive pattern (s/r): ')
while SorR != 'r' and SorR != 's':
    if SorR == '.q':
        exit(0)
    elif SorR[0:2] == '.h':
        t.help(SorR)
        SoR = input('symmetric or repetitive pattern (s/r): ')
    else:
        print('error: you must choose either s or r')
        SorR = input('symmetric or repetitive pattern (s/r): ')

unit_length = 1
sett, canvas_size1, directory_check = t.modlist(filename,SorR, canvas_size0)
print('weaving...')
t.weaver(sett, canvas_size1, unit_length, directory_check)
gc.collect()
