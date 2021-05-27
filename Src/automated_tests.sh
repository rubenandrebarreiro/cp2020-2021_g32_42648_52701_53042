# Concurrency and Parallelism
# Assignment #1: Storms of High-Energy Particles
# Integrated Master in Computer Science and Engineering
# Authors:
# - Joao Soares
# - Martim Figueiredo
# - Ruben Barreiro
# Instructors:
# - Joao Manuel Lourenco

# Bash/Shell Script File for the execution of the Automated Tests

DEBUG_RECORDS=true

# Test 01.1 - Tested for Sequential Version(s)
# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_01_1=("test_files/test_01_a35_p5_w3"
                                "test_files/test_01_a35_p7_w2"
                                "test_files/test_01_a35_p8_w1"
                                "test_files/test_01_a35_p8_w4")


# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_01_2=("test_files/test_01_a35_p5_w3 test_files/test_01_a35_p7_w2"
                                "test_files/test_01_a35_p5_w3 test_files/test_01_a35_p5_w1"
                                "test_files/test_01_a35_p5_w3 test_files/test_01_a35_p5_w4"
                                "test_files/test_01_a35_p7_w2 test_files/test_01_a35_p5_w1"
                                "test_files/test_01_a35_p7_w2 test_files/test_01_a35_p5_w4"
                                "test_files/test_01_a35_p5_w1 test_files/test_01_a35_p5_w4")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_01_3=("test_files/test_01_a35_p5_w3 test_files/test_01_a35_p7_w2 test_files/test_01_a35_p8_w1"
                                "test_files/test_01_a35_p5_w3 test_files/test_01_a35_p7_w2 test_files/test_01_a35_p8_w4"
                                "test_files/test_01_a35_p5_w3 test_files/test_01_a35_p8_w1 test_files/test_01_a35_p8_w4"
                                "test_files/test_01_a35_p7_w2 test_files/test_01_a35_p8_w1 test_files/test_01_a35_p8_w4")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_01_4=("test_files/test_01_a35_p5_w3 test_files/test_01_a35_p7_w2 test_files/test_01_a35_p8_w1 test_files/test_01_a35_p8_w4")

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_01_1="1000 10000 100000 1000000 10000000 100000000 500000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_2="10 50 100 500 1000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_3="1000 10000 100000 1000000 10000000 100000000 1000000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_4="1000 10000 100000 1000000 10000000 100000000 1000000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_5="1000 10000 100000 1000000 10000000 100000000 1000000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_6="1000 10000 100000 1000000 10000000 100000000 1000000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_7="10 50 100"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_8="10 50 100"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_9="1000 10000 100000 1000000 10000000 100000000 1000000000"

FILE_NAMES_EXEC_LIST=("${FILE_NAMES_EXEC_LIST_TEST_01_1[@]}")
NUM_CONTROL_POINTS_LIST=$NUM_CONTROL_POINTS_LIST_TEST_01_1

TEST_SET_NUM="01_1"
NUM_THREADS_LIST="1 2 4 6 8 12"

NUM_EXECS="5"

if [[ "$DEBUG_RECORDS" == true ]]
then
  echo $'\n'
  echo "Execution of Automated Tests and the extraction of their results started!!!"
  echo $'\n'
fi

for CURRENT_NUM_TEST in $(seq 1 "${#FILE_NAMES_EXEC_LIST[@]}"); do

  if [[ "$DEBUG_RECORDS" == true ]]
  then
    echo "Starting Sub-Test #$CURRENT_NUM_TEST of the Set {$TEST_SET_NUM}: ${FILE_NAMES_EXEC_LIST[CURRENT_NUM_TEST - 1]}"
  fi

  rm -f results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
  echo -n $'\n' > results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
  sed -i "1iTest Files: [ ${FILE_NAMES_EXEC_LIST[CURRENT_NUM_TEST - 1]} ]" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
  sed -i "2i," results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
  sed -i "3iNumber of Points, Execution Times in Seconds ($NUM_EXECS Runs/Executions)" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
  sed -i '4i, No. Exec.,,,,, Parallel with Multi-Threading' results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

  ROW_STRING='5i,, Sequential,,,, '
  NUM_TIMES_APPROACHES="1"

  for NUM_THREADS in $NUM_THREADS_LIST; do
    if [[ $NUM_THREADS -eq 1 ]]
    then
      ROW_STRING+="$NUM_THREADS Thread,,,, "
    else
      ROW_STRING+="$NUM_THREADS Threads,,,, "
    fi
    ((NUM_TIMES_APPROACHES+=1))
  done

  sed -i "$ROW_STRING" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

  ROW_STRING='6i,, '

  # shellcheck disable=SC2034
  for CURRENT_TIME_APPROACH in $(seq 1 "$NUM_TIMES_APPROACHES"); do
    ROW_STRING+='real, user, sys, main, '
  done

  sed -i "$ROW_STRING" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

  CURRENT_ROW="7"
  ROW_STRING=''

  for NUM_CONTROL_POINTS in $NUM_CONTROL_POINTS_LIST; do
    for NUM_EXEC in $(seq 1 $NUM_EXECS); do
      (time ./energy_storms_se "$NUM_CONTROL_POINTS" "${FILE_NAMES_EXEC_LIST[CURRENT_NUM_TEST - 1]}") > results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv 2>&1
      while IFS= read -r LINE
      do
        if [[ "$LINE" == *"Time: "* ]]
        then
          MAIN_TIME=$(echo "$LINE" | tr "Time: " "\n")
          MAIN_TIME="${MAIN_TIME:6:8}"
        fi
        if [[ "$LINE" == *"real"* ]]
        then
          REAL_TIME=$(echo "$LINE" | tr "reals " "\n")
          REAL_TIME="${REAL_TIME:7:5}"
        fi
        if [[ "$LINE" == *"user"* ]]
        then
          USER_TIME=$(echo "$LINE" | tr "user " "\n")
          USER_TIME="${USER_TIME:7:5}"
        fi
        if [[ "$LINE" == *"sys"* ]]
        then
          SYS_TIME=$(echo "$LINE" | tr "sy " "\n")
          SYS_TIME="${SYS_TIME:6:5}"
        fi
      done < results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv
      rm -f results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv
      if [[ $NUM_EXEC -eq 1 ]]
      then
        ROW_STRING+="$CURRENT_ROW""i""$NUM_CONTROL_POINTS, $NUM_EXEC, $REAL_TIME, $USER_TIME, $SYS_TIME, $MAIN_TIME, "
      else
        ROW_STRING+="$CURRENT_ROW""i"", $NUM_EXEC, $REAL_TIME, $USER_TIME, $SYS_TIME, $MAIN_TIME, "
      fi
      # shellcheck disable=SC2027
      # shellcheck disable=SC2086
      if [[ "$DEBUG_RECORDS" == true ]]
      then
        echo "Recording: [control_points="$NUM_CONTROL_POINTS" ; exec_num="$NUM_EXEC" ; real_time="$REAL_TIME" ; user_time="$USER_TIME" ; sys_time="$SYS_TIME" ; main_time="$MAIN_TIME"]"
      fi
      sed -i "$ROW_STRING" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
      ROW_STRING=''
      ((CURRENT_ROW+=1))
    done
  done

  if [[ "$DEBUG_RECORDS" == true ]]
  then
    echo $'\n'
  fi

done

if [[ "$DEBUG_RECORDS" == true ]]
then
  echo $'\n'
  echo "Execution of Automated Tests and the extraction of their results finished!!!"
  echo $'\n'
fi