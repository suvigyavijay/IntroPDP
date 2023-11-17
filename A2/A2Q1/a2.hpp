/*  SUVIGYA
 *  VIJAY
 *  suvigyav
 */

#ifndef A2_HPP
#define A2_HPP

#include <vector>
#include <mpi.h>

// Function to determine the rank to which a value should be sent
int get_send_rank(int value, int size) {
    int send_rank;
    send_rank = (value + (size - 1)) / 2;
    return send_rank;
}

// Parallel sort function
void isort(std::vector<short int>& Xi, MPI_Comm comm) {
    int size, rank;

    // Get the size and rank of the MPI communicator
    MPI_Comm_size(comm, &size);
    MPI_Comm_rank(comm, &rank);

    // Get the local size of Xi
    int loc_n = Xi.size();

    // Loop over local array Xi
    std::vector<MPI_Request> requests(loc_n);
    for (int i = 0; i < loc_n; i++) {
        int send_rank = get_send_rank(Xi[i], size);

        // Non-blocking send the value to send_rank
        MPI_Isend(&Xi[i], 1, MPI_SHORT, send_rank, 0, comm, &requests[i]);
    }

    // Send STOP marker to all ranks
    for (int i = 0; i < size; i++) {
        MPI_Request request;
        MPI_Isend(nullptr, 0, MPI_SHORT, i, 0, comm, &request);
        requests.push_back(request);
    }

    // Receive possible values into buffers
    short int val1 = (2 * rank) - (size - 1);
    short int val2 = val1 + 1;
    std::vector<short int> vec_val1;
    std::vector<short int> vec_val2;

    // Receive messages until STOP marker is received from all sources
    int receivedStopMarkers = 0;
    while (receivedStopMarkers < size) {
        MPI_Status status;
        MPI_Probe(MPI_ANY_SOURCE, 0, comm, &status);

        // If a message is found, get the count and receive the data
        int count;
        if (MPI_Get_count(&status, MPI_SHORT, &count) == MPI_SUCCESS) {
            // Create buffer to receive the value
            std::vector<short int> recv_val(count);

            // Perform the blocking receive into the buffer
            MPI_Recv(recv_val.data(), count, MPI_SHORT, status.MPI_SOURCE, 0, comm, MPI_STATUS_IGNORE);

            // Check for STOP marker
            if (count == 0) {
                receivedStopMarkers++;
            } else {
                // Add received values to vec_val1 or vec_val2
                for (int i = 0; i < recv_val.size(); i++) {
                    if (recv_val[i] == val1) {
                        vec_val1.push_back(recv_val[i]);
                    } else if (recv_val[i] == val2) {
                        vec_val2.push_back(recv_val[i]);
                    } else {
                        printf("ERROR: received value %d is not %d or %d\n", recv_val[i], val1, val2);
                    }
                }
            }
        }
    }

    // Wait for all non-blocking sends to complete
    MPI_Waitall(requests.size(), requests.data(), MPI_STATUS_IGNORE);

    // Resize and overwrite Xi with concatenation of vec_val1 and vec_val2
    Xi.resize(vec_val1.size() + vec_val2.size());
    std::copy(vec_val1.begin(), vec_val1.end(), Xi.begin());
    std::copy(vec_val2.begin(), vec_val2.end(), Xi.begin() + vec_val1.size());

} // isort

#endif // A2_HPP
