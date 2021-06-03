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

# The Boolean Flag for the Debugging of the Records
DEBUG_RECORDS=true

# The Boolean Flag for the Exhaustive Extraction of Metrics
EXHAUSTIVE_METRICS=false

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_01_1=("test_files/test_01_a35_p8_w1")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_01_2=("test_files/test_01_a35_p5_w3 test_files/test_01_a35_p7_w2 test_files/test_01_a35_p8_w1"
                                "test_files/test_01_a35_p5_w3 test_files/test_01_a35_p7_w2 test_files/test_01_a35_p8_w4"
                                "test_files/test_01_a35_p5_w3 test_files/test_01_a35_p8_w1 test_files/test_01_a35_p8_w4"
                                "test_files/test_01_a35_p7_w2 test_files/test_01_a35_p8_w1 test_files/test_01_a35_p8_w4")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_02_1=("test_files/test_02_a30k_p20k_w1"
                                "test_files/test_02_a30k_p20k_w4")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_02_2=("test_files/test_02_a30k_p20k_w1 test_files/test_02_a30k_p20k_w6")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_03_1=("test_files/test_03_a20_p4_w1")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_04_1=("test_files/test_04_a20_p4_w1")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_05_1=("test_files/test_05_a20_p4_w1")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_06_1=("test_files/test_06_a20_p4_w1")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_03_04_05_06_1=("test_files/test_03_a20_p4_w1 test_files/test_04_a20_p4_w1 test_files/test_05_a20_p4_w1 test_files/test_06_a20_p4_w1")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_07_1=("test_files/test_07_a1M_p5k_w2")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_07_2=("test_files/test_07_a1M_p5k_w3 test_files/test_07_a1M_p5k_w4")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_08_1=("test_files/test_08_a100M_p1_w1"
                                "test_files/test_08_a100M_p1_w2"
                                "test_files/test_08_a100M_p1_w3")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_08_2=("test_files/test_08_a100M_p1_w1 test_files/test_08_a100M_p1_w3")

# shellcheck disable=SC2034
FILE_NAMES_EXEC_LIST_TEST_09_1=("test_files/test_09_a16-17_p3_w1")

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_01="1000 10000 100000 1000000 10000000 100000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_02="1000 10000 100000 500000 1000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_03="1000 10000 100000 1000000 10000000 100000000 500000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_04="1000 10000 100000 1000000 10000000 100000000 500000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_05="1000 10000 100000 1000000 10000000 100000000 500000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_06="1000 10000 100000 1000000 10000000 100000000 500000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_03_04_05_06="1000 10000 100000 1000000 10000000 100000000 500000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_07="1000 10000 100000 500000 1000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_08="1000 10000 100000 1000000 10000000 100000000 500000000"

# shellcheck disable=SC2034
NUM_CONTROL_POINTS_LIST_TEST_09="1000 10000 100000 1000000 10000000 100000000 500000000"

FILE_NAMES_EXEC_LIST=("${FILE_NAMES_EXEC_LIST_TEST_01_1[@]}")
NUM_CONTROL_POINTS_LIST=$NUM_CONTROL_POINTS_LIST_TEST_01

TEST_SET_NUM="01_1"
NUM_THREADS_LIST="1 2 4 6 8 12"

