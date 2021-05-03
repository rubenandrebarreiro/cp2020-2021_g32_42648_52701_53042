FILE_NAMES="test_files/test_01_a35_p5_w3 test_files/test_01_a35_p7_w2 test_files/test_01_a35_p8_w1 test_files/test_01_a35_p8_w4 test_files/test_02_a30k_p20k_w1 test_files/test_02_a30k_p20k_w2 test_files/test_02_a30k_p20k_w3
test_files/test_02_a30k_p20k_w4 test_files/test_02_a30k_p20k_w5 test_files/test_02_a30k_p20k_w6 test_files/test_03_a20_p4_w1 test_files/test_04_a20_p4_w1 test_files/test_05_a20_p4_w1 test_files/test_06_a20_p4_w1 test_files/test_07_a1M_p5k_w1 test_files/test_07_a1M_p5k_w2
test_files/test_07_a1M_p5k_w3 test_files/test_07_a1M_p5k_w4 test_files/test_08_a100M_p1_w1 test_files/test_08_a100M_p1_w2 test_files/test_08_a100M_p1_w3 test_files/test_09_a16-17_p3_w1"
N_CELLS="10 20 30 35"
NUM_RUNS="10"

for FLN in $FILE_NAMES; do
  for N_CELLS in $N_CELLS; do
    for NR in $(seq 1 $NUM_RUNS); do
    # shellcheck disable=SC2028
    time ./energy_storms_seq "$N_CELLS" "$FLN"
    echo $'\n\n'
  done
done | tee energy_storms_results.csv
