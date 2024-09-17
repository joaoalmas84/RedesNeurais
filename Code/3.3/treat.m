addpath("utils");

fprintf("\n[TREAT_DATASET] Calling translate.m");
translate();

fprintf("\n[TREAT_DATASET] Calling cbr.m\n");
cbr();
fprintf("\n[TREAT_DATASET] Train dataset treated\n")