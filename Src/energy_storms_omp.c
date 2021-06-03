/*
 * Simplified simulation of high-energy particle storms
 *
 * Parallel computing (Degree in Computer Engineering)
 * 2017/2018
 *
 * Version: 2.0
 *
 * OpenMP code.
 *
 * (c) 2018 Arturo Gonzalez-Escribano, Eduardo Rodriguez-Gutiez
 * Grupo Trasgo, Universidad de Valladolid (Spain)
 *
 * This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
 * https://creativecommons.org/licenses/by-sa/4.0/
 */
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<sys/time.h>
#include "omp.h"

/* Function to compute the wall time */
double compute_wall_time(){

    struct timeval tv;
    gettimeofday(&tv, NULL);

    return (double) tv.tv_sec + (1.0e-6 * (double) tv.tv_usec);
}

#define THRESHOLD    0.001f

/* Structure used to store data for one storm of particles */
typedef struct {
    int size;    // Number of particles
    int *position_values; // Positions and values
} Storm;

/* THIS FUNCTION CAN BE MODIFIED */
/* Function to update a single position of the layer */
void update(float *layer, int layer_size, int cell, int position, float energy) {

    /* 1. Compute the absolute value of the distance between the
        impact position and the k-th position of the layer */
    int distance = (position - cell);

    if(distance < 0) {
        distance = - distance;
    }

    /* 2. Impact cell has a distance value of 1 */
    distance = (distance + 1);

    /* 3. Square root of the distance */
    /* NOTE: Real world attenuation typically depends on the square of the distance.
       We use here a tailored equation that affects a much wider range of cells */
    float attenuation = sqrtf( (float) distance );

    /* 4. Compute attenuated energy */
    float energy_k = energy / layer_size / attenuation; // NOLINT(cppcoreguidelines-narrowing-conversions)

    /* 5. Do not add if its absolute value is lower than the threshold */
    if ( ( energy_k >= (THRESHOLD / layer_size) ) || ( energy_k <= (-THRESHOLD / layer_size) ) ) { // NOLINT(cppcoreguidelines-narrowing-conversions)
        layer[cell] = (layer[cell] + energy_k);
    }

}

/* Initialise the Layer (and its copies) */
void initialise_layers(float *layer, float *layer_copy_1, float *layer_copy_2, float *layer_copy_3, int layer_position_offset, int num_positions_in_layer_for_thread) {

    // For each Position in Layer to be initialised, individually, in Parallel, by the last Thread
    for(int current_position_in_layer_thread = 0; current_position_in_layer_thread < num_positions_in_layer_for_thread; current_position_in_layer_thread++) {

        // Initialisations of the Layer and Layer's Copy made sequentially, in Code Fusion
        layer[(layer_position_offset + current_position_in_layer_thread)] = 0.0f;
        layer_copy_1[(layer_position_offset + current_position_in_layer_thread)] = 0.0f;
        layer_copy_2[(layer_position_offset + current_position_in_layer_thread)] = 0.0f;
        layer_copy_3[(layer_position_offset + current_position_in_layer_thread)] = 0.0f;

    }

}

void add_impact_energies_to_layer_cells(int num_particles, const int *position_values, int particles_offset, float *layer_thread, int layer_size) {

    /* 4.1. Add impacts energies to layer cells */
    /* For each particle */
    for(int current_particle = 0; current_particle < num_particles; current_particle++) {

        /* Get impact energy (expressed in thousandths) */
        float energy = (float) (position_values[(particles_offset + (current_particle * 2) + 1)] * 1000);

        /* Get impact position */
        int position = position_values[(particles_offset + (current_particle * 2))];

        /* For each cell in the layer */
        for(int current_cell = 0; current_cell < layer_size; current_cell++) {

            /* Update the energy value for the cell */
            update(layer_thread, layer_size, current_cell,  position, energy);

        }

    }

}