NUM_EXECS="10"

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

  # Extract exhaustively all the Metrics from the Automated Tests
  # (extract the Real, User, System and Main Times)
  if [[ "$EXHAUSTIVE_METRICS" == true ]]
  then

    sed -i "1iTest Files: [ ${FILE_NAMES_EXEC_LIST[CURRENT_NUM_TEST - 1]} ]" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
    sed -i "2i," results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
    sed -i "3iNumber of Points, Execution Times in Seconds ($NUM_EXECS Runs/Executions)" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
    sed -i '4i, No. Exec.,,,,, Parallel with Multi-Threading' results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

    ROW_STRING='5i,, Sequential,,,, '
    NUM_TIMES_APPROACHES="1"

    # For each Thread
    for NUM_THREADS in $NUM_THREADS_LIST; do
      # If it is the 1st Thread
      if [[ $NUM_THREADS -eq 1 ]]
      then
        ROW_STRING+="$NUM_THREADS Thread,,,, "
      # If it is one of the remaining Threads
      else
        ROW_STRING+="$NUM_THREADS Threads,,,, "
      fi
      ((NUM_TIMES_APPROACHES+=1))
    done

    # Write the Row String of the Header for the Dataset fulfillment
    sed -i "$ROW_STRING" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

    # Initialise the Row String for the Dataset fulfillment
    ROW_STRING='6i,, '

    # shellcheck disable=SC2034
    for CURRENT_TIME_APPROACH in $(seq 1 "$NUM_TIMES_APPROACHES"); do
      ROW_STRING+='real, user, sys, main, '
    done

    sed -i "$ROW_STRING" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

    CURRENT_ROW="7"

    # Initialise the Row String for the Dataset fulfillment
    ROW_STRING=""

    # For each Control Point in the Layer
    for NUM_CONTROL_POINTS in $NUM_CONTROL_POINTS_LIST; do

      # For each Execution scheduled
      for NUM_EXEC in $(seq 1 $NUM_EXECS); do

        # Call of the Sequential Version
        # shellcheck disable=SC2086
        (time ./energy_storms_seq "$NUM_CONTROL_POINTS" ${FILE_NAMES_EXEC_LIST[CURRENT_NUM_TEST - 1]}) > results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv 2>&1

        # If it is there still some line to be read
        while IFS= read -r LINE
        do
          # Retrieve the Main Time (from Program)
          if [[ "$LINE" == *"Time: "* ]]
          then
            MAIN_TIME=$(echo "$LINE" | tr "Time: " "\n")
            MAIN_TIME="${MAIN_TIME:6:8}"
          fi
          # Retrieve the Real Time (from Time Command, in Linux/Ubuntu)
          if [[ "$LINE" == *"real"* ]]
          then
            REAL_TIME=$(echo "$LINE" | tr "reals " "\n")
            REAL_TIME="${REAL_TIME:7:5}"
          fi
          # Retrieve the User Time (from Time Command, in Linux/Ubuntu)
          if [[ "$LINE" == *"user"* ]]
          then
            USER_TIME=$(echo "$LINE" | tr "user " "\n")
            USER_TIME="${USER_TIME:7:5}"
          fi
          # Retrieve the System Time (from Time Command, in Linux/Ubuntu)
          if [[ "$LINE" == *"sys"* ]]
          then
            SYS_TIME=$(echo "$LINE" | tr "sy " "\n")
            SYS_TIME="${SYS_TIME:6:5}"
          fi

        # Write the Results for the Temporary File of the Results
        done < results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv

        # Remove the previously created Temporary File of the Results
        rm -f results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv

        # If it is the 1st Execution scheduled
        if [[ $NUM_EXEC -eq 1 ]]
        then
          # Append the Information of the Test Results of the Sequential Version
          # (for the case of the 1st Execution, it is also necessary to include the number of the Control Points)
          ROW_STRING+="$CURRENT_ROW""i""$NUM_CONTROL_POINTS, $NUM_EXEC, $REAL_TIME, $USER_TIME, $SYS_TIME, $MAIN_TIME, "
        # If it is one of the remaining Executions scheduled
        else
          # Append the Information of the Test Results of the Sequential Version
          # (for the case of the remaining Executions, it is not necessary to include the number of the Control Points)
          ROW_STRING+="$CURRENT_ROW""i"", $NUM_EXEC, $REAL_TIME, $USER_TIME, $SYS_TIME, $MAIN_TIME, "
        fi

        # shellcheck disable=SC2027
        # shellcheck disable=SC2086
        if [[ "$DEBUG_RECORDS" == true ]]
        then
          echo "Recording Sequential Version: [control_points="$NUM_CONTROL_POINTS" ; exec_num="$NUM_EXEC" ; real_time="$REAL_TIME" ; user_time="$USER_TIME" ; sys_time="$SYS_TIME" ; main_time="$MAIN_TIME"]"
        fi

        # Call of the Parallel Versions
        for NUM_THREADS in $NUM_THREADS_LIST; do
          # shellcheck disable=SC2086
          (time ./energy_storms_omp "$NUM_THREADS" "$NUM_CONTROL_POINTS" ${FILE_NAMES_EXEC_LIST[CURRENT_NUM_TEST - 1]}) > results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv 2>&1

          # If it is there still some line to be read
          while IFS= read -r LINE
          do
            # Retrieve the Main Time (from Program)
            if [[ "$LINE" == *"Time: "* ]]
            then
              MAIN_TIME=$(echo "$LINE" | tr "Time: " "\n")
              MAIN_TIME="${MAIN_TIME:6:8}"
            fi
            # Retrieve the Real Time (from Time Command, in Linux/Ubuntu)
            if [[ "$LINE" == *"real"* ]]
            then
              REAL_TIME=$(echo "$LINE" | tr "reals " "\n")
              REAL_TIME="${REAL_TIME:7:5}"
            fi
            # Retrieve the User Time (from Time Command, in Linux/Ubuntu)
            if [[ "$LINE" == *"user"* ]]
            then
              USER_TIME=$(echo "$LINE" | tr "user " "\n")
              USER_TIME="${USER_TIME:7:5}"
            fi
            # Retrieve the System Time (from Time Command, in Linux/Ubuntu)
            if [[ "$LINE" == *"sys"* ]]
            then
              SYS_TIME=$(echo "$LINE" | tr "sy " "\n")
              SYS_TIME="${SYS_TIME:6:5}"
            fi

          # Write the Results for the Temporary File of the Results for the current Parallel Version
          done < results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv

          # Remove the previously created Temporary File of the Results for the current Parallel Version
          rm -f results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv

          # Append the Information of the Test Results of the current Parallel Version
          ROW_STRING+="$REAL_TIME, $USER_TIME, $SYS_TIME, $MAIN_TIME, "

          # shellcheck disable=SC2027
          # shellcheck disable=SC2086
          if [[ "$DEBUG_RECORDS" == true ]]
          then
            echo "Recording Parallel Version ("$NUM_THREADS" Thread(s)): [control_points="$NUM_CONTROL_POINTS" ; exec_num="$NUM_EXEC" ; real_time="$REAL_TIME" ; user_time="$USER_TIME" ; sys_time="$SYS_TIME" ; main_time="$MAIN_TIME"]"
          fi

        done

        # Final write of the Row in the CSV file
        sed -i "$ROW_STRING" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

        # Reset the Row String for the Dataset fulfillment
        ROW_STRING=""

        # Increment the current Row counter
        ((CURRENT_ROW+=1))
      done
    done
  # Extract just the most important (and, always required) Metrics from the Automated Tests
  # (extract only the Main Times)
  else

    sed -i "1iTest Files: [ ${FILE_NAMES_EXEC_LIST[CURRENT_NUM_TEST - 1]} ]" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
    sed -i "2i," results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
    sed -i "3iNumber of Points, Execution Times in Seconds ($NUM_EXECS Runs/Executions)" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv
    sed -i '4i, No. Exec.,, Parallel with Multi-Threading' results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

    ROW_STRING='5i,, Sequential, '
    NUM_TIMES_APPROACHES="1"

    # For each Thread
    for NUM_THREADS in $NUM_THREADS_LIST; do
      # If it is the 1st Thread
      if [[ $NUM_THREADS -eq 1 ]]
      then
        ROW_STRING+="$NUM_THREADS Thread, "
      # If it is one of the remaining Threads
      else
        ROW_STRING+="$NUM_THREADS Threads, "
      fi
      ((NUM_TIMES_APPROACHES+=1))
    done

    # Write the Row String of the Header for the Dataset fulfillment
    sed -i "$ROW_STRING" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

    # Initialise the Row String for the Dataset fulfillment
    ROW_STRING='6i,, '

    # shellcheck disable=SC2034
    for CURRENT_TIME_APPROACH in $(seq 1 "$NUM_TIMES_APPROACHES"); do
      ROW_STRING+='main, '
    done

    sed -i "$ROW_STRING" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

    CURRENT_ROW="7"

    # Initialise the Row String for the Dataset fulfillment
    ROW_STRING=""

    # For each Control Point in the Layer
    for NUM_CONTROL_POINTS in $NUM_CONTROL_POINTS_LIST; do

      # For each Execution scheduled
      for NUM_EXEC in $(seq 1 $NUM_EXECS); do

        # Call of the Sequential Version
        # shellcheck disable=SC2086
        (time ./energy_storms_seq "$NUM_CONTROL_POINTS" ${FILE_NAMES_EXEC_LIST[CURRENT_NUM_TEST - 1]}) > results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv 2>&1

        # If it is there still some line to be read
        while IFS= read -r LINE
        do
          # Retrieve the Main Time (from Program)
          if [[ "$LINE" == *"Time: "* ]]
          then
            MAIN_TIME=$(echo "$LINE" | tr "Time: " "\n")
            MAIN_TIME="${MAIN_TIME:6:8}"
          fi

        # Write the Results for the Temporary File of the Results
        done < results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv

        # Remove the previously created Temporary File of the Results
        rm -f results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv

        # If it is the 1st Execution scheduled
        if [[ $NUM_EXEC -eq 1 ]]
        then
          # Append the Information of the Test Results of the Sequential Version
          # (for the case of the 1st Execution, it is also necessary to include the number of the Control Points)
          ROW_STRING+="$CURRENT_ROW""i""$NUM_CONTROL_POINTS, $NUM_EXEC, $MAIN_TIME, "
        # If it is one of the remaining Executions scheduled
        else
          # Append the Information of the Test Results of the Sequential Version
          # (for the case of the remaining Executions, it is not necessary to include the number of the Control Points)
          ROW_STRING+="$CURRENT_ROW""i"", $NUM_EXEC, $MAIN_TIME, "
        fi

        # shellcheck disable=SC2027
        # shellcheck disable=SC2086
        if [[ "$DEBUG_RECORDS" == true ]]
        then
          echo "Recording Sequential Version: [control_points="$NUM_CONTROL_POINTS" ; exec_num="$NUM_EXEC" ; main_time="$MAIN_TIME"]"
        fi

        # Call of the Parallel Versions
        for NUM_THREADS in $NUM_THREADS_LIST; do
          # shellcheck disable=SC2086
          (time ./energy_storms_omp "$NUM_THREADS" "$NUM_CONTROL_POINTS" ${FILE_NAMES_EXEC_LIST[CURRENT_NUM_TEST - 1]}) > results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv 2>&1

          # If it is there still some line to be read
          while IFS= read -r LINE
          do
            # Retrieve the Main Time (from Program)
            if [[ "$LINE" == *"Time: "* ]]
            then
              MAIN_TIME=$(echo "$LINE" | tr "Time: " "\n")
              MAIN_TIME="${MAIN_TIME:6:8}"
            fi

          # Write the Results for the Temporary File of the Results for the current Parallel Version
          done < results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv

          # Remove the previously created Temporary File of the Results for the current Parallel Version
          rm -f results_test_files/test_set_"$TEST_SET_NUM"/temporary_energy_storms_results.csv

          # Append the Information of the Test Results of the current Parallel Version
          ROW_STRING+="$MAIN_TIME, "

          # shellcheck disable=SC2027
          # shellcheck disable=SC2086
          if [[ "$DEBUG_RECORDS" == true ]]
          then
            echo "Recording Parallel Version ("$NUM_THREADS" Thread(s)): [control_points="$NUM_CONTROL_POINTS" ; exec_num="$NUM_EXEC" ; main_time="$MAIN_TIME"]"
          fi

        done

        # Final write of the Row in the CSV file
        sed -i "$ROW_STRING" results_test_files/test_set_"$TEST_SET_NUM"/test-"$CURRENT_NUM_TEST".csv

        # Reset the Row String for the Dataset fulfillment
        ROW_STRING=""

        # Increment the current Row counter
        ((CURRENT_ROW+=1))
      done
    done

  fi

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