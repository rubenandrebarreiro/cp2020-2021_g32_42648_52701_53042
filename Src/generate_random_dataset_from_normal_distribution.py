# Concurrency and Parallelism
# Assignment #1: Storms of High-Energy Particles
# Integrated Master in Computer Science and Engineering
# Authors:
# - Joao Soares
# - Martim Figueiredo
# - Ruben Barreiro
# Instructors:
# - Joao Manuel Lourenco

# Import Python's Libraries

# Import the NumPy Python's Library, with the numpy alias
import numpy as numpy

# Import the Truncated Normal Distribution from the Module Stats,
# from the SciPy Python's Library
from scipy.stats import truncnorm

# The Root for the Test Files
TEST_FILES_ROOT = "test_files"

# The Lower Bound for the Interval of Values,
# on the Samples of randomly generated Positions
LOWER_BOUND_POSITIONS = 0

# The Upper Bound for the Interval of Values,
# on the Samples of randomly generated Positions
UPPER_BOUND_POSITIONS = 30000

# The Lower Bound for the Interval of Values,
# on the Sample of randomly generated Energies
LOWER_BOUND_ENERGIES = 150

# The Upper Bound for the Interval of Values,
# on the Sample of randomly generated Energies
UPPER_BOUND_ENERGIES = 250

# The Diminutive for 1000 (one thousand)
# (just used for the format of the name of the files of the Datasets)
DIMINUTIVE_1K = 1000

# The list of the Flags for the Tests' Sets
FLAG_TEST_SET_NUM_LIST = ["02"]

# The Flag for the Test Set chosen
FLAG_TEST_SET_NUM = FLAG_TEST_SET_NUM_LIST[0]

# The number of Initial Particles (for T1)
INITIAL_NUM_PARTICLES = 100000

# The list of the number of Threads to be used
NUM_THREADS_LIST = [1, 2, 4, 6, 8, 12]


# Retrieve the Truncated Normal Distribution, given its parameters;
# - The Mean, the Standard Deviation, and the Lower Bounds of the Interval of values generated
def get_truncated_normal_distribution(mean=0, standard_deviation=1, lower_bound=0, upper_bound=10):
    return truncnorm(((lower_bound - mean) / standard_deviation),
                     ((upper_bound - mean) / standard_deviation),
                     loc=mean, scale=standard_deviation)


# Function to generate a random dataset, from a Normal Distribution,
# and write it to a new file
def generate_dataset(num_test, initial_num_particles, num_threads_list):

    # Compute a random value to be the Mean of the Positions of the Particles to be generated
    random_mean_positions = numpy.random.randint(LOWER_BOUND_POSITIONS, UPPER_BOUND_POSITIONS)

    # Compute a random value to be the Mean of the Energies of the Particles to be generated
    random_mean_energies = numpy.random.randint(LOWER_BOUND_ENERGIES, UPPER_BOUND_ENERGIES)

    # Retrieve the Seed, for the Truncated Normal Distribution,
    # for the case of the Positions of the Particles to be generated randomly
    seed_truncated_normal_distribution_for_positions = \
        get_truncated_normal_distribution(random_mean_positions, random_mean_positions,
                                          LOWER_BOUND_POSITIONS, UPPER_BOUND_POSITIONS)

    # Retrieve the Seed, for the Truncated Normal Distribution,
    # for the case of the Energies of the Particles to he generated randomly
    seed_truncated_normal_distribution_for_energies = \
        get_truncated_normal_distribution(random_mean_energies, random_mean_energies,
                                          LOWER_BOUND_ENERGIES, UPPER_BOUND_ENERGIES)

    # For each available Thread
    for num_threads in num_threads_list:

        # Set the number of Particles
        current_num_particles = (num_threads * initial_num_particles)

        # Compute the random sample for the positions of the Particles,
        # from the Truncated Normal Distribution
        random_sample_positions = \
            seed_truncated_normal_distribution_for_positions.rvs(current_num_particles).astype(int)

        # Compute the random sample for the Energies of the Particles,
        # from the Truncated Normal Distribution
        random_sample_energies = \
            seed_truncated_normal_distribution_for_energies.rvs(current_num_particles).astype(int)

        # Set the Diminutive for the Strings to be used in the Filename
        positions_diminutive_1k_upper_bound = int((UPPER_BOUND_POSITIONS / DIMINUTIVE_1K))
        num_particles_diminutive_1k = int((current_num_particles / DIMINUTIVE_1K))

        # Set the name of the file to be created/opened/written
        filename = "{}/scaled_test_{}_a{}k_p{}k".format(TEST_FILES_ROOT, num_test,
                                                        positions_diminutive_1k_upper_bound,
                                                        num_particles_diminutive_1k)
        # Print some debug information
        print("\n\nGenerating: {} ...\n".format(filename))

        # Open the file and creates it, if it does not exist
        file = open(filename, "w")

        # Write the 1st row of the file, with the number of the Particles
        file.write("{}\n".format(str(current_num_particles)))

        # For each Particle
        for current_particle_element in range(current_num_particles):

            # Write the Position and Energy of the current Particle
            file.write("{} {}\n".format(random_sample_positions[current_particle_element],
                                        random_sample_energies[current_particle_element]))

        # Close the file
        file.close()

        # Print some debug information
        print("Generated finished: {} ...\n".format(filename))


# Main method
if __name__ == "__main__":

    # Generate the Dataset for the Test
    generate_dataset(FLAG_TEST_SET_NUM, INITIAL_NUM_PARTICLES, NUM_THREADS_LIST)
