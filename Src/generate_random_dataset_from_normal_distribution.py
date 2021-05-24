# Concurrency and Parallelism
# Assignment #1: Storms of High-Energy Particles
# Integrated Master in Computer Science and Engineering
# Authors:
# - Joao Soares
# - Martim Figueiredo
# - Ruben Barreiro
# Instructors:
# - Joao Manuel Lourenco

# Import the NumPy Python's Library, with the numpy alias
import numpy as numpy

from scipy.stats import truncnorm

TEST_FILES_ROOT = "Src/test_files"

LOWER_BOUND_POSITIONS = 0

UPPER_BOUND_POSITIONS = 30000

LOWER_BOUND_ENERGIES = 150

UPPER_BOUND_ENERGIES = 250

DIMINUTIVE_1K = 1000

FLAG_TEST_SET_NUM = "01"

INITIAL_NUM_PARTICLES = 10000

NUM_THREADS_LIST = [1, 2, 4, 6, 8, 12]


def get_truncated_normal_distribution(mean=0, standard_deviation=1, lower_bound=0, upper_bound=10):
    return truncnorm(((lower_bound - mean) / standard_deviation),
                     ((upper_bound - mean) / standard_deviation),
                     loc=mean, scale=standard_deviation)


# Function to generate a random dataset, from a Normal Distribution,
# and write it to a new file
def generate_dataset(num_test, initial_num_particles, num_threads_list):

    random_mean_positions = numpy.random.randint(LOWER_BOUND_POSITIONS, UPPER_BOUND_POSITIONS)

    random_mean_energies = numpy.random.randint(LOWER_BOUND_ENERGIES, UPPER_BOUND_ENERGIES)

    seed_truncated_normal_distribution_for_positions = \
        get_truncated_normal_distribution(random_mean_positions, random_mean_positions,
                                          LOWER_BOUND_POSITIONS, UPPER_BOUND_POSITIONS)

    seed_truncated_normal_distribution_for_energies = \
        get_truncated_normal_distribution(random_mean_energies, random_mean_energies,
                                          LOWER_BOUND_ENERGIES, UPPER_BOUND_ENERGIES)

    for num_threads in num_threads_list:

        current_num_particles = (num_threads * initial_num_particles)

        random_sample_positions = \
            seed_truncated_normal_distribution_for_positions.rvs(current_num_particles).astype(int)

        random_sample_energies = \
            seed_truncated_normal_distribution_for_energies.rvs(current_num_particles).astype(int)

        positions_diminutive_1k_upper_bound = int((UPPER_BOUND_POSITIONS / DIMINUTIVE_1K))
        num_particles_diminutive_1k = int((current_num_particles / DIMINUTIVE_1K))

        filename = "{}/scaled_test_{}_a{}k_p{}k".format(TEST_FILES_ROOT, num_test,
                                                        positions_diminutive_1k_upper_bound,
                                                        num_particles_diminutive_1k)

        file = open(filename, "w")

        file.write("{}\n".format(str(current_num_particles)))

        for current_particle_element in range(current_num_particles):
            file.write("{} {}\n".format(random_sample_positions[current_particle_element],
                                        random_sample_energies[current_particle_element]))

        file.close()


# Main method
if __name__ == "__main__":

    generate_dataset(FLAG_TEST, INITIAL_NUM_PARTICLES, NUM_THREADS_LIST)
