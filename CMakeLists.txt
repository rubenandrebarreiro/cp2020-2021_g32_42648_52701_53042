cmake_minimum_required(VERSION 3.19)
project(cp2020_2021_g32_42648_52701_53042)

set(CMAKE_CXX_STANDARD 14)

add_executable(cp2020_2021_g32_42648_52701_53042
        Src/test_files/README
        Src/test_files/test_01_a35_p5_w3
        Src/test_files/test_01_a35_p7_w2
        Src/test_files/test_01_a35_p8_w1
        Src/test_files/test_01_a35_p8_w4
        Src/test_files/test_02_a30k_p20k_w1
        Src/test_files/test_02_a30k_p20k_w2
        Src/test_files/test_02_a30k_p20k_w3
        Src/test_files/test_02_a30k_p20k_w4
        Src/test_files/test_02_a30k_p20k_w5
        Src/test_files/test_02_a30k_p20k_w6
        Src/test_files/test_03_a20_p4_w1
        Src/test_files/test_04_a20_p4_w1
        Src/test_files/test_05_a20_p4_w1
        Src/test_files/test_06_a20_p4_w1
        Src/test_files/test_07_a1M_p5k_w1
        Src/test_files/test_07_a1M_p5k_w2
        Src/test_files/test_07_a1M_p5k_w3
        Src/test_files/test_07_a1M_p5k_w4
        Src/test_files/test_08_a100M_p1_w1
        Src/test_files/test_08_a100M_p1_w2
        Src/test_files/test_08_a100M_p1_w3
        Src/test_files/test_09_a16-17_p3_w1
        Src/energy_storms.c
        Src/energy_storms_omp.c
        Src/LICENSE
        Src/Makefile
        Src/README
        Templates/IEEEtran/bare_jrnl_compsoc.pdf
        Templates/IEEEtran/bare_jrnl_compsoc.tex
        Templates/IEEEtran/changelog.txt
        Templates/IEEEtran/IEEEtran.cls
        Templates/IEEEtran/IEEEtran_HOWTO.pdf
        Templates/IEEEtran/README
        Templates/Trans_final_submission.docx
        "Project Assignment v1.0.pdf"
        README.md)
