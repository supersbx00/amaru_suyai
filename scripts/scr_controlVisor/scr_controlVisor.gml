function scr_controlVisor() {
if (posCursor < visorRange_min && visorRange_min == 0)
{
    visorRange_min = 18;
    visorRange_max = 26;
    posCursor = 26;
}

if (posCursor < visorRange_min && visorRange_min != 0)
{
    visorRange_min -= 3;
    visorRange_max -= 3;
}

if (posCursor > visorRange_max && visorRange_max == 26)
{
    visorRange_min = 0;
    visorRange_max = 8;
    posCursor = 0;
}

if (posCursor > visorRange_max && visorRange_max != 26)
{
    visorRange_min += 3;
    visorRange_max += 3;
}
}