/* ANCILLARY FUNCTIONS: These are not called from the code section which is measured, leave untouched */
/* DEBUG function: Prints the layer status */
void debug_print(int layer_size, float *layer, const int *positions, const float *maximum, int num_storms ) {

    int i, k;

    /* Only print for array size up to 35 (change it for bigger sizes if needed) */
    if (layer_size <= 35) {

        /* Traverse the Layer */
        for(k=0; k < layer_size; k++) {

            /* Print the energy value of the current cell */
            printf("%10.4f |", layer[k]);

            /* Compute the number of characters. 
               This number is normalized, the maximum level is depicted with 60 characters */
            int ticks = (int)( 60 * layer[k] / maximum[(num_storms - 1)] );

            /* Print all characters except the last one */
            for(i=0; i < (ticks - 1); i++) {
                printf("o");
            }

            /* If the cell is a local maximum print a special trailing character */
            if((k > 0) && (k < (layer_size - 1)) && (layer[k] > layer[(k - 1)]) && (layer[k] > layer[(k + 1)]) ) {
                printf("x");
            }
            else {
                printf("o");
            }

            /* If the cell is the maximum of any storm, print the storm mark */
            for(i=0; i < num_storms; i++) {

                if (positions[i] == k) {
                    printf(" M%d", i);
                }

            }

            /* Line feed */
            printf("\n");

        }

    }

}

/*
 * Function: Read data of particle storms from a file
 */
Storm read_storm_file(char *filename) {

    FILE *file_storm = fopen(filename, "r" );

    if(file_storm == NULL ) {
        fprintf(stderr, "Error: Opening storm file %s\n", filename);
        exit( EXIT_FAILURE );
    }

    Storm storm;
    int ok = fscanf(file_storm, "%d", &(storm.size) ); // NOLINT(cert-err34-c)

    if(ok != 1) {
        fprintf(stderr, "Error: Reading size of storm file %s\n", filename);
        exit( EXIT_FAILURE );
    }

    storm.position_values = (int *) malloc(sizeof(int) * storm.size * 2 );

    if(storm.position_values == NULL) {
        fprintf(stderr, "Error: Allocating memory for storm file %s, with size %d\n", filename, storm.size );
        exit( EXIT_FAILURE );
    }

    int elem;

    for(elem=0; elem < storm.size; elem++) {
        ok = fscanf(file_storm, "%d %d\n", // NOLINT(cert-err34-c)
                    &(storm.position_values[(elem * 2)]),
                    &(storm.position_values[((elem * 2) + 1)]) );

        if(ok != 2) {
            fprintf(stderr, "Error: Reading element %d in storm file %s\n", elem, filename );
            exit( EXIT_FAILURE );
        }

    }

    fclose(file_storm);

    return storm;

}

/*
 * MAIN PROGRAM
 */
int main(int argc, char *argv[]) {

    int current_storm, current_cell;

    /* 1.1. Read arguments */
    if (argc < 4) {
        fprintf(stderr,"Usage: %s <num_threads> <layer_size> <storm_1_file> [ <storm_i_file> ] ... \n", argv[0] );
        exit( EXIT_FAILURE );
    }

    /* Retrieve the Number of Threads to use in the simulation */
    int num_threads = atoi(argv[1]); // NOLINT(cert-err34-c)

    /* Retrieve the size of the Layer */
    int layer_size = atoi(argv[2] ); // NOLINT(cert-err34-c)

    /* Retrieve the number of Storms */
    int num_storms = (argc - 3);

    /* Create the array of Storms */
    Storm storms[num_storms];

    /* 1.2. Read storms information */
    for(current_storm=3; current_storm < argc; current_storm++) {
        storms[(current_storm - 3)] = read_storm_file(argv[current_storm]);
    }

    /* 1.3. Initialise maximum levels to zero */
    float global_maximum_energies[num_storms];
    int global_maximum_positions[num_storms];

    for(current_storm=0; current_storm < num_storms; current_storm++) {
        global_maximum_energies[current_storm] = 0.0f;
        global_maximum_positions[current_storm] = 0;
    }

    /* Initialise the private variables for the Threads' Identification */

    // The ID of the Thread (will be set as a Private Variable)
    int thread_id;

    // The current number of Thread (will be set as a Private Variable)
    int current_thread;

    // Set the number of Threads given, as argument,
    // as the flag of Number of Threads to be used by the OpenMP
    omp_set_num_threads(num_threads);

    /* 2. Begin time measurement */
    long double total_time = compute_wall_time();

    /* START: Do NOT optimize/parallelize the code of the main program above this point */

    /* 3. Allocate memory for the layer and initialise to zero */

    float *layer = (float *) malloc(sizeof(float) * layer_size);
    float *layer_copy_1 = (float *) malloc(sizeof(float) * layer_size);
    float *layer_copy_2 = (float *) malloc(sizeof(float) * layer_size);
    float *layer_copy_3 = (float *) malloc(sizeof(float) * layer_size);

    if(layer == NULL || layer_copy_1 == NULL || layer_copy_2 == NULL || layer_copy_3 == NULL) {
        fprintf(stderr,"Error: Allocating the layer memory\n");
        exit( EXIT_FAILURE );
    }

    // The number of Positions in the Layer, to be initialised, individually, by each Thread
    int num_positions_in_layer_per_thread = (layer_size / num_threads);

    // The number of remaining Positions in the Layer, to be initialised, by the last Thread
    int num_remaining_positions_in_layer_for_last_thread = (layer_size % num_threads);

    // The number of Positions in the Layer, to be initialised, by the last Thread
    // for the case of the total number of Positions in the Layer, to be initialised,
    // are not divisible for the number of Threads
    int num_positions_in_layer_for_last_thread = (num_positions_in_layer_per_thread + num_remaining_positions_in_layer_for_last_thread);

    // Parallel Loop, in OpenMP, for each Thread, individually:
    // - Private Variables for each Thread: thread_id, current_thread
    // - Number of Threads to be launched, in the Parallel Loop: num_threads
    // - Shared Variables by all the Threads: num_threads, num_positions_in_layer_per_thread
    // - NOTE: This loop is Embarrassingly Parallel and does not have any Loop-Carried Dependencies;
    #pragma omp parallel for private(thread_id, current_thread) num_threads(num_threads) shared(num_threads, num_positions_in_layer_per_thread, num_positions_in_layer_for_last_thread, layer, layer_copy_1, layer_copy_2, layer_copy_3)
    for(current_thread = 0; current_thread < num_threads; current_thread++) {

        // Set the Private Variable for the ID of the current Thread
        thread_id = omp_get_thread_num();

        // Compute the Offset for the Layer Position
        int layer_position_offset = (current_thread * num_positions_in_layer_per_thread);

        // If the current Thread's ID does not belong to the last Thread
        if(thread_id < (num_threads - 1)) {

            // Initialisations of the Layer and Layer's Copy made sequentially, in Code Fusion
            initialise_layers(layer, layer_copy_1, layer_copy_2, layer_copy_3, layer_position_offset, num_positions_in_layer_per_thread);

        }
        // If the current Thread's ID belongs to the last Thread
        else {

            // Initialisations of the Layer and Layer's Copy made sequentially, in Code Fusion
            initialise_layers(layer, layer_copy_1, layer_copy_2, layer_copy_3, layer_position_offset, num_positions_in_layer_for_last_thread);

        }

    }

    // Initialise the individual Layers for each Thread
    float* layers_threads[num_threads];

    // Parallel Loop, in OpenMP, for each Thread, individually:
    // - Private Variables for each Thread: thread_id, current_thread
    // - Number of Threads to be launched, in the Parallel Loop: num_threads
    // - Shared Variables by all the Threads: num_threads, num_positions_in_layer_per_thread
    // - NOTE: This loop is Embarrassingly Parallel and does not have any Loop-Carried Dependencies;
    #pragma omp parallel for private(thread_id, current_thread) num_threads(num_threads) shared(num_threads, layer_size, layers_threads)
    for(current_thread = 0; current_thread < num_threads; current_thread++) {

        // Set the Private Variable for the ID of the current Thread
        thread_id = omp_get_thread_num();

        layers_threads[thread_id] = (float *) malloc(sizeof(float) * layer_size);

        for(current_cell = 0; current_cell < layer_size; current_cell++) {

            layers_threads[thread_id][current_cell] = 0.0f;

        }

    }

    /* 4. Storms simulation */
    for(current_storm = 0; current_storm < num_storms; current_storm++) {

        // The the number of Particles of the single Storm (Input File)
        int num_particles = storms[current_storm].size;

        // The Position and Values of the Particles for the single Storm (Input File)
        int *particles = storms[current_storm].position_values;

        // The number of Particles, to be treated, individually, by each Thread
        int num_particles_per_thread = (num_particles / num_threads);

        // The number of remaining Particles, to be treated, individually, by the last Thread
        int num_remaining_particles_for_last_thread = (num_particles % num_threads);

        // The number of Particles, to be treated, individually, by the last Thread
        // for the case of the total number of Particles, to be treated,
        // are not divisible for the number of Threads
        int num_particles_for_last_thread = (num_particles_per_thread + num_remaining_particles_for_last_thread);

        /* 4.1. Add impacts energies to layer cells */
        /* For each particle */
        // Parallel Loop, in OpenMP, for each Thread, individually:
        // - Private Variables for each Thread: thread_id, current_thread
        // - Number of Threads to be launched, in the Parallel Loop: num_threads
        // - Shared Variables by all the Threads: num_threads, num_positions_in_layer_per_thread
        // - NOTE: This loop is Embarrassingly Parallel and does not have any Loop-Carried Dependencies;
        #pragma omp parallel for private(thread_id, current_thread) num_threads(num_threads) firstprivate(particles, num_particles_per_thread, num_particles_for_last_thread) shared(layers_threads, layer_size, num_threads)
        for (current_thread = 0; current_thread < num_threads; current_thread++) {

            // Set the Private Variable for the ID of the current Thread
            thread_id = omp_get_thread_num();

            // Compute the Offset for the size for the Particles' Pointer
            int particles_offset = (current_thread * (2 * num_particles_per_thread));

            // If the current Thread's ID does not belong to the last Thread
            if (thread_id < (num_threads - 1)) {

                /* 4.1. Add impacts energies to layer cells */

                // Add the Impact Energies to the Layer's Cells
                add_impact_energies_to_layer_cells(num_particles_per_thread, particles, particles_offset,
                                                   layers_threads[thread_id], layer_size);

            }
            // If the current Thread's ID belongs to the last Thread
            else {

                /* 4.1. Add impacts energies to layer cells */

                // Add the Impact Energies to the Layer's Cells
                add_impact_energies_to_layer_cells(num_particles_for_last_thread, particles, particles_offset,
                                                   layers_threads[thread_id], layer_size);

            }

        }

        // Merge of the individual intermediate results of
        // the Layer's copies of each Thread to the final Layer's results

        // For each Thread
        for (current_thread = 0; current_thread < num_threads; current_thread++) {

            // For each cell on the Layer
            for (current_cell = 0; current_cell < layer_size; current_cell++) {

                // Compute the final result for the current cell on the Layer
                float result = layer[current_cell] + layers_threads[current_thread][current_cell];

                // Copy the result values for the Layer's copies
                layer[current_cell] = result;
                layer_copy_1[current_cell] = result;
                layer_copy_2[current_cell] = result;
                layer_copy_3[current_cell] = result;

                // Initialise the Layer's copies, with the value 0
                layers_threads[current_thread][current_cell] = 0.0f;

            }

        }

        // The number of Particles, to be treated, individually, by each Thread
        int layer_size_per_thread = (layer_size / num_threads);

        // The number of remaining Particles, to be treated, individually, by the last Thread
        int remaining_size_for_last_thread = (layer_size % num_threads);

        // The number of Particles, to be treated, individually, by the last Thread
        // for the case of the total number of Particles, to be treated,
        // are not divisible for the number of Threads
        int layer_size_for_last_thread = (layer_size_per_thread + remaining_size_for_last_thread);

        // Create the energies of the Local Maximums for each Thread
        float local_maximum_energy[num_threads];

        // Create the positions of the Local Maximums for each Thread
        int local_maximum_position[num_threads];

        // Initialise the Local Maximums for each Thread
        for(current_thread = 0; current_thread < num_threads; current_thread++) {

            // Initialise the energy for the Local Maximums,
            // for the current Thread
            local_maximum_energy[current_thread] = 0.0f;

            // Initialise the position for the Local Maximums,
            // for the current Thread
            local_maximum_position[current_thread] = 0;

        }

        /* 4.1. Add impacts energies to layer cells */
        /* For each particle */
        // Parallel Loop, in OpenMP, for each Thread, individually:
        // - Private Variables for each Thread: thread_id, current_thread
        // - Number of Threads to be launched, in the Parallel Loop: num_threads
        // - Shared Variables by all the Threads: num_threads, num_positions_in_layer_per_thread
        // - NOTE: This loop is Embarrassingly Parallel and does not have any Loop-Carried Dependencies;
        #pragma omp parallel for private(thread_id, current_thread) num_threads(num_threads) shared(num_threads, layer_size_per_thread, layer, layer_copy_1, layer_copy_2, layer_copy_3, layer_size, local_maximum_energy, local_maximum_position)
        for(current_thread = 0; current_thread < num_threads; current_thread++) {

            // Set the Private Variable for the ID of the current Thread
            thread_id = omp_get_thread_num();

            // Compute the Offset for the size for the Particles' Pointer
            int layer_offset = (current_thread * layer_size_per_thread);

            // If the current Thread's ID does not belong to the last Thread
            if(thread_id < (num_threads - 1)) {

                // For each Cell in Layer, assigned to the current Thread
                for(current_cell = 1; current_cell < layer_size_per_thread; current_cell++) {

                    // Compute the Energy value for the last Local Maximum found, for the current Thread
                    float last_local_maximum_energy = layer[( layer_offset + current_cell - 1 )];

                    // Compute the Position value for the last Local Maximum found, for the current Thread
                    int last_local_maximum_position = (layer_offset + current_cell - 1);

                    // If it is the first Cell,
                    // from which is pretended to compute the corresponding Energy and Position
                    if(current_cell == 1) {

                        // Compute the Energy value for the last Local Maximum found, for the current Thread
                        last_local_maximum_energy = ((layer_copy_1[(layer_offset + current_cell - 2)] +
                                                      layer_copy_2[(layer_offset + current_cell - 1)] +
                                                      layer_copy_3[(layer_offset + current_cell)]) / 3);

                    }

                    // Compute the current Energy value, from the current Cell's neighbors
                    float current_energy_value = ((layer_copy_1[(layer_offset + current_cell - 1)] + layer_copy_2[(layer_offset + current_cell)] + layer_copy_3[(layer_offset + current_cell + 1)]) / 3);

                    // Update the Energy value, for the current Cell of the Layer
                    layer[(layer_offset + current_cell)] = current_energy_value;

                    // If the current Energy value is lower than
                    // the Energy value for the last Local Maximum found
                    if(current_energy_value < last_local_maximum_energy) {

                        // If it was found a new intermediate Local Maximum
                        if(last_local_maximum_energy > local_maximum_energy[current_thread]) {

                            // Update the Energy for the Local Maximum, of the current Thread
                            local_maximum_energy[current_thread] = last_local_maximum_energy;

                            // Update the Position for the Local Maximum, of the current Thread
                            local_maximum_position[current_thread] = last_local_maximum_position;

                        }

                    }

                }

            }
            // If the current Thread's ID belongs to the last Thread
            else {

                // For each Cell in Layer, assigned to the current Thread
                for (current_cell = 1; current_cell < layer_size_for_last_thread; current_cell++) {

                    // Compute the Energy value for the last Local Maximum found, for the current Thread
                    float last_local_maximum_energy = layer[( layer_offset + current_cell - 1 )];

                    // Compute the Position value for the last Local Maximum found, for the current Thread
                    int last_local_maximum_position = (layer_offset + current_cell - 1);

                    // If it is the first Cell,
                    // from which is pretended to compute the corresponding Energy and Position
                    if(current_cell == 1) {

                        // Compute the Energy value for the last Local Maximum found, for the current Thread
                        last_local_maximum_energy = ((layer_copy_1[(layer_offset + current_cell - 2)] + layer_copy_2[(layer_offset + current_cell - 1)] + layer_copy_3[(layer_offset + current_cell)]) / 3);

                    }

                    // Compute the current Energy value, from the current Cell's neighbors
                    float current_energy_value = ((layer_copy_1[(layer_offset + current_cell - 1)] + layer_copy_2[(layer_offset + current_cell)] + layer_copy_3[(layer_offset + current_cell + 1)]) / 3);

                    // Update the Energy value, for the current Cell of the Layer
                    layer[(layer_offset + current_cell)] = current_energy_value;

                    // If the current Energy value is lower than
                    // the Energy value for the last Local Maximum found
                    if(current_energy_value < last_local_maximum_energy) {

                        // If it was found a new intermediate Local Maximum
                        if(last_local_maximum_energy > local_maximum_energy[current_thread]) {

                            // Update the Energy for the Local Maximum, of the current Thread
                            local_maximum_energy[current_thread] = last_local_maximum_energy;

                            // Update the Position for the Local Maximum, of the current Thread
                            local_maximum_position[current_thread] = last_local_maximum_position;

                        }

                    }

                }

            }

        }

        // Initialise the Energy for the Global Maximum of the current Thread,
        // according to the 1st Local Maximum
        global_maximum_energies[current_storm] = local_maximum_energy[0];

        // Initialise the Position for the Global Maximum of the current Thread,
        // according to the 1st Local Maximum
        global_maximum_positions[current_storm] = local_maximum_position[0];

        // For each Thread launched
        for(current_thread = 1; current_thread < num_threads; current_thread++) {

            // Compute the Offset for the memory accesses made by the current Thread
            int offset = (current_thread * layer_size_per_thread);

            // Compute the Energy for the memory accesses made by the current Thread
            float thread_energy = ((layer_copy_1[(offset - 1)] + layer_copy_2[offset] + layer_copy_3[(offset + 1)]) / 3);

            // If the current Thread found a new Global Maximum of Energy
            if(thread_energy > global_maximum_energies[current_storm]) {

                // Update the energy for the Global Maximum for the current Storm,
                // according to the Energy value computed by the current Thread
                global_maximum_energies[current_storm] = thread_energy;

                // Update the Position for the Global Maximum for the current Storm,
                // according to the Offset computed by the current Thread
                global_maximum_positions[current_storm] = offset;

            }

            // If the energy of the Local Maximum for the current Thread is greater than
            // the Global Maximum for the current Storm
            if(local_maximum_energy[current_thread] > global_maximum_energies[current_storm]) {

                // Update the energy of the Global Maximum, for the current Storm
                global_maximum_energies[current_storm] = local_maximum_energy[current_thread];

                // Update the position of the Global Maximum, for the current Storm
                global_maximum_positions[current_storm] = local_maximum_position[current_thread];

            }

        }

    }

    /* END: Do NOT optimize/parallelize the code below this point */

    /* 5. End time measurement */
    total_time = (compute_wall_time() - total_time);

    /* 6. DEBUG: Plot the result (only for layers up to 35 points) */
    #ifdef DEBUG
    debug_print(layer_size, layer, global_maximum_positions, global_maximum_energies, num_storms);
    #endif

    /* 7. Results output, used by the Tablon online judge software */
    printf("\n");

    /* 7.1. Total computation time */
    printf("Time: %Lf\n", total_time);

    /* 7.2. Print the maximum levels */
    printf("Result:");

    // Fore each Storm
    for(current_storm=0; current_storm < num_storms; current_storm++) {

        // Print the Energy and Position for the Global Maximum of the current Storm
        printf(" %d %f", global_maximum_positions[current_storm], global_maximum_energies[current_storm]);

    }

    printf("\n");

    /* 8. Free resources */
    for(current_storm=0; current_storm < (argc - 3); current_storm++) {

        free(storms[current_storm].position_values);

    }

    /* 9. Program ended successfully */
    return 0;

}
